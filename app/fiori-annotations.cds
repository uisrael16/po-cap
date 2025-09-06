annotate CatalogService.PurchaseOrders with @odata.draft.enabled;


annotate CatalogService.Suppliers with @UI : {
  HeaderInfo : {
    TypeName       : 'Supplier',
    TypeNamePlural : 'Suppliers',
    Title          : { Value: name },
    Description    : { Value: email },          // Secondary info
    AdditionalInfo : { Value: phone },
    TypeImageUrl   : { Value: logoUrl }
  },

  // Identification block (object page details)
  Identification : [
    { $Type: 'UI.DataField', Value: ID,    Label: 'Supplier ID' },
    { $Type: 'UI.DataField', Value: name,  Label: 'Supplier Name' },
    { $Type: 'UI.DataFieldWithUrl', Value: email, Label: '📧 Email', Url: 'mailto:{email}' },
    { $Type: 'UI.DataFieldWithUrl', Value: phone, Label: '📞 Phone', Url: 'tel:{phone}' }
  ],

  // Table (List Report + sub-section in Object Page)
  LineItem : [
    { $Type: 'UI.DataField', Value: ID,    Label: 'Supplier ID', Importance: #High },
    { $Type: 'UI.DataField', Value: name,  Label: 'Supplier Name', Importance: #High },
    { $Type: 'UI.DataFieldWithUrl', Value: email, Label: '📧 Email', Url: 'mailto:{email}' },
    { $Type: 'UI.DataFieldWithUrl', Value: phone, Label: '📞 Phone', Url: 'tel:{phone}' }
  ],

  Facets : [
    {
      $Type  : 'UI.ReferenceFacet',
      Label  : 'General Information',
      Target : '@UI.Identification',
    },
    
  ],

  // Filters in List Report
  SelectionFields : [ ID, name, email, phone ]
};


annotate CatalogService.Products with @UI : {

  // Header section with main product info
  HeaderInfo : {
    TypeName       : 'Product',
    TypeNamePlural : 'Products',
    Title          : { Value: sku },
    Description    : { Value: Product_name },
    AdditionalInfo : { Value: price, Label: '💰 Price' },
    // TypeImageUrl   : { Value: 'https://dummyimage.com/80x80/0072c6/ffffff&text=' + sku }
  },

  // List report / table view
  LineItem : [
    { $Type: 'UI.DataField', Value: ID, Importance: #High, Label: '🆔 Product ID' },
    { $Type: 'UI.DataField', Value: sku, Importance: #High, Label: '📦 SKU' },
    { $Type: 'UI.DataField', Value: Product_name, Label: '📌 Product Name', Importance: #High },
    { $Type: 'UI.DataField', Value: price, Label: '💰 Price', Importance: #High },
    { $Type: 'UI.DataField', Value: currency_code, Label: '💱 Currency', Importance: #High }
  ],

  // Object Page details section — inline style
  Identification : [
    { $Type: 'UI.DataField', Value: ID, Label: '🆔 Product ID', LabelPlacement: #Inline },
    { $Type: 'UI.DataField', Value: sku, Label: '📦 SKU', LabelPlacement: #Inline },
    { $Type: 'UI.DataField', Value: Product_name, Label: '📌 Product Name', LabelPlacement: #Inline },
    { $Type: 'UI.DataField', Value: price, Label: '💰 Price', LabelPlacement: #Inline },
    { $Type: 'UI.DataField', Value: currency_code, Label: '💱 Currency', LabelPlacement: #Inline }
  ],

  // Object Page sections / facets
  Facets : [
    {
      $Type  : 'UI.ReferenceFacet',
      Label  : 'General Information',
      Target : '@UI.Identification',
      Position : 10
    }
  ]
};


annotate CatalogService.PurchaseOrders with @UI : {
    LineItem : [
        { Value: ID,          Label: 'PO ID' },
        { Value: docDate,     Label: 'Document Date' },
        { Value: status,      Label: 'Status' },
        { Value: totalAmount, Label: 'Total Amount' },
        { Value: currency_code, Label: 'Currency' }

    ],
    headerInfo: {
    typeName: 'Purchase Order',
    typeNamePlural: 'Purchase Orders',
    title: { value: ID },
    description: { value: supplier.name },
    
    identification: [
        { value: ID },
        { value: docDate },        // <-- annotationPath pointing to field
        { value: status }
    ]
}
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
    { $Type: 'UI.DataField', Value: currency_code, Label: '💰 Currency' }
  ],
  // Facets : [
  //   {
  //     $Type  : 'UI.ReferenceFacet',
  //     Label  : 'Order Items Information',
  //     Target : '@UI.Identification',
  //   },
  // ],

  // Fields visible in the Object Page header section
  Identification : [
    { Value: parent_ID, Label: 'Parent Purchase Order' },
    { Value: product.name, Label: 'Product' },
    { Value: quantity },
    { Value: netPrice },
    { Value: lineAmount },
    { $Type: 'UI.DataField', Value: currency_code, Label: '💰 Currency' }
  ],
  

  // Filter fields in List Report / Object Page
  SelectionFields : [ parent, product, currency ]
};

