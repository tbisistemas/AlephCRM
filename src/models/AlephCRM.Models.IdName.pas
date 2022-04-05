unit AlephCRM.Models.IdName;

interface

type
  TAlephIdName = class(TObject)
  private
    FId: Integer;
    FName: string;

  public
    property Id: Integer read FId write FId;
    property Name: string read FName write FName;
  end;

  TAlephKeyValue = class(TObject)
  private
    FKey: Integer;
    FValue: string;

  public
    property Key: Integer read FKey write FKey;
    property Value: string read FValue write FValue;
  end;

implementation

end.
