unit AlephCRM.Models.ListResult;

interface

type
  TAlephListResult<T: class> = class
  strict private
    FResults: TArray<T>;
    FTotal: Integer;
  public
    destructor Destroy; override;
    property Total: Integer read FTotal write FTotal;
    property Results: TArray<T> read FResults write FResults;
  end;

implementation

{ TAlephListResult<T> }

destructor TAlephListResult<T>.Destroy;
var
  LAlephResult: T;
begin
  for LAlephResult in Results do
    LAlephResult.Free;
  inherited;
end;

end.
