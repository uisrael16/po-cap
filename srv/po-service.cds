using my.po as po from '../db/schema';
using { cuid, managed, Currency  } from '@sap/cds/common';

service CatalogService @(path: '/odata/v4/catalog') {
  entity Suppliers         as projection on po.Supplier;
  entity Products          as projection on po.Product;
  entity PurchaseOrders    as projection on po.PurchaseOrder;
  entity PurchaseOrderItems as projection on po.PurchaseOrderItem;
  // entity Currencies as projection on po.Currency;
  // entity Currencies as projection on po.MyCurrency;  // <-- must be exposed
}
