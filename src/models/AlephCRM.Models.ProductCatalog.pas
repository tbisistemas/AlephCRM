unit AlephCRM.Models.ProductCatalog;

interface

uses AlephCRM.Models.IdName, AlephCRM.Models.StockAlert;

type
  TAlephProductIdentification = class;
  TAlephProductStock = class;
  TAlephProductPriceGet = class;
  TAlephProductKitComponent = class;
  TAlephProductGroupedPublications = class;
  TAlephProductMeasurableQuantity = class;

  TAlephProductCatalog = class(TObject)
  strict private
    FIdentification: TAlephProductIdentification;
    FStock: TAlephProductStock;
    FPrice: TArray<TAlephProductPriceGet>;
    FKits: TArray<TAlephProductIdentification>;
    FKitComponents: TArray<TAlephProductKitComponent>;
    FPublications: TArray<TAlephProductGroupedPublications>;
    
  public
    property Identification: TAlephProductIdentification read FIdentification write FIdentification;
    property Stock: TAlephProductStock read FStock write FStock;
    property Price: TArray<TAlephProductPriceGet> read FPrice write FPrice;
    property Kits: TArray<TAlephProductIdentification> read FKits write FKits;
    property KitComponents: TArray<TAlephProductKitComponent> read FKitComponents write FKitComponents;
    property Publications: TArray<TAlephProductGroupedPublications> read FPublications write FPublications;

  end;

  TAlephProductIdentification = class(TObject)
  strict private
    FId: Integer;
    FSKU: string;
    FOwnCode: string;
    FName: string;
    FBrand: TAlephIdName;
    FCatalogStatus: TAlephIdName;

  public
    property Id: Integer read FId write FId;
    property SKU: string read FSKU write FSKU;
    property OwnCode: string read FOwnCode write FOwnCode;
    property Name: string read FName write FName;
    property Brand: TAlephIdName read FBrand write FBrand;
    property CatalogStatus: TAlephIdName read FCatalogStatus write FCatalogStatus;
    
  end;

  TAlephProductStock = class(TObject)
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
    property Movement : Integer read FMovement  write FMovement;
    property B2BQuantity: Integer read FB2BQuantity write FB2BQuantity;
    property Quantity: Integer read FQuantity write FQuantity;
    property PublishQuantity: Integer read FPublishQuantity write FPublishQuantity;
    property Alert: TAlephStockAlert read FAlert write FAlert;
    property MinPublicationQuantity: Integer read FMinPublicationQuantity write FMinPublicationQuantity;
    property MaxPublicationQuantity: Integer read FMaxPublicationQuantity write FMaxPublicationQuantity;
    property MeasurableQuantity: TAlephProductMeasurableQuantity read FMeasurableQuantity write FMeasurableQuantity;
      
  end;

  TAlephProductPriceGet = class(TObject)
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

  TAlephProductKitComponent = class(TObject)
  private
    FIdentification: TAlephProductIdentification;
    FPrice: TArray<TAlephProductPriceGet>;
    FStock: TAlephProductStock;
    FQuantity: Integer;
    FPrincipal: Boolean;

  public
    property Identification: TAlephProductIdentification read FIdentification write FIdentification;
    property Price: TArray<TAlephProductPriceGet> read FPrice write FPrice;
    property Stock: TAlephProductStock read FStock write FStock;
    property Quantity: Integer read FQuantity write FQuantity;
    property Principal: Boolean read FPrincipal write FPrincipal;

  end;

  TAlephProductGroupedPublications = class(TObject)
  private
    FMarketPlace: TAlephKeyValue;
    FDetails: TArray<TAlephIdName>;

  public
    property MarketPlace: TAlephKeyValue read FMarketPlace write FMarketPlace;
    property Details: TArray<TAlephIdName> read FDetails write FDetails;

  end;

  TAlephProductMeasurableQuantity = class(TObject)
  private
    FQuantity: Double;
    FUnit: string;

  public
    property Quantity: Double read FQuantity write FQuantity;
    property &Unit: string read FUnit write FUnit;
    
  end;

implementation

end.
