unit TestAlephCRM.Services.ProductUpdate;

interface

uses
  DUnitX.TestFramework,
  AlephCRM.Services;

type

  [TestFixture]
  TestAlephProductUpdateService = class(TObject)
  private
    FAlephCRM: IAlephCRM;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;

    [Test]
    procedure TestUpdateProducts;
  end;

implementation

uses
  AlephCRM.Models.Products.ActionResult,
  AlephCRM.Services.ProductUpdate;

procedure TestAlephProductUpdateService.Setup;
begin
  FAlephCRM := TAlephCRM.New;
end;

procedure TestAlephProductUpdateService.TearDown;
begin
  FAlephCRM := nil;
end;

procedure TestAlephProductUpdateService.TestUpdateProducts;
var
  LResult: TAlephActionResult;
  LProductUpdate: IAlephProductUpdate;
  LProductUpdateModel: TAlephProductUpdateModel;
begin
  LProductUpdate := FAlephCRM.ProductsUpdate;
  LProductUpdateModel := TAlephProductUpdateModel.Create;
  LProductUpdateModel.SKU := 'F000.KE0.P43-T4E';
  LProductUpdateModel.Stock := TAlephProductStockUpdate.Create;
  LProductUpdateModel.Stock.Quantity := 0;

  LProductUpdate.AddProduct(LProductUpdateModel);
  LResult := LProductUpdate.Post;
  Assert.IsTrue(Assigned(LResult) and (LResult.Quantities.Ok = 1));
end;

initialization

TDUnitX.RegisterTestFixture(TestAlephProductUpdateService);

end.
