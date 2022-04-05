unit TestAlephCRM.Services.ProductCatalog;

interface

uses
  DUnitX.TestFramework,
  SysUtils,
  AlephCRM.Models.ProductCatalog,
  AlephCRM.Services.ProductCatalog,
  AlephCRM.Models.ListResultPaging;

type

  [TestFixture]
  TestAlephProductService = class(TObject)
  private
    FAlephProduct: IAlephProductCatalog;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;

    [Test]
    procedure TestGetProducts;
  end;

implementation

procedure TestAlephProductService.Setup;
begin
  FAlephProduct := TAlephProductCatalogService.New;
end;

procedure TestAlephProductService.TearDown;
begin
  FAlephProduct := nil;
end;

procedure TestAlephProductService.TestGetProducts;
var
  LResult: TAlephListResultPaging<TAlephProductCatalog>;
begin
  LResult := FAlephProduct.Get;
  Assert.IsTrue(Assigned(LResult));
end;

initialization

TDUnitX.RegisterTestFixture(TestAlephProductService);

end.
