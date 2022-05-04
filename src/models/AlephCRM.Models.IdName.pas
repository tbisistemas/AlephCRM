unit AlephCRM.Models.IdName;

interface

{$M+}

type
  TAlephIdName = class
  private
    FId: Integer;
    FName: string;
  published
    property Id: Integer read FId write FId;
    property Name: string read FName write FName;
  end;

  TAlephKeyValue = class(TObject)
  private
    FKey: Integer;
    FValue: string;
  published
    property Key: Integer read FKey write FKey;
    property Value: string read FValue write FValue;
  end;

implementation

end.
