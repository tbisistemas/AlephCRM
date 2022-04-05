unit AlephCRM.Providers.Authentication;

interface

uses
  SysUtils;

type
  /// <summary>
  ///   Singleton para armazenar os dados de autenticação.
  /// </summary>
  TAlephAuthentication = class
  private
    FApiKey: string;
    FAccountId: string;
    constructor Create;
    function GetAccountId: string;
    function GetApiKey: string;
  public
    class function GetInstance: TAlephAuthentication;
    class function NewInstance: TObject; override;
    property ApiKey: string read GetApiKey write FApiKey;
    property AccountId: string read GetAccountId write FAccountId;
  end;

implementation

{ TAlephCRMToken }

var
  Instance: TAlephAuthentication = nil;

constructor TAlephAuthentication.Create;
begin

end;

function TAlephAuthentication.GetAccountId: string;
begin
  if FAccountId.IsEmpty then
    FAccountId := GetEnvironmentVariable('ALEPH_ACCOUNT_ID');
  Result := FAccountId;
end;

function TAlephAuthentication.GetApiKey: string;
begin
  if FApiKey.IsEmpty then
    FApiKey := GetEnvironmentVariable('ALEPH_API_KEY');
  Result := FApiKey;
end;

class function TAlephAuthentication.GetInstance: TAlephAuthentication;
begin
  Result := TAlephAuthentication.Create;
end;

class function TAlephAuthentication.NewInstance: TObject;
begin
  if not Assigned(Instance) then
    Instance := TAlephAuthentication(inherited NewInstance);
  Result := Instance;
end;

initialization

finalization
  Instance.Free;

end.
