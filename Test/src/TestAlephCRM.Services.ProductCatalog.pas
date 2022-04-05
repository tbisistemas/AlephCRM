unit TestAlephCRM.Services.ProductCatalog;

interface

uses
  DUnitX.TestFramework,
  SysUtils,
  AlephCRM.Models.ProductCatalog,
  AlephCRM.Services,
  AlephCRM.Models.ListResultPaging;

type

  [TestFixture]
  TestAlephProductService = class(TObject)
  private
    FAlephCRM: IAlephCRM;
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
  FAlephCRM := TAlephCRM.New;
end;

procedure TestAlephProductService.TearDown;
begin
  FAlephCRM := nil;
end;

procedure TestAlephProductService.TestGetProducts;
var
  LResult: TAlephListResultPaging<TAlephProductCatalog>;
begin
  LResult := FAlephCRM.ProductsCatalog.Get;
  Assert.IsTrue(Assigned(LResult));
end;

initialization

TDUnitX.RegisterTestFixture(TestAlephProductService);

end.
