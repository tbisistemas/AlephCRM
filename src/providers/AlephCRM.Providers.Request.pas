unit AlephCRM.Providers.Request;

interface

uses RESTRequest4D;

type
  IAlephRequest<T: class, constructor> = interface
    ['{608FFCB3-DE41-4BD6-97DB-0989DA56816B}']
    function ResourceSuffix(const AResourceSuffix: Integer): IAlephRequest<T>;
    function Resource(const AResource: string): IAlephRequest<T>;
    function AddQueryParam(const AName, AValue: string): IAlephRequest<T>;
    function ClearQueryParams: IAlephRequest<T>;
    function Post(const AObject: T): T;
    function Get: T;
  end;

  TAlephRequest<T: class, constructor> = class(TInterfacedObject, IAlephRequest<T>)
  private
    FRequest: IRequest;
    function ResourceSuffix(const AResourceSuffix: Integer): IAlephRequest<T>;
    function Resource(const AResource: string): IAlephRequest<T>;
    function AddQueryParam(const AName, AValue: string): IAlephRequest<T>;
    function ClearQueryParams: IAlephRequest<T>;
    function Post(const AObject: T): T;
    function Get: T;
    procedure _SetupAuthentication;
  public
    constructor Create;
    class function New: IAlephRequest<T>;
  end;

implementation

uses
  AlephCRM.Providers.Consts,
  System.SysUtils,
  REST.Json,
  System.Json,
  AlephCRM.Providers.Authentication,
  System.Generics.Collections;

{ TAlephCRMRequest<T> }

function TAlephRequest<T>.AddQueryParam(const AName, AValue: string): IAlephRequest<T>;
begin
  FRequest.AddParam(AName, AValue);
  Result := Self;
end;

function TAlephRequest<T>.ClearQueryParams: IAlephRequest<T>;
begin
  FRequest.ClearParams;
  Result := Self;
end;

constructor TAlephRequest<T>.Create;
begin
  FRequest := TRequest.New
    .ContentType(APPLICATION_JSON)
    .BaseURL(BASE_URL);
  _SetupAuthentication;
end;

function TAlephRequest<T>.Get: T;
var
  LResponse: IResponse;
begin
  LResponse := FRequest.Get;
  if LResponse.StatusCode = 401 then
  begin
    _SetupAuthentication;
    Result := Self.Get;
    Exit;
  end;
  if LResponse.StatusCode <> 200 then
    raise Exception.Create(LResponse.Content);
  if FRequest.ResourceSuffix.Trim.IsEmpty then
    Result := TJson.JsonToObject<T>(LResponse.Content)
  else
    Result := TJson.JsonToObject<T>(LResponse.JSONValue.GetValue<TJSONArray>('result').Items[0] as TJSONObject);
end;

class function TAlephRequest<T>.New: IAlephRequest<T>;
begin
  Result := TAlephRequest<T>.Create;
end;

procedure TAlephRequest<T>._SetupAuthentication;
begin
  FRequest.AddParam('api_key', TAlephAuthentication.GetInstance.ApiKey);
  FRequest.AddParam('accountId', TAlephAuthentication.GetInstance.AccountId);
end;

function TAlephRequest<T>.Post(const AObject: T): T;
var
  LResponse: IResponse;
begin
  if Assigned(AObject) then
    FRequest.ClearBody.AddBody(AObject);
  LResponse := FRequest.Post;
  if LResponse.StatusCode = 401 then
  begin
    _SetupAuthentication;
    Result := Self.Post(nil);
    Exit;
  end;
  if LResponse.StatusCode <> 200 then
    raise Exception.Create(LResponse.Content);
  Result := TJson.JsonToObject<T>(LResponse.JSONValue.GetValue<TJSONArray>('result').Items[0] as TJSONObject);
end;

function TAlephRequest<T>.Resource(const AResource: string): IAlephRequest<T>;
begin
  FRequest.Resource(AResource);
  Result := Self;
end;

function TAlephRequest<T>.ResourceSuffix(const AResourceSuffix: Integer): IAlephRequest<T>;
begin
  FRequest.ResourceSuffix(AResourceSuffix.ToString);
  Result := Self;
end;

end.
