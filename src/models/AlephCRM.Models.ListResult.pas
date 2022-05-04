unit AlephCRM.Models.ListResult;

interface

uses
  Generics.Collections;

{$M+}

type
  TAlephListResult<T: class> = class
  strict private
    FResults: TList<T>;
    FTotal: Integer;
  public
    constructor Create;
    destructor Destroy; override;

  published
    property Total: Integer read FTotal write FTotal;
    property Results: TList<T> read FResults write FResults;
  end;

implementation

{ TAlephListResult<T> }

constructor TAlephListResult<T>.Create;
begin
  FResults := TList<T>.Create;
end;

destructor TAlephListResult<T>.Destroy;
var
  LResult: T;
begin
  for LResult in FResults do
    LResult.Free;
  FResults.Free;

  inherited;
end;

end.
