unit AlephCRM.Models.Products.Update;

interface

uses
  Neon.Core.Nullables,
  Neon.Core.Attributes,
  AlephCRM.Models.IdName;

{$M+}

type
  TAlephProductStockUpdate = class;
  TAlephProductPriceUpdate = class;
  TAlephProductsFeaturesUpdate = class;
  TAlephMeasurableQuantityUpdate = class;
  TAlephStockAlertUpdate = class;
  TAlephRelatedProductStockUpdate = class;
  TAlephMeasurablePriceUpdate = class;

  TAlephProductUpdateModel = class
  strict private
    [NeonNamedAttribute('Brand')]
    FBrand: string;
    [NeonNamedAttribute('SKU')]
    FSKU: string;
    [NeonNamedAttribute('Stock')]
    FStock: TAlephProductStockUpdate;
    [NeonNamedAttribute('Price')]
    FPrice: TAlephProductPriceUpdate;
    [NeonNamedAttribute('Features')]
    FFeatures: TAlephProductsFeaturesUpdate;
  published
    [NeonIncludeAttribute(IncludeIf.NotDefault)]
    property Brand: string read FBrand write FBrand;
    [NeonIncludeAttribute(IncludeIf.Always)]
    property SKU: string read FSKU write FSKU;
    [NeonIncludeAttribute(IncludeIf.NotNull)]
    property Stock: TAlephProductStockUpdate read FStock write FStock;
    [NeonIncludeAttribute(IncludeIf.NotNull)]
    property Price: TAlephProductPriceUpdate read FPrice write FPrice;
    [NeonIncludeAttribute(IncludeIf.NotNull)]
    property Features: TAlephProductsFeaturesUpdate read FFeatures write FFeatures;
  end;

  TAlephProductStockUpdate = class
  private
    [NeonNamedAttribute('Quantity')]
    FQuantity: NullInteger;
    [NeonNamedAttribute('B2BQuantity')]
    FB2BQuantity: NullInteger;
    [NeonNamedAttribute('Movement')]
    FMovement: NullInteger;
    [NeonNamedAttribute('PublishQuantity')]
    FPublishQuantity: NullInteger;
    [NeonNamedAttribute('MinpublishedationQuantity')]
    FMinpublishedationQuantity: NullInteger;
    [NeonNamedAttribute('MaxpublishedationQuantity')]
    FMaxpublishedationQuantity: NullInteger;
    [NeonNamedAttribute('MeasurableQuantity')]
    FMeasurableQuantity: TAlephMeasurableQuantityUpdate;
    [NeonNamedAttribute('Alert')]
    FAlert: TAlephStockAlertUpdate;
    [NeonNamedAttribute('Relationships')]
    FRelationships: TAlephRelatedProductStockUpdate;
  published
    [NeonIncludeAttribute(IncludeIf.NotNull)]
    property Quantity: NullInteger read FQuantity write FQuantity;
    [NeonIncludeAttribute(IncludeIf.NotNull)]
    property B2BQuantity: NullInteger read FB2BQuantity write FB2BQuantity;
    [NeonIncludeAttribute(IncludeIf.NotNull)]
    property Movement: NullInteger read FMovement write FMovement;
    [NeonIncludeAttribute(IncludeIf.NotNull)]
    property PublishQuantity: NullInteger read FPublishQuantity write FPublishQuantity;
    [NeonIncludeAttribute(IncludeIf.NotNull)]
    property MinpublishedationQuantity: NullInteger read FMinpublishedationQuantity write FMinpublishedationQuantity;
    [NeonIncludeAttribute(IncludeIf.NotNull)]
    property MaxpublishedationQuantity: NullInteger read FMaxpublishedationQuantity write FMaxpublishedationQuantity;
    [NeonIncludeAttribute(IncludeIf.NotNull)]
    property MeasurableQuantity: TAlephMeasurableQuantityUpdate read FMeasurableQuantity write FMeasurableQuantity;
    [NeonIncludeAttribute(IncludeIf.NotNull)]
    property Alert: TAlephStockAlertUpdate read FAlert write FAlert;
    [NeonIncludeAttribute(IncludeIf.NotNull)]
    property Relationships: TAlephRelatedProductStockUpdate read FRelationships write FRelationships;
  end;

  TAlephProductPriceUpdate = class
  strict private
    [NeonNamedAttribute('Price')]
    FPrice: Currency;
    [NeonNamedAttribute('PriceWithTaxes')]
    FPriceWithTaxes: Currency;
    [NeonNamedAttribute('SuggestedRetailPrice')]
    FSuggestedRetailPrice: Currency;
    [NeonNamedAttribute('SalesMargin')]
    FSalesMargin: Currency;
    [NeonNamedAttribute('B2BDiscountRate')]
    FB2BDiscountRate: Currency;
    [NeonNamedAttribute('Cost')]
    FCost: Currency;
    [NeonNamedAttribute('MeasurablePriceWithTaxes')]
    FMeasurablePriceWithTaxes: TAlephMeasurablePriceUpdate;
  published
    [NeonIncludeAttribute(IncludeIf.NotDefault)]
    property Price: Currency read FPrice write FPrice;
    [NeonIncludeAttribute(IncludeIf.NotDefault)]
    property PriceWithTaxes: Currency read FPriceWithTaxes write FPriceWithTaxes;
    [NeonIncludeAttribute(IncludeIf.NotDefault)]
    property SuggestedRetailPrice: Currency read FSuggestedRetailPrice write FSuggestedRetailPrice;
    [NeonIncludeAttribute(IncludeIf.NotDefault)]
    property SalesMargin: Currency read FSalesMargin write FSalesMargin;
    [NeonIncludeAttribute(IncludeIf.NotDefault)]
    property B2BDiscountRate: Currency read FB2BDiscountRate write FB2BDiscountRate;
    [NeonIncludeAttribute(IncludeIf.NotDefault)]
    property Cost: Currency read FCost write FCost;
    [NeonIncludeAttribute(IncludeIf.NotNull)]
    property MeasurablePriceWithTaxes: TAlephMeasurablePriceUpdate read FMeasurablePriceWithTaxes write FMeasurablePriceWithTaxes;
  end;

  TAlephProductsFeaturesUpdate = class
  strict private
    [NeonNamedAttribute('Visibility')]
    FVisibility: Integer;
  published
    [NeonIncludeAttribute(IncludeIf.Always)]
    property Visibility: Integer read FVisibility write FVisibility;
  end;

  TAlephMeasurableQuantityUpdate = class
  strict private
    [NeonNamedAttribute('Quantity')]
    FQuantity: Double;
    [NeonNamedAttribute('Unit')]
    FUnit: string;
  published
    [NeonIncludeAttribute(IncludeIf.Always)]
    property Quantity: Double read FQuantity write FQuantity;
    [NeonIncludeAttribute(IncludeIf.Always)]
    property &Unit: string read FUnit write FUnit;
  end;


  TAlephStockAlertUpdate = class
  strict private
    [NeonNamedAttribute('RedQty')]
    FRedQty: Integer;
    [NeonNamedAttribute('YellowQty')]
    FYellowQty: Integer;
  published
    [NeonIncludeAttribute(IncludeIf.Always)]
    property RedQty: Integer read FRedQty write FRedQty;
    [NeonIncludeAttribute(IncludeIf.Always)]
    property YellowQty: Integer read FYellowQty write FYellowQty;
  end;

  TAlephRelatedProductStockUpdate = class
  strict private
    [NeonNamedAttribute('Related')]
    FRelated: TAlephIdName;
    [NeonNamedAttribute('Quantity')]
    FQuantity: Integer;
  published
    [NeonIncludeAttribute(IncludeIf.Always)]
    property Related: TAlephIdName read FRelated write FRelated;
    [NeonIncludeAttribute(IncludeIf.Always)]
    property Quantity: Integer read FQuantity write FQuantity;
  end;

  TAlephMeasurablePriceUpdate = class
  strict private
    [NeonNamedAttribute('Price')]
    FPrice: Currency;
    [NeonNamedAttribute('Unit')]
    FUnit: string;
  published
    [NeonIncludeAttribute(IncludeIf.Always)]
    property Price: Currency read FPrice write FPrice;
    [NeonIncludeAttribute(IncludeIf.Always)]
    property &Unit: string read FUnit write FUnit;
  end;


implementation

end.
