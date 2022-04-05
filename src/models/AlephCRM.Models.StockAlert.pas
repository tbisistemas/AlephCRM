unit AlephCRM.Models.StockAlert;

interface

type
  TAlephStockAlert = class(TObject)
  private
    FRedQty: Integer;
    FYellowQty: Integer;

  public
    property RedQty: Integer read FRedQty write FRedQty;
    property YellowQty: Integer read FYellowQty write FYellowQty;

  end;

implementation

end.
