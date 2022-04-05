program AlephCRM;

uses
  Vcl.Forms,
  AlephCRM.DTO.Result in 'src\dto\AlephCRM.DTO.Result.pas',
  AlephCRM.Models.Page in 'src\models\AlephCRM.Models.Page.pas',
  AlephCRM.Providers.Consts in 'src\providers\AlephCRM.Providers.Consts.pas',
  AlephCRM.Providers.Token in 'src\providers\AlephCRM.Providers.Token.pas',
  AlephCRM.Providers.Request in 'src\providers\AlephCRM.Providers.Request.pas',
  AlephCRM.Services.Account in 'src\services\AlephCRM.Services.Account.pas',
  AlephCRM.Models.Account in 'src\models\AlephCRM.Models.Account.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Run;
end.
