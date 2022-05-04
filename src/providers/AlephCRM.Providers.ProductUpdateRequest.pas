unit AlephCRM.Providers.ProductUpdateRequest;

interface

uses
  Generics.Collections, System.JSON,
  AlephCRM.Models.Products.ActionResult,
  AlephCRM.Providers.Request;

type
  IAlephProductUpdateRequest<T: class, constructor> = interface
    ['{087C98B0-6FA6-4921-9798-FCF93C40B1DF}']
    function Post(const AProductList: TObjectList<T>): TAlephActionResult;
  end;

  TAlephProductUpdateRequest<T: class, constructor> = class(TAlephRequest<T>, IAlephProductUpdateRequest<T>)
  private
    function _ConvertProductListToJsonArray(const AProductList: TObjectList<T>): TJSONArray;

  private
    { IalpehProductUpdateRequest implementation }
    function Post(const AProductList: TObjectList<T>): TAlephActionResult;
  public
    constructor Create; override;
    class function New: IAlephProductUpdateRequest<T>;
  end;

implementation

{ TAlephProductUpdateRequest<T> }

uses
  System.SysUtils,
  System.Classes,
  Neon.Core.Persistence.JSON,
  AlephCRM.Providers.Consts,
  AlephCRM.Providers.Authentication,
  Infra.HTTPRestClient;

constructor TAlephProductUpdateRequest<T>.Create;
begin
  inherited;

end;

class function TAlephProductUpdateRequest<T>.New: IAlephProductUpdateRequest<T>;
begin
  Result := TAlephProductUpdateRequest<T>.Create;
end;

function TAlephProductUpdateRequest<T>.Post(const AProductList: TObjectList<T>): TAlephActionResult;
var
  LResult: TAlephActionResult;
begin
  FRestClient.Request.ClearBody;
  if Assigned(AProductList) and (AProductList.Count > 0) then
  begin
    FRestClient.Request.AddBody(_ConvertProductListToJsonArray(AProductList));
  end;
  Resource(PATH_PRODUCT);
  FRestClient.Request.Post;
  if FRestClient.Response.StatusCode = 401 then
  begin
    _SetupAuthentication;
    Result := Self.Post(nil);
    Exit;
  end;
  if FRestClient.Response.StatusCode <> 200 then
    raise Exception.Create(FRestClient.Response.Content);
  Result := TNeon.JsonToObject<TAlephActionResult>(FRestClient.Response.JSONValue, FNeonConfig);
end;

function TAlephProductUpdateRequest<T>._ConvertProductListToJsonArray(const AProductList: TObjectList<T>): TJSONArray;
var
  LProduct: T;
begin
  Result := TJSONArray.Create;
  for LProduct in AProductList do
  begin
    Result.AddElement(TNeon.ObjectToJSON(LProduct, FNeonConfig));
  end;

end;

end.
