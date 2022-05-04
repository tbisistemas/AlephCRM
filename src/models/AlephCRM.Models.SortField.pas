unit AlephCRM.Models.SortField;

interface

{$M+}

type
  TAlephSorField = class
  private
    FId: string;
    FName: string;

  published
    property Id: string read FId write FId;
    property Name: string read FName write FName;

  end;

implementation

end.
