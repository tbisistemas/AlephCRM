unit AlephCRM.DTO.ListResultPaging;

interface

uses AlephCRM.Models.Paging;

type
  TAlephResultPageDTO<T: class> = class
  strict private
    FPaging: TAlephPaging;
    FResults: TArray<T>;
  public
    property Paging: TAlephPaging read FPaging write FPaging;
    property Results: TArray<T> read FResults write FResults;
    destructor Destroy; override;
  end;

  TAlephResultDTO<T: class> = class
  strict private
    FResults: TArray<T>;
    FTotal: Integer;
  public
    destructor Destroy; override;
    property Total: Integer read FTotal write FTotal;
    property Results: TArray<T> read FResults write FResults;
  end;

implementation

{ TAlephResultPageDTO<T> }

destructor TAlephResultPageDTO<T>.Destroy;
var
  LAlephResultPage: T;
begin
  Paging.Free;
  for LAlephResultPage in Results do
    LAlephResultPage.Free;
  inherited;
end;

{ TAlephResultDTO<T> }

destructor TAlephResultDTO<T>.Destroy;
var
  LAlephResult: T;
begin
  for LAlephResult in Results do
    LAlephResult.Free;
  inherited;
end;

end.
