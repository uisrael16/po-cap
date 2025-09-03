const cds = require('@sap/cds')

module.exports = cds.service.impl(async function() {
  const { PurchaseOrders, PurchaseOrderItems } = this.entities

  // Compute lineAmount before saving items
  this.before(['CREATE', 'UPDATE'], PurchaseOrderItems, (req) => {
    const { quantity, netPrice, currency } = req.data
    if (quantity != null && netPrice != null) {
      req.data.lineAmount = Number(quantity) * Number(netPrice)
    }
    if (currency) req.data.currency = currency
  })

  // Recalculate order total after item changes
  const recalc = async (hdrID, tx) => {
    const items = await tx.run(
      SELECT.from(PurchaseOrderItems).columns('lineAmount').where({ parent_ID: hdrID })
    )
    const total = items.reduce((s, i) => s + (i.lineAmount || 0), 0)
    await tx.run(UPDATE(PurchaseOrders, hdrID).set({ totalAmount: total }))
  }

  this.after(['CREATE', 'UPDATE', 'DELETE'], PurchaseOrderItems, async (_, req) => {
    const hdrID = req.data.parent_ID || req.data.parent?.ID
    if (hdrID) await recalc(hdrID, this.tx(req))
  })
})
