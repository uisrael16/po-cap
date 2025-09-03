annotate CatalogService.PurchaseOrders with @odata.draft.enabled;

annotate CatalogService.Suppliers with @UI : {
  LineItem : [
    { Value: ID },
    { Value: name, Label: 'Supplier' },
    { Value: email },
    { Value: phone }
  ],
  Identification : [
    { Value: name }
  ]
};

annotate CatalogService.Products with @UI : {
  LineItem : [
     { Value: ID },
    { Value: sku },
    { Value: Product_name, Label: 'Product N' },
    { Value: price },
    { Value: currency_code }
  ],
  Identification : [
    { Value: Product_name }
  ]
};


annotate CatalogService.PurchaseOrderItems with @UI : {
  HeaderInfo : {
    TypeName      : 'Purchase Order Item',
    TypeNamePlural: 'Purchase Order Items',
    Title         : { Value: product.name },
    Description   : { Value: lineAmount }
  },

  // Line item table (Object Page / List Report)
  LineItem : [
    { Value: ID, Label: 'Item ID' },
    { Value: parent_ID, Label: 'Purchase Order' },
    { Value: product.name, Label: 'Product' },
    { Value: quantity, Label: 'Quantity' },
    { Value: netPrice, Label: 'Net Price' },
    { Value: lineAmount, Label: 'Line Amount' },
    { Value: currency_code, Label: 'Currency' }
  ],

  // Fields visible in the Object Page header section
  Identification : [
    { Value: parent_ID, Label: 'Parent Purchase Order' },
    { Value: product.name, Label: 'Product' },
    { Value: quantity },
    { Value: netPrice },
    { Value: lineAmount },
    { Value: currency }
  ],

  // Filter fields in List Report / Object Page
  SelectionFields : [ parent, product, currency ]
};

