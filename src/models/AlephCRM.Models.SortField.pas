unit AlephCRM.Models.SortField;

interface

uses AlephCRM.Models.BaseModel;

{$M+}

type
  TAlephSorField = class(TAlephBaseModel)
  private
    FId: string;
    FName: string;

  published
    property Id: string read FId write FId;
    property Name: string read FName write FName;

  end;

implementation

end.
