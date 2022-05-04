unit AlephCRM.Services.ProductUpdate;

interface

uses
  Generics.Collections, SysUtils,
  AlephCRM.Models.Products.ActionResult,
  AlephCRM.Models.Products.Update;

type
  IAlephProductUpdate = interface
    ['{BE8B657C-F0EC-462A-9B87-F422B65C73FE}']
    function PriceListId(const APriceListId: Integer): IAlephProductUpdate;
    function AddProduct(const AProduct: TAlephProductUpdateModel): IAlephProductUpdate;
    function Post: TAlephActionResult;
  end;

  TAlephProductUpdate = class(TInterfacedObject, IAlephProductUpdate)
  private
    FPriceListId: Integer;
    FProductList: TObjectList<TAlephProductUpdateModel>;
  private
    {IAlpehProductUpdate implementation}
    function PriceListId(const APriceListId: Integer): IAlephProductUpdate;
    function AddProduct(const AProduct: TAlephProductUpdateModel): IAlephProductUpdate;
    function Post: TAlephActionResult;

  public
    constructor Create;
    destructor Destroy; override;

    class function New: IAlephProductUpdate;

  end;

implementation

{ TAlephProductUpdate }

uses
  AlephCRM.Providers.ProductUpdateRequest,
  AlephCRM.Providers.Consts,
  AlephCRM.Providers.Request;

function TAlephProductUpdate.AddProduct(const AProduct: TAlephProductUpdateModel): IAlephProductUpdate;
begin
  Result := Self;
  FProductList.Add(AProduct);
end;

constructor TAlephProductUpdate.Create;
begin
  FProductList := TObjectList<TAlephProductUpdateModel>.Create;
end;

destructor TAlephProductUpdate.Destroy;
begin
  FProductList.Free;
  inherited;
end;

class function TAlephProductUpdate.New: IAlephProductUpdate;
begin
  Result := Self.Create;
end;

function TAlephProductUpdate.Post: TAlephActionResult;
var
  LRequest: IAlephProductUpdateRequest<TAlephProductUpdateModel>;
begin
  LRequest := TAlephProductUpdateRequest<TAlephProductUpdateModel>.New;
  if FPriceListId > 0 then
    (LRequest as IAlephRequest<TAlephProductUpdateModel>).AddQueryParam('priceListId', FPriceListId.ToString);
  Result := LRequest.Post(FProductList);
end;

function TAlephProductUpdate.PriceListId(const APriceListId: Integer): IAlephProductUpdate;
begin
  Result := Self;
  FPriceListId := APriceListId;
end;

end.
