unit AlephCRM.Models.BaseModel;

interface

uses
  Neon.Core.Types,
  Neon.Core.Persistence,
  Neon.Core.Persistence.JSON;

type
  TAlephBaseModel = class
  private
    _FNeonConfig: INeonConfiguration;
  public
    function NeonConfig: INeonConfiguration;
    function ToJson: string;
  end;

implementation

{ TAlephBaseModel }


function TAlephBaseModel.NeonConfig: INeonConfiguration;
begin
  if not Assigned(_FNeonConfig) then
  begin
    _FNeonConfig := TNeonConfiguration.Default;
    _FNeonConfig.SetMembers([TNeonMembers.Standard, TNeonMembers.Fields, TNeonMembers.Properties]);
  end;
  Result := _FNeonConfig;
end;

function TAlephBaseModel.ToJson: string;
begin
  Result := TNeon.ObjectToJSONString(Self, NeonConfig);
end;

end.
