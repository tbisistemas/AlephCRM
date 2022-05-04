unit AlephCRM.Models.Paging;

interface

uses AlephCRM.Models.BaseModel;

{$M+}

type

  TAlephPaging = class(TAlephBaseModel)
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
