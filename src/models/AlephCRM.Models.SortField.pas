unit AlephCRM.Models.SortField;

interface

type
  TAlephSorField = class
  private
    FId: string;
    FName: string;

  public
    property Id: string read FId write FId;
    property Name: string read FName write FName;

  end;

implementation

end.
