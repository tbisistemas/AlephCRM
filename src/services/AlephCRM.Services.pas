unit AlephCRM.Services;

interface

uses AlephCRM.Services.Account, AlephCRM.Services.ProductCatalog,
  AlephCRM.Models.Account, AlephCRM.Models.ProductCatalog;

type
  TAlephAccount = AlephCRM.Models.Account.TAlephAccount;
  TAlephProductCatalog = AlephCRM.Models.ProductCatalog.TAlephProductCatalog;

  IAlephCRM = interface
    ['{871BA323-8DA3-4621-935A-1446BF67659B}']
    function Accounts: IAlephAccount;
    function ProductsCatalog: IAlephProductCatalog;
  end;

  TAlephCRM = class(TInterfacedObject, IAlephCRM)
  private
    function Accounts: IAlephAccount;
    function ProductsCatalog: IAlephProductCatalog;
  public
    class function New: IAlephCRM;
  end;

implementation

{ TAlephCRM }

function TAlephCRM.Accounts: IAlephAccount;
begin
  Result := TAlephAccountService.New;
end;

class function TAlephCRM.New: IAlephCRM;
begin
  Result := Self.Create;
end;

function TAlephCRM.ProductsCatalog: IAlephProductCatalog;
begin
  Result := TAlephProductCatalogService.New;
end;

end.
