unit AlephCRM.Models.ListResultPaging;

interface

uses
  Generics.Collections,
  AlephCRM.Models.Paging, AlephCRM.Models.SortField;

type
  TAlephListResultPaging<T: class> = class
  private
    FSortBy: TAlephSorField;
    FAvailableSorts: TList<TAlephSorField>;
    FPaging: TAlephPaging;
    FResults: TList<T>;
    FTotal: Integer;
  public
    constructor Create;
    destructor Destroy; override;
  published
    property Paging: TAlephPaging read FPaging write FPaging;
    property SortBy: TAlephSorField read FSortBy write FSortBy;
    property AvailableSorts: TList<TAlephSorField> read FAvailableSorts write FAvailableSorts;
    property Total: Integer read FTotal write FTotal;
    property Results: TList<T> read FResults write FResults;
  end;

implementation

{ TAlephResultPageDTO<T> }

constructor TAlephListResultPaging<T>.Create;
begin
  FPaging := TAlephPaging.Create;
  FSortBy := TAlephSorField.Create;
  FAvailableSorts := TList<TAlephSorField>.Create;
  FResults := TList<T>.Create;
end;

destructor TAlephListResultPaging<T>.Destroy;
var
  LResult: T;
  LAvailableSort: TAlephSorField;
begin
  FPaging.Free;
  FSortBy.Free;
  for LAvailableSort in FAvailableSorts do
    LAvailableSort.Free;
  FAvailableSorts.Free;
  for LResult in FResults do
    LResult.Free;
  FResults.Free;
  inherited;
end;

end.
