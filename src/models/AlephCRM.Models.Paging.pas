unit AlephCRM.Models.Paging;

interface

{$M+}

type

  TAlephPaging = class
  private
    FLimit: Integer;
    FOffset: Integer;
    FTotal: Integer;

  published
    property Limit: Integer read FLimit write FLimit;
    property Offset: Integer read FOffset write FOffset;
    property Total: Integer read FTotal write FTotal;

  end;

implementation

end.
