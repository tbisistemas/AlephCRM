unit AlephCRM.Models.ListResultPaging;

interface

uses AlephCRM.Models.Paging, AlephCRM.Models.SortField;

type
  TAlephListResultPaging<T: class> = class
  private
    FSortBy: TAlephSorField;
    FAvailableSorts: TArray<TAlephSorField>;
    FPaging: TAlephPaging;
    FResults: TArray<T>;
    FTotal: Integer;
  public
    property Paging: TAlephPaging read FPaging write FPaging;
    property SortBy: TAlephSorField read FSortBy write FSortBy;
    property AvailableSorts: TArray<TAlephSorField> read FAvailableSorts write FAvailableSorts;
    property Total: Integer read FTotal write FTotal;
    property Results: TArray<T> read FResults write FResults;
    destructor Destroy; override;
  end;

implementation

{ TAlephResultPageDTO<T> }

destructor TAlephListResultPaging<T>.Destroy;
var
  LAlephResultPage: T;
begin
  Paging.Free;
  for LAlephResultPage in Results do
    LAlephResultPage.Free;
  inherited;
end;

end.
