unit AlephCRM.Models.Products.Update;

interface

uses
  SysUtils,
  Neon.Core.Nullables,
  Neon.Core.Attributes,
  Neon.Core.Types,
  AlephCRM.Models.IdName,
  AlephCRM.Models.BaseModel;

{$M+}


type
  {$RTTI EXPLICIT METHODS([vcPrivate])}
  TAlephProductStockUpdate = class;
  TAlephProductPriceUpdate = class;
  TAlephProductsFeaturesUpdate = class;
  TAlephMeasurableQuantityUpdate = class;
  TAlephStockAlertUpdate = class;
  TAlephRelatedProductStockUpdate = class;
  TAlephMeasurablePriceUpdate = class;

  TAlephProductUpdateModel = class(TAlephBaseModel)
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
    function GetFeatures: TAlephProductsFeaturesUpdate;
    function GetPrice: TAlephProductPriceUpdate;
    function GetStock: TAlephProductStockUpdate;
    function ShouldInclude(const AContext: TNeonIgnoreIfContext): Boolean;
  public
    destructor Destroy; override;
  published
    [NeonIncludeAttribute(IncludeIf.NotDefault)]
    property Brand: string read FBrand write FBrand;
    [NeonIncludeAttribute(IncludeIf.Always)]
    property SKU: string read FSKU write FSKU;
    [NeonIncludeAttribute(IncludeIf.CustomFunction)]
    property Stock: TAlephProductStockUpdate read GetStock;
    [NeonIncludeAttribute(IncludeIf.CustomFunction)]
    property Price: TAlephProductPriceUpdate read GetPrice;
    [NeonIncludeAttribute(IncludeIf.CustomFunction)]
    property Features: TAlephProductsFeaturesUpdate read GetFeatures;
  end;

  TAlephProductStockUpdate = class(TAlephBaseModel)
  strict private
  [NeonNamedAttribute('Quantity')]
    FQuantity: NullInteger;
    [NeonNamedAttribute('B2BQuantity')]
    FB2BQuantity: NullInteger;
    [NeonNamedAttribute('Movement')]
    FMovement: NullInteger;
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
    function GetAlert: TAlephStockAlertUpdate;
    function GetMeasurableQuantity: TAlephMeasurableQuantityUpdate;
    function GetRelationships: TAlephRelatedProductStockUpdate;
    function ShouldInclude(const AContext: TNeonIgnoreIfContext): Boolean;
  public
    destructor Destroy; override;
  published
    [NeonIncludeAttribute(IncludeIf.NotNull)]
    property Quantity: NullInteger read FQuantity write FQuantity;

    [NeonIncludeAttribute(IncludeIf.NotNull)]
    property B2BQuantity: NullInteger read FB2BQuantity write FB2BQuantity;

    [NeonIncludeAttribute(IncludeIf.NotNull)]
    property Movement: NullInteger read FMovement write FMovement;

    [NeonIncludeAttribute(IncludeIf.NotNull)]
    property MinpublishedationQuantity: NullInteger read FMinpublishedationQuantity write FMinpublishedationQuantity;

    [NeonIncludeAttribute(IncludeIf.NotNull)]
    property MaxpublishedationQuantity: NullInteger read FMaxpublishedationQuantity write FMaxpublishedationQuantity;

    [NeonIncludeAttribute(IncludeIf.CustomFunction)]
    property MeasurableQuantity: TAlephMeasurableQuantityUpdate read GetMeasurableQuantity;

    [NeonIncludeAttribute(IncludeIf.CustomFunction)]
    property Alert: TAlephStockAlertUpdate read GetAlert;

    [NeonIncludeAttribute(IncludeIf.CustomFunction)]
    property Relationships: TAlephRelatedProductStockUpdate read GetRelationships;
  end;

  TAlephProductPriceUpdate = class(TAlephBaseModel)
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
    function GetMeasurablePriceWithTaxes: TAlephMeasurablePriceUpdate;
  public
    destructor Destroy; override;
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
    [NeonIncludeAttribute(IncludeIf.CustomFunction)]
    property MeasurablePriceWithTaxes: TAlephMeasurablePriceUpdate read GetMeasurablePriceWithTaxes;
  end;

  TAlephProductsFeaturesUpdate = class(TAlephBaseModel)
  strict private
  [NeonNamedAttribute('Visibility')]
    FVisibility: NullInteger;
  published
    [NeonIncludeAttribute(IncludeIf.Always)]
    property Visibility: NullInteger read FVisibility write FVisibility;
  end;

  TAlephMeasurableQuantityUpdate = class(TAlephBaseModel)
  strict private
  [NeonNamedAttribute('Quantity')]
    FQuantity: NullDouble;
    [NeonNamedAttribute('Unit')]
    FUnit: string;
  published
    [NeonIncludeAttribute(IncludeIf.Always)]
    property Quantity: NullDouble read FQuantity write FQuantity;
    [NeonIncludeAttribute(IncludeIf.Always)]
    property &Unit: string read FUnit write FUnit;
  end;

  TAlephStockAlertUpdate = class(TAlephBaseModel)
  strict private
  [NeonNamedAttribute('RedQty')]
    FRedQty: NullInteger;
    [NeonNamedAttribute('YellowQty')]
    FYellowQty: NullInteger;
  published
    [NeonIncludeAttribute(IncludeIf.Always)]
    property RedQty: NullInteger read FRedQty write FRedQty;
    [NeonIncludeAttribute(IncludeIf.Always)]
    property YellowQty: NullInteger read FYellowQty write FYellowQty;
  end;

  TAlephRelatedProductStockUpdate = class(TAlephBaseModel)
  strict private
  [NeonNamedAttribute('Related')]
    FRelated: TAlephIdName;
    [NeonNamedAttribute('Quantity')]
    FQuantity: Integer;
    function GetRelated: TAlephIdName;
  public
    destructor Destroy; override;
  published
    [NeonIncludeAttribute(IncludeIf.Always)]
    property Related: TAlephIdName read GetRelated;
    [NeonIncludeAttribute(IncludeIf.Always)]
    property Quantity: Integer read FQuantity write FQuantity;
  end;

  TAlephMeasurablePriceUpdate = class(TAlephBaseModel)
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

{ TAlephProductUpdateModel }

destructor TAlephProductUpdateModel.Destroy;
begin
  if Assigned(FFeatures) then
    FFeatures.Free;
  if Assigned(FPrice) then
    FPrice.Free;
  if Assigned(FStock) then
    FStock.Free;
  inherited;
end;

function TAlephProductUpdateModel.GetFeatures: TAlephProductsFeaturesUpdate;
begin
  if not Assigned(FFeatures) then
    FFeatures := TAlephProductsFeaturesUpdate.Create;
  Result := FFeatures;
end;

function TAlephProductUpdateModel.GetPrice: TAlephProductPriceUpdate;
begin
  if not Assigned(FPrice) then
    FPrice := TAlephProductPriceUpdate.Create;
  Result := FPrice;
end;

function TAlephProductUpdateModel.GetStock: TAlephProductStockUpdate;
begin
  if not Assigned(FStock) then
    FStock := TAlephProductStockUpdate.Create;
  Result := FStock;
end;

function TAlephProductUpdateModel.ShouldInclude(const AContext: TNeonIgnoreIfContext): Boolean;
begin
  Result := False;
  if SameText(AContext.MemberName, 'Stock') then
  begin
    Result := Stock.Quantity.HasValue or Stock.B2BQuantity.HasValue or Stock.Movement.HasValue or
      Stock.MinpublishedationQuantity.HasValue or Stock.MaxpublishedationQuantity.HasValue or
      (Stock.MeasurableQuantity.Quantity.HasValue) or (Stock.Alert.RedQty.HasValue or Stock.Alert.YellowQty.HasValue) or
      (Stock.Relationships.Quantity > 0);

  end
  else if SameText(AContext.MemberName, 'Price') then
  begin
    Result := (Price.Price > 0) or (Price.PriceWithTaxes > 0) or (Price.SuggestedRetailPrice > 0) or
      (Price.SalesMargin > 0) or (Price.B2BDiscountRate > 0) or (Price.Cost > 0) or (Price.MeasurablePriceWithTaxes.Price > 0);

  end
  else if SameText(AContext.MemberName, 'Features') then
  begin
    Result := Features.Visibility.HasValue;
  end;

end;

{ TAlephProductStockUpdate }

destructor TAlephProductStockUpdate.Destroy;
begin
  if Assigned(FAlert) then
    FAlert.Free;
  if Assigned(FMeasurableQuantity) then
    FMeasurableQuantity.Free;
  if Assigned(FRelationships) then
    FRelationships.Free;
  inherited;
end;

function TAlephProductStockUpdate.GetAlert: TAlephStockAlertUpdate;
begin
  if not Assigned(FAlert) then
    FAlert := TAlephStockAlertUpdate.Create;
  Result := FAlert;
end;

function TAlephProductStockUpdate.GetMeasurableQuantity: TAlephMeasurableQuantityUpdate;
begin
  if not Assigned(FMeasurableQuantity) then
    FMeasurableQuantity := TAlephMeasurableQuantityUpdate.Create;
  Result := FMeasurableQuantity;
end;

function TAlephProductStockUpdate.GetRelationships: TAlephRelatedProductStockUpdate;
begin
  if not Assigned(FRelationships) then
    FRelationships := TAlephRelatedProductStockUpdate.Create;
  Result := FRelationships;
end;

function TAlephProductStockUpdate.ShouldInclude(const AContext: TNeonIgnoreIfContext): Boolean;
begin
  Result := False;
  if SameText(AContext.MemberName, 'MeasurableQuantity') then
  begin
    Result := MeasurableQuantity.Quantity.HasValue;
  end
  else if SameText(AContext.MemberName, 'Alert') then
  begin
    Result := Alert.RedQty.HasValue or Alert.YellowQty.HasValue;
  end
  else if SameText(AContext.MemberName, 'Relationships') then
  begin
    Result := Relationships.Quantity > 0;
  end;
end;

{ TAlephProductPriceUpdate }

destructor TAlephProductPriceUpdate.Destroy;
begin
  if Assigned(FMeasurablePriceWithTaxes) then
    FMeasurablePriceWithTaxes.Free;
  inherited;
end;

function TAlephProductPriceUpdate.GetMeasurablePriceWithTaxes: TAlephMeasurablePriceUpdate;
begin
  if not Assigned(FMeasurablePriceWithTaxes) then
    FMeasurablePriceWithTaxes := TAlephMeasurablePriceUpdate.Create;
  Result := FMeasurablePriceWithTaxes;
end;

{ TAlephRelatedProductStockUpdate }

destructor TAlephRelatedProductStockUpdate.Destroy;
begin
  if Assigned(FRelated) then
    FRelated.Free;
  inherited;
end;

function TAlephRelatedProductStockUpdate.GetRelated: TAlephIdName;
begin
  if not Assigned(FRelated) then
    FRelated := TAlephIdName.Create;
  Result := FRelated;
end;

end.
