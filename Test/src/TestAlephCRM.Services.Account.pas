unit TestAlephCRM.Services.Account;

interface

uses
  DUnitX.TestFramework,
  SysUtils,
  AlephCRM.Services,
  AlephCRM.Models.ListResult,
  AlephCRM.Models.Account;

type

  [TestFixture]
  TestAlephAccountService = class(TObject)
  strict private
    FAlephCRM: IAlephCRM;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;
    [Test]
    procedure TestGetAccount;
  end;

implementation

uses AlephCRM.Providers.Authentication;

procedure TestAlephAccountService.Setup;
begin
  FAlephCRM := TAlephCRM.New;
end;

procedure TestAlephAccountService.TearDown;
begin
  FAlephCRM := nil;
end;

procedure TestAlephAccountService.TestGetAccount;
var
  LResult: TAlephListResult<TAlephAccount>;
begin
  LResult := FAlephCRM.Accounts.Get;
  Assert.IsTrue(Assigned(LResult));
  Assert.AreEqual(TAlephAuthentication.GetInstance.AccountId.ToInteger, LResult.Results[0].Id);
end;

initialization

TDUnitX.RegisterTestFixture(TestAlephAccountService);

end.
