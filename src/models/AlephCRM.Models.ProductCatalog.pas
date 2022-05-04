unit AlephCRM.Models.ProductCatalog;

interface

uses
  Generics.Collections,
  AlephCRM.Models.IdName,
  AlephCRM.Models.StockAlert,
  AlephCRM.Models.BaseModel;

{$M+}


type
  TAlephProductIdentification = class;
  TAlephProductStock = class;
  TAlephProductPriceGet = class;
  TAlephProductKitComponent = class;
  TAlephProductGroupedPublications = class;
  TAlephProductMeasurableQuantity = class;

  TAlephProductCatalog = class(TAlephBaseModel)
  strict private
    FIdentification: TAlephProductIdentification;
    FStock: TAlephProductStock;
    FPrice: TList<TAlephProductPriceGet>;
    FKits: TList<TAlephProductIdentification>;
    FKitComponents: TList<TAlephProductKitComponent>;
    FPublications: TList<TAlephProductGroupedPublications>;
  public
    constructor Create;
    destructor Destroy; override;

  published
    property Identification: TAlephProductIdentification read FIdentification write FIdentification;
    property Stock: TAlephProductStock read FStock write FStock;
    property Price: TList<TAlephProductPriceGet> read FPrice write FPrice;
    property Kits: TList<TAlephProductIdentification> read FKits write FKits;
    property KitComponents: TList<TAlephProductKitComponent> read FKitComponents write FKitComponents;
    property Publications: TList<TAlephProductGroupedPublications> read FPublications write FPublications;

  end;

  TAlephProductIdentification = class(TAlephBaseModel)
  strict private
    FId: Integer;
    FSKU: string;
    FOwnCode: string;
    FName: string;
    FBrand: TAlephIdName;
    FCatalogStatus: TAlephIdName;
  public
    constructor Create;
    destructor Destroy; override;

  published
    property Id: Integer read FId write FId;
    property SKU: string read FSKU write FSKU;
    property OwnCode: string read FOwnCode write FOwnCode;
    property Brand: TAlephIdName read FBrand write FBrand;
    property Name: string read FName write FName;
    property CatalogStatus: TAlephIdName read FCatalogStatus write FCatalogStatus;

  end;

  TAlephProductStock = class(TAlephBaseModel)
  private
    FQuantity: Integer;
    FPublishQuantity: Integer;
    FMinPublicationQuantity: Integer;
    FMaxPublicationQuantity: Integer;
    FMovement: Integer;
    FB2BQuantity: Integer;
    FAlert: TAlephStockAlert;
    FMeasurableQuantity: TAlephProductMeasurableQuantity;
  public
    constructor Create;
    destructor Destroy; override;

  published
    property Movement: Integer read FMovement write FMovement;
    property B2BQuantity: Integer read FB2BQuantity write FB2BQuantity;
    property Quantity: Integer read FQuantity write FQuantity;
    property PublishQuantity: Integer read FPublishQuantity write FPublishQuantity;
    property Alert: TAlephStockAlert read FAlert write FAlert;
    property MinPublicationQuantity: Integer read FMinPublicationQuantity write FMinPublicationQuantity;
    property MaxPublicationQuantity: Integer read FMaxPublicationQuantity write FMaxPublicationQuantity;
    property MeasurableQuantity: TAlephProductMeasurableQuantity read FMeasurableQuantity write FMeasurableQuantity;

  end;

  TAlephProductPriceGet = class(TAlephBaseModel)
  private
    FPrice: Double;
    FPriceWithTaxes: Double;
    FSuggestedRetailPrice: Double;
    FSuggestedRetailPriceAutoCalculated: Boolean;
    FPriceAutoCalculated: Boolean;
    FFinalPriceWithShippingCost: Double;
    FSalesMargin: Double;
    FPriceList: TAlephIdName;
    FCost: Double;
  public
    constructor Create;
    destructor Destroy; override;

  published
    property Price: Double read FPrice write FPrice;
    property PriceWithTaxes: Double read FPriceWithTaxes write FPriceWithTaxes;
    property SuggestedRetailPrice: Double read FSuggestedRetailPrice write FSuggestedRetailPrice;
    property SuggestedRetailPriceAutoCalculated: Boolean read FSuggestedRetailPriceAutoCalculated write FSuggestedRetailPriceAutoCalculated;
    property PriceAutoCalculated: Boolean read FPriceAutoCalculated write FPriceAutoCalculated;
    property FinalPriceWithShippingCost: Double read FFinalPriceWithShippingCost write FFinalPriceWithShippingCost;
    property SalesMargin: Double read FSalesMargin write FSalesMargin;
    property PriceList: TAlephIdName read FPriceList write FPriceList;
    property Cost: Double read FCost write FCost;

  end;

  TAlephProductKitComponent = class(TAlephBaseModel)
  private
    FIdentification: TAlephProductIdentification;
    FPrice: TList<TAlephProductPriceGet>;
    FStock: TAlephProductStock;
    FQuantity: Integer;
    FPrincipal: Boolean;
  public
    constructor Create;
    destructor Destroy; override;

  published
    property Identification: TAlephProductIdentification read FIdentification write FIdentification;
    property Price: TList<TAlephProductPriceGet> read FPrice write FPrice;
    property Stock: TAlephProductStock read FStock write FStock;
    property Quantity: Integer read FQuantity write FQuantity;
    property Principal: Boolean read FPrincipal write FPrincipal;

  end;

  TAlephProductGroupedPublications = class(TAlephBaseModel)
  private
    FMarketPlace: TAlephKeyValue;
    FDetails: TList<TAlephIdName>;
  public
    constructor Create;
    destructor Destroy; override;

  published
    property MarketPlace: TAlephKeyValue read FMarketPlace write FMarketPlace;
    property Details: TList<TAlephIdName> read FDetails write FDetails;

  end;

  TAlephProductMeasurableQuantity = class(TAlephBaseModel)
  private
    FQuantity: Double;
    FUnit: string;

  published
    property Quantity: Double read FQuantity write FQuantity;
    property &Unit: string read FUnit write FUnit;

  end;

implementation

{ TAlephProductCatalog }

constructor TAlephProductCatalog.Create;
begin
  FIdentification := TAlephProductIdentification.Create;
  FStock := TAlephProductStock.Create;
  FPrice := TList<TAlephProductPriceGet>.Create;
  FKits := TList<TAlephProductIdentification>.Create;
  FKitComponents := TList<TAlephProductKitComponent>.Create;
  FPublications := TList<TAlephProductGroupedPublications>.Create;
end;

destructor TAlephProductCatalog.Destroy;
var
  LObject: TObject;
begin
  FIdentification.Free;
  FStock.Free;
  for LObject in FPrice do
  begin
    LObject.Free;
  end;
  FPrice.Free;
  for LObject in FKits do
  begin
    LObject.Free;
  end;
  FKits.Free;
  for LObject in FKitComponents do
  begin
    LObject.Free;
  end;
  FKitComponents.Free;
  for LObject in FPublications do
  begin
    LObject.Free;
  end;
  FPublications.Free;

  inherited;
end;

{ TAlephProductIdentification }

constructor TAlephProductIdentification.Create;
begin
  FBrand := TAlephIdName.Create;
  FCatalogStatus := TAlephIdName.Create;
end;

destructor TAlephProductIdentification.Destroy;
begin
  FBrand.Free;
  FCatalogStatus.Free;
  inherited;
end;

{ TAlephProductStock }

constructor TAlephProductStock.Create;
begin
  FMeasurableQuantity := TAlephProductMeasurableQuantity.Create;
end;

destructor TAlephProductStock.Destroy;
begin
  FMeasurableQuantity.Free;
  inherited;
end;

{ TAlephProductPriceGet }

constructor TAlephProductPriceGet.Create;
begin
  FPriceList := TAlephIdName.Create;
end;

destructor TAlephProductPriceGet.Destroy;
begin
  FPriceList.Free;
  inherited;
end;

{ TAlephProductKitComponent }

constructor TAlephProductKitComponent.Create;
begin
  FIdentification := TAlephProductIdentification.Create;
  FPrice := TList<TAlephProductPriceGet>.Create;
  FStock := TAlephProductStock.Create;
end;

destructor TAlephProductKitComponent.Destroy;
var
  LObject: TObject;
begin
  FIdentification.Free;
  for LObject in FPrice do
  begin
    LObject.Free;
  end;
  FPrice.Free;
  FStock.Free;
  inherited;
end;

{ TAlephProductGroupedPublications }

constructor TAlephProductGroupedPublications.Create;
begin
  FMarketPlace := TAlephKeyValue.Create;
  FDetails := TList<TAlephIdName>.Create;
end;

destructor TAlephProductGroupedPublications.Destroy;
var
  LObject: TObject;
begin
  FMarketPlace.Free;
  for LObject in FDetails do
  begin
    LObject.Free;
  end;
  FDetails.Free;
  inherited;
end;

end.
