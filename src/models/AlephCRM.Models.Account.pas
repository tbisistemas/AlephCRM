unit AlephCRM.Models.Account;

interface

uses AlephCRM.Models.BaseModel;

{$M+}

type
  TAlephAccount = class(TAlephBaseModel)
  private
    FId: Integer;
    FName: string;
    FBusinessName: string;
    FDocType: string;
    FDocNumber: string;
    FPickupCode: string;
    FOwnCode: string;
  published
    property Id: Integer read FId write FId;
    property Name: string read FName write FName;
    property BusinessName: string read FBusinessName write FBusinessName;
    property DocType: string read FDocType write FDocType;
    property DocNumber: string read FDocNumber write FDocNumber;
    property PickupCode: string read FPickupCode write FPickupCode;
    property OwnCode: string read FOwnCode write FOwnCode;
  end;

implementation

end.
