unit AlephCRM.Services;

interface

uses
  AlephCRM.Services.Account, AlephCRM.Services.ProductCatalog,
  AlephCRM.Models.Account, AlephCRM.Models.ProductCatalog,
  AlephCRM.Services.ProductUpdate, AlephCRM.Models.Products.Update;

type
  TAlephAccount = AlephCRM.Models.Account.TAlephAccount;
  TAlephProductCatalog = AlephCRM.Models.ProductCatalog.TAlephProductCatalog;
  TAlephProductUpdateModel = AlephCRM.Models.Products.Update.TAlephProductUpdateModel;
  TAlephProductStockUpdate = AlephCRM.Models.Products.Update.TAlephProductStockUpdate;


  IAlephCRM = interface
    ['{871BA323-8DA3-4621-935A-1446BF67659B}']
    function Accounts: IAlephAccount;
    function ProductsCatalog: IAlephProductCatalog;
    function ProductsUpdate: IAlephProductUpdate;

  end;

  TAlephCRM = class(TInterfacedObject, IAlephCRM)
  private
    function Accounts: IAlephAccount;
    function ProductsCatalog: IAlephProductCatalog;
    function ProductsUpdate: IAlephProductUpdate;

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

function TAlephCRM.ProductsUpdate: IAlephProductUpdate;
begin
  Result := TAlephProductUpdate.New;
end;

end.
