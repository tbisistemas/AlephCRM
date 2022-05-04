unit TestAlephCRM.Models.BaseModel;

interface

uses
  SysUtils,
  AlephCRM.Services,
  DUnitX.TestFramework;

type

  [TestFixture]
  TTestAlephBaseModel = class(TObject)
  private
    FProduct: TAlephProductCatalog;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;

    [Test]
    procedure ConvertObjectToJson;
  end;

implementation

procedure TTestAlephBaseModel.ConvertObjectToJson;
var
  LJson: string;
begin
  LJson := FProduct.ToJson;
  Assert.IsFalse(LJson.IsEmpty);
end;

procedure TTestAlephBaseModel.Setup;
begin
  FProduct := TAlephProductCatalog.Create;
end;

procedure TTestAlephBaseModel.TearDown;
begin
  FProduct.Free;
end;

initialization

TDUnitX.RegisterTestFixture(TTestAlephBaseModel);

end.
