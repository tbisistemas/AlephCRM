unit AlephCRM.Models.StockAlert;

interface

uses AlephCRM.Models.BaseModel;

{$M+}

type
  TAlephStockAlert = class(TAlephBaseModel)
  private
    FRedQty: Integer;
    FYellowQty: Integer;

  published
    property RedQty: Integer read FRedQty write FRedQty;
    property YellowQty: Integer read FYellowQty write FYellowQty;

  end;

implementation

end.
