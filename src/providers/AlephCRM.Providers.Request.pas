unit AlephCRM.Providers.Request;

interface

uses
  System.SysUtils,
  System.JSON,
  System.Rtti,
  Generics.Collections,
  Neon.Core.Persistence,
  Neon.Core.Persistence.JSON,
  Infra.HTTPRestClient;

type
  IAlephRequest<T: class, constructor> = interface
    ['{608FFCB3-DE41-4BD6-97DB-0989DA56816B}']
    function ResourcePrefix(const AResourcePrefix: string): IAlephRequest<T>;
    function ResourceSuffix(const AResourceSuffix: string): IAlephRequest<T>;
    function Resource(const AResource: string): IAlephRequest<T>;
    function AddQueryParam(const AName, AValue: string): IAlephRequest<T>;
    function ClearQueryParams: IAlephRequest<T>;
    function Get: T;
  end;

  TAlephRequest<T: class, constructor> = class(TInterfacedObject, IAlephRequest<T>)
  private
  protected
    FRestClient: TInfraHTTPRestClient;
    FNeonConfig: INeonConfiguration;
    function ResourcePrefix(const AResourcePrefix: string): IAlephRequest<T>;
    function ResourceSuffix(const AResourceSuffix: string): IAlephRequest<T>;
    function Resource(const AResource: string): IAlephRequest<T>;
    function AddQueryParam(const AName, AValue: string): IAlephRequest<T>;
    function ClearQueryParams: IAlephRequest<T>;
    function Get: T;

    procedure _SetupAuthentication;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    class function New: IAlephRequest<T>;
  end;

implementation

uses
  Neon.Core.Types,
  Neon.Core.Utils,
  AlephCRM.Providers.Consts,
  AlephCRM.Providers.Authentication,
  System.Generics.Collections;

{ TAlephCRMRequest<T> }

function TAlephRequest<T>.AddQueryParam(const AName, AValue: string): IAlephRequest<T>;
begin
  FRestClient.Request.AddParam(AName, AValue);
  Result := Self;
end;

function TAlephRequest<T>.ClearQueryParams: IAlephRequest<T>;
begin
  FRestClient.Request.ClearParams;
  Result := Self;
end;

constructor TAlephRequest<T>.Create;
begin
  FRestClient := TInfraHTTPRestClient.Create;
  FRestClient.Request.BaseURL(BASE_URL);
  FNeonConfig := TNeonConfiguration.Default;
  FNeonConfig.SetMembers([TNeonMembers.Standard, TNeonMembers.Fields, TNeonMembers.Properties]);
  _SetupAuthentication;
end;

destructor TAlephRequest<T>.Destroy;
begin
  FRestClient.Free;
  inherited;
end;

function TAlephRequest<T>.Get: T;
begin
  FRestClient.Request.Get;
  if FRestClient.Response.StatusCode = 401 then
  begin
    _SetupAuthentication;
    Result := Self.Get;
    Exit;
  end;
  if FRestClient.Response.StatusCode <> 200 then
    raise Exception.Create(FRestClient.Response.Content);
  Result := TNeon.JsonToObject<T>(FRestClient.Response.JSONValue, FNeonConfig)
end;

class function TAlephRequest<T>.New: IAlephRequest<T>;
begin
  Result := TAlephRequest<T>.Create;
end;

procedure TAlephRequest<T>._SetupAuthentication;
begin
  FRestClient.Request
    .AddParam('api_key', TAlephAuthentication.GetInstance.ApiKey)
    .AddParam('accountId', TAlephAuthentication.GetInstance.AccountId);
end;

function TAlephRequest<T>.Resource(const AResource: string): IAlephRequest<T>;
begin
  Result := Self;
  FRestClient.Request.Resource(AResource);
end;

function TAlephRequest<T>.ResourcePrefix(const AResourcePrefix: string): IAlephRequest<T>;
begin
  Result := Self;
  FRestClient.Request.ResourcePrefix(AResourcePrefix);
end;

function TAlephRequest<T>.ResourceSuffix(const AResourceSuffix: string): IAlephRequest<T>;
begin
  Result := Self;
  FRestClient.Request.ResourceSuffix(AResourceSuffix);
end;

end.
