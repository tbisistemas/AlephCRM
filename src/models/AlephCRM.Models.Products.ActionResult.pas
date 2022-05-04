unit AlephCRM.Models.Products.ActionResult;

interface

uses
  Generics.Collections,
  AlephCRM.Models.IdName;

{$M+}


type

  TAlephActionResultQuantities = class;
  TAlephItemResult = class;
  TValidationMessage = class;

  TAlephActionResult = class
  strict private
    FQuantities: TAlephActionResultQuantities;
    FItems: TList<TAlephItemResult>;
  public
    constructor Create;
    destructor Destroy; override;

  published
    property Quantities: TAlephActionResultQuantities read FQuantities write FQuantities;
    property Items: TList<TAlephItemResult> read FItems write FItems;
  end;

  TAlephActionResultQuantities = class
  strict private
    FOk: Integer;
    FError: Integer;
    FWarning: Integer;
    FInfo: Integer;
    FTotal: Integer;

  published
    property Ok: Integer read FOk write FOk;
    property Error: Integer read FError write FError;
    property Warning: Integer read FWarning write FWarning;
    property Info: Integer read FInfo write FInfo;
    property Total: Integer read FTotal write FTotal;
  end;

  TAlephItemResult = class
  strict private
    FItemNumber: Integer;
    FValidationLevel: TAlephIdName;
    FKeyField: string;
    FkeyValue: string;
    FMessages: TList<TValidationMessage>;
  public
    constructor Create;
    destructor Destroy; override;

  published
    property ItemNumber: Integer read FItemNumber write FItemNumber;
    property ValidationLevel: TAlephIdName read FValidationLevel write FValidationLevel;
    property KeyField: string read FKeyField write FKeyField;
    property keyValue: string read FkeyValue write FkeyValue;
    property Messages: TList<TValidationMessage> read FMessages write FMessages;
  end;

  TValidationMessage = class
  private
    FLevel: TAlephIdName;
    FCode: Integer;
    FMessage: string;
    FValidatedValue: string;
  public
    constructor Create;
    destructor Destroy; override;

  published
    property Level: TAlephIdName read FLevel write FLevel;
    property Code: Integer read FCode write FCode;
    property &Message: string read FMessage write FMessage;
    property ValidatedValue: string read FValidatedValue write FValidatedValue;
  end;

implementation

{ TAlephActionResult }

constructor TAlephActionResult.Create;
begin
  FQuantities := TAlephActionResultQuantities.Create;
  FItems := TList<TAlephItemResult>.Create;
end;

destructor TAlephActionResult.Destroy;
var
  LObj: TObject;
begin
  FQuantities.Free;
  for LObj in FItems do
  begin
    LObj.Free
  end;
  FItems.Free;
  inherited;
end;

{ TAlephItemResult }

constructor TAlephItemResult.Create;
begin
  FValidationLevel := TAlephIdName.Create;
  FMessages := TList<TValidationMessage>.Create;
end;

destructor TAlephItemResult.Destroy;
var
  LObj: TObject;
begin
  FValidationLevel.Free;
  for LObj in FMessages do
  begin
    LObj.Free;
  end;
  FMessages.Free;
  inherited;
end;

{ TValidationMessage }

constructor TValidationMessage.Create;
begin
  FLevel := TAlephIdName.Create;
end;

destructor TValidationMessage.Destroy;
begin
  FLevel.Free;
  inherited;
end;

end.
