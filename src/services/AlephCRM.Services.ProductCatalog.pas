unit AlephCRM.Services.ProductCatalog;

interface

uses
  SysUtils,
  AlephCRM.Models.ProductCatalog, AlephCRM.Models.ListResultPaging;

type
  IAlephProductCatalog = interface
    ['{A586F3FD-8605-4AE1-8090-A7C155F269DF}']
    function Sku(const ASku: string): IAlephProductCatalog;
    function Brand(const ABrand: string): IAlephProductCatalog;
    function OwnCode(const AOwnCode: string): IAlephProductCatalog;
    function PriceListId(const APriceListId: Integer): IAlephProductCatalog;
    function DateUpdateFrom(const ADateUpdateFrom: TDateTime): IAlephProductCatalog;
    function CatalogStatus(const ACatalogStatus: string): IAlephProductCatalog;
    function Sort(const ASort: string): IAlephProductCatalog;
    function OffSet(const AOffSet: Integer): IAlephProductCatalog;
    function Limit(const ALimit: Integer): IAlephProductCatalog;
    function Get: TAlephListResultPaging<TAlephProductCatalog>;


  end;

  TAlephProductCatalogService = class(TInterfacedObject, IAlephProductCatalog)
  private
    FBrand: string;
    FCatalogStatus: string;
    FLimit: Integer;
    FOffset: Integer;
    FDateUpdateFrom: TDateTime;
    FSku: string;
    FSort: string;
    FPriceListId: Integer;
    FOwnCode: string;

  private
    { IAlephProduct implementation }
    function Sku(const ASku: string): IAlephProductCatalog;
    function Brand(const ABrand: string): IAlephProductCatalog;
    function OwnCode(const AOwnCode: string): IAlephProductCatalog;
    function PriceListId(const APriceListId: Integer): IAlephProductCatalog;
    function DateUpdateFrom(const ADateUpdateFrom: TDateTime): IAlephProductCatalog;
    function CatalogStatus(const ACatalogStatus: string): IAlephProductCatalog;
    function Sort(const ASort: string): IAlephProductCatalog;
    function OffSet(const AOffSet: Integer): IAlephProductCatalog;
    function Limit(const ALimit: Integer): IAlephProductCatalog;
    function Get: TAlephListResultPaging<TAlephProductCatalog>;

  public
    constructor Create;
    class function New: IAlephProductCatalog;

  end;

implementation

{ TAlephProductService }

uses
  AlephCRM.Providers.Consts,
  AlephCRM.Providers.Request;

function TAlephProductCatalogService.Brand(const ABrand: string): IAlephProductCatalog;
begin
  Result := Self;
  FBrand := ABrand;
end;

function TAlephProductCatalogService.CatalogStatus(
  const ACatalogStatus: string): IAlephProductCatalog;
begin
  Result := Self;
  FCatalogStatus := ACatalogStatus;
end;

constructor TAlephProductCatalogService.Create;
begin
  FLimit := PRODUCT_DEFAULT_LIMIT;
  FOffset := DEFAULT_OFFSET;
end;

function TAlephProductCatalogService.DateUpdateFrom(
  const ADateUpdateFrom: TDateTime): IAlephProductCatalog;
begin
  Result := Self;
  FDateUpdateFrom := ADateUpdateFrom;
end;

function TAlephProductCatalogService.Get: TAlephListResultPaging<TAlephProductCatalog>;
var
  LRequest: IAlephRequest<TAlephListResultPaging<TAlephProductCatalog>>;
begin
  LRequest := TAlephRequest < TAlephListResultPaging < TAlephProductCatalog >>.New
    .Resource(PATH_PRODUCT);

  if not FSku.Trim.IsEmpty then
    LRequest.AddQueryParam('Sku', FSku);
  if not FBrand.Trim.IsEmpty then
    LRequest.AddQueryParam('brand', FBrand);
  if not FOwnCode.Trim.IsEmpty then
    LRequest.AddQueryParam('ownCode', FOwnCode);
  if not FPriceListId > 0 then
    LRequest.AddQueryParam('priceListId', FPriceListId.ToString);
  if not (FDateUpdateFrom > 0) then
    LRequest.AddQueryParam('dateUpdateFrom', FormatDateTime('yyyy-mm-dd hh:nn', FDateUpdateFrom));
  if not FCatalogStatus.Trim.IsEmpty then
    LRequest.AddQueryParam('catalogStatus', FCatalogStatus);
  if not FSort.Trim.IsEmpty then
    LRequest.AddQueryParam('sort', FSort);
  LRequest
    .AddQueryParam(LIMIT_PARAMETER, FLimit.ToString)
    .AddQueryParam(OFFSET_PARAMETER, FOffset.ToString);

  Result := LRequest.Get;
end;

function TAlephProductCatalogService.Limit(const ALimit: Integer): IAlephProductCatalog;
begin
  Result := Self;
  FLimit := ALimit;
end;

class function TAlephProductCatalogService.New: IAlephProductCatalog;
begin
  Result := Self.Create;
end;

function TAlephProductCatalogService.OffSet(
  const AOffSet: Integer): IAlephProductCatalog;
begin
  Result := Self;
  FOffset := AOffSet;
end;

function TAlephProductCatalogService.OwnCode(
  const AOwnCode: string): IAlephProductCatalog;
begin
  Result := Self;
  FOwnCode := AOwnCode;
end;

function TAlephProductCatalogService.PriceListId(
  const APriceListId: Integer): IAlephProductCatalog;
begin
  Result := Self;
  FPriceListId := APriceListId;
end;

function TAlephProductCatalogService.Sku(const ASku: string): IAlephProductCatalog;
begin
  Result := Self;
  FSku := ASku;
end;

function TAlephProductCatalogService.Sort(const ASort: string): IAlephProductCatalog;
begin
  Result := Self;
  FSort := ASort;
end;

end.
