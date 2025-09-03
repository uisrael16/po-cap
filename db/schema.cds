namespace my.po;

using { cuid, managed, Currency } from '@sap/cds/common';

entity Supplier {
  key ID   : UUID;
  name     : String;
  email    : String;
  phone    : String;
}
entity Product {
  key ID   : UUID;
  sku      : String(30);
  Product_name     : String(100);
  price    : Decimal(9,2);
  currency : Currency;
}

entity PurchaseOrder :  managed {
   key ID         : String(20);
  supplier : Association to Supplier;   // foreign key supplier_ID auto-generated
  docDate  : Date;
  status   : String(20) default 'New';
  totalAmount : Decimal(11,2);
  currency : Currency;
  items    : Composition of many PurchaseOrderItem
             on items.parent = $self;
}

entity PurchaseOrderItem : cuid {
  parent  : Association to PurchaseOrder; // parent_ID auto-generated
  product : Association to Product;       // product_ID auto-generated
  quantity   : Integer default 1;
  netPrice   : Decimal(11,2);
  lineAmount : Decimal(11,2);
  currency   : Currency;
}

// entity MyCurrency {
//   key code : String(3);
//       name : String(50);
//       symbol : String(5);
// };


