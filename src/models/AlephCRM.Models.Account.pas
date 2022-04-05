unit AlephCRM.Models.Account;

interface


type
  TAlephAccount = class(TObject)
  private
    FId: Integer;
    FName: string;
    FBusinessName: string;
    FDocType: string;
    FDocNumber: string;
    FPickupCode: string;
    FOwnCode: string;
  public
    /// <summary>
    ///   ID of the account
    /// </summary>
    property Id: Integer read FId write FId;
    /// <summary>
    ///   Name of the account
    /// </summary>
    property Name: string read FName write FName;
    /// <summary>
    ///   Legal business name (valid only for companies)
    /// </summary>
    property BusinessName: string read FBusinessName write FBusinessName;
    /// <summary>
    ///   Identification document type.
    /// </summary>
    /// <remarks>
    ///   Available document types:
    ///  Argentina: DNI, CUIT, LC, LE, Otro.
    ///  Brazil: CPF, CNPJ.
    ///  Chile: RUT, Otro.
    ///  Colombia: CC, CE, NIT, Otro.
    ///  México: RFC, CURP, Otro.
    ///  Uruguay: CI, RUT, Otro.
    ///  Perú: DNI, CR, RUC.
    ///  Venezuela: CI, RIF, Pasaporte.
    /// </remarks>
    property DocType: string read FDocType write FDocType;
    /// <summary>
    ///   Identification document number of the account
    /// </summary>
    property DocNumber: string read FDocNumber write FDocNumber;
    /// <summary>
    ///   The code of the account if is a Pickup type of account
    /// </summary>
    property PickupCode: string read FPickupCode write FPickupCode;
    /// <summary>
    ///   The internal customer-own code of the account
    /// </summary>
    property OwnCode: string read FOwnCode write FOwnCode;
  end;

implementation

end.
