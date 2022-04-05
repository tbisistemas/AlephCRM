unit AlephCRM.Services.Account;

interface

uses
  AlephCRM.Models.ListResult, AlephCRM.Models.Account;

type
  IAlephAccount = interface
    ['{A29FDA41-FDAF-46A1-8FF8-C1F9250E3534}']
    function DocumentNumber(const ADocNumber: string): IAlephAccount;
    function Get: TAlephListResult<TAlephAccount>;
  end;

  TAlephAccountService = class(TInterfacedObject, IAlephAccount)
  private
    FDocumentNumber: string;
    function DocumentNumber(const ADocNumber: string): IAlephAccount;
    function Get: TAlephListResult<TAlephAccount>;
  public
    constructor Create;
    class function New: IAlephAccount;
  end;

implementation

uses
  System.SysUtils,
  AlephCRM.Providers.Consts,
  AlephCRM.Providers.Request;

{ TAlephCRMAccountService }

function TAlephAccountService.DocumentNumber(const ADocNumber: string): IAlephAccount;
begin
  FDocumentNumber := ADocNumber;
  Result := Self;
end;

constructor TAlephAccountService.Create;
begin
end;

function TAlephAccountService.Get: TAlephListResult<TAlephAccount>;
var
  LRequest: IAlephRequest<TAlephListResult<TAlephAccount>>;
begin
  LRequest := TAlephRequest < TAlephListResult < TAlephAccount >>.New
    .Resource(PATH_ACCOUNT);
  if not FDocumentNumber.Trim.IsEmpty then
    LRequest.AddQueryParam('documentNumber', FDocumentNumber);
  Result := LRequest.Get;
end;

class function TAlephAccountService.New: IAlephAccount;
begin
  Result := TAlephAccountService.Create;
end;

end.
