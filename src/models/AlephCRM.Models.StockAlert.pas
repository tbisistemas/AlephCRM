unit AlephCRM.Models.StockAlert;

interface

{$M+}

type
  TAlephStockAlert = class
  private
    FRedQty: Integer;
    FYellowQty: Integer;

  published
    property RedQty: Integer read FRedQty write FRedQty;
    property YellowQty: Integer read FYellowQty write FYellowQty;

  end;

implementation

end.
