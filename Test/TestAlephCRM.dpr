program TestAlephCRM;

{$IFNDEF TESTINSIGHT}
{$APPTYPE CONSOLE}
{$ENDIF}{$STRONGLINKTYPES ON}
uses
  System.SysUtils,
  {$IFDEF TESTINSIGHT}
  TestInsight.DUnitX,
  {$ENDIF }
  DUnitX.Loggers.Console,
  DUnitX.Loggers.Xml.NUnit,
  DUnitX.TestFramework,
  TestAlephCRM.Services.Account in 'src\TestAlephCRM.Services.Account.pas',
  AlephCRM.Models.ListResultPaging in '..\src\models\AlephCRM.Models.ListResultPaging.pas',
  AlephCRM.Models.Account in '..\src\models\AlephCRM.Models.Account.pas',
  AlephCRM.Models.Paging in '..\src\models\AlephCRM.Models.Paging.pas',
  AlephCRM.Providers.Authentication in '..\src\providers\AlephCRM.Providers.Authentication.pas',
  AlephCRM.Providers.Consts in '..\src\providers\AlephCRM.Providers.Consts.pas',
  AlephCRM.Providers.Request in '..\src\providers\AlephCRM.Providers.Request.pas',
  AlephCRM.Services.Account in '..\src\services\AlephCRM.Services.Account.pas',
  AlephCRM.Models.ProductCatalog in '..\src\models\AlephCRM.Models.ProductCatalog.pas',
  AlephCRM.Models.IdName in '..\src\models\AlephCRM.Models.IdName.pas',
  AlephCRM.Models.StockAlert in '..\src\models\AlephCRM.Models.StockAlert.pas',
  AlephCRM.Models.ListResult in '..\src\models\AlephCRM.Models.ListResult.pas',
  AlephCRM.Models.SortField in '..\src\models\AlephCRM.Models.SortField.pas',
  AlephCRM.Services.ProductCatalog in '..\src\services\AlephCRM.Services.ProductCatalog.pas',
  TestAlephCRM.Services.ProductCatalog in 'src\TestAlephCRM.Services.ProductCatalog.pas',
  AlephCRM.Services in '..\src\services\AlephCRM.Services.pas',
  AlephCRM.Models.Products.ActionResult in '..\src\models\AlephCRM.Models.Products.ActionResult.pas',
  AlephCRM.Providers.ProductUpdateRequest in '..\src\providers\AlephCRM.Providers.ProductUpdateRequest.pas',
  AlephCRM.Services.ProductUpdate in '..\src\services\AlephCRM.Services.ProductUpdate.pas',
  TestAlephCRM.Services.ProductUpdate in 'src\TestAlephCRM.Services.ProductUpdate.pas',
  AlephCRM.Models.Products.Update in '..\src\models\AlephCRM.Models.Products.Update.pas',
  Infra.HTTPRestClient in '..\src\utils\Infra.HTTPRestClient.pas',
  AlephCRM.Models.BaseModel in '..\src\models\AlephCRM.Models.BaseModel.pas',
  TestAlephCRM.Models.BaseModel in 'src\TestAlephCRM.Models.BaseModel.pas';

var
  runner : ITestRunner;
  results : IRunResults;
  logger : ITestLogger;
  nunitLogger : ITestLogger;
begin
{$IFDEF TESTINSIGHT}
  TestInsight.DUnitX.RunRegisteredTests;
  exit;
{$ENDIF}
  try
    //Check command line options, will exit if invalid
    TDUnitX.CheckCommandLine;
    //Create the test runner
    runner := TDUnitX.CreateRunner;
    //Tell the runner to use RTTI to find Fixtures
    runner.UseRTTI := True;
    //tell the runner how we will log things
    //Log to the console window
    logger := TDUnitXConsoleLogger.Create(true);
    runner.AddLogger(logger);
    //Generate an NUnit compatible XML File
    nunitLogger := TDUnitXXMLNUnitFileLogger.Create(TDUnitX.Options.XMLOutputFile);
    runner.AddLogger(nunitLogger);
    runner.FailsOnNoAsserts := False; //When true, Assertions must be made during tests;

    //Run tests
    results := runner.Execute;
    if not results.AllPassed then
      System.ExitCode := EXIT_ERRORS;

    {$IFNDEF CI}
    //We don't want this happening when running under CI.
    if TDUnitX.Options.ExitBehavior = TDUnitXExitBehavior.Pause then
    begin
      System.Write('Done.. press <Enter> key to quit.');
      System.Readln;
    end;
    {$ENDIF}
  except
    on E: Exception do
      System.Writeln(E.ClassName, ': ', E.Message);
  end;
end.
