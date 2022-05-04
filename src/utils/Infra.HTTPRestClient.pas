unit Infra.HTTPRestClient;

interface

uses
  Classes, SysUtils, Generics.Collections, System.JSON,
  IdGlobal, IdHTTP, IdSSLOpenSSL, IdCTypes, IdSSLOpenSSLHeaders, IdURI, IdCompressorZLib, IdCookieManager;

Type

  TInfraHTTPRestMethod = (rmGET, rmPUT, rmPOST, rmPATCH, rmOPTIONS, rmDELETE);

  EInfraRESTException = class(Exception)
  end;

  TInfraHttpRestClient = class(TPersistent)
  private type
    TJSONValueError = (NoContent, NoJSON, InvalidRootElement);

    EJSONValueError = class(EInfraRESTException)
    private
      FError: TJSONValueError;
    public
      constructor Create(AError: TJSONValueError; const AMessage: string);
      property Error: TJSONValueError read FError;
    end;
  private type
    TResponseIndy = class(TObject)
    private
      {$IFDEF FPC}
      FJSONValue: TJSONData;
      {$ELSE}
      FJSONValue: TJSONValue;
      {$ENDIF}
      FIdHTTP: TIdHTTP;
    public
      constructor Create(const AIdHTTP: TIdHTTP);
      destructor Destroy; override;
    public
      function Content: string;
      function ContentLength: Cardinal;
      function ContentType: string;
      function ContentEncoding: string;
      function ContentStream: TStream;
      function StatusCode: Integer;
      function StatusText: string;
      function RawBytes: TBytes;
      {$IFDEF FPC}
      function JSONValue: TJSONData;
      {$ELSE}
      function JSONValue: TJSONValue;
      {$ENDIF}
      function Headers: TStrings;
    end;
  private type
    TRequestIndy = class(TObject)
    private
      FIdHTTP: TIdHTTP;
      FIdSSLIOHandlerSocketOpenSSL: TIdSSLIOHandlerSocketOpenSSL;
      FStreamResult: TStringStream;
      FStreamSend: TStream;
      FBaseURL: string;
      FResource: string;
      FResourcePrefix: string;
      FResourceSuffix: string;
      FQueryParams: TDictionary<string, string>;
      FUrlSegments: TStrings;
      FResponse: TResponseIndy;
      FRetries: Integer;
      FHeaders: TStrings;
      procedure _OnStatusInfoEx(ASender: TObject; const AsslSocket: PSSL; const AWhere, Aret: TIdC_INT; const AType, AMsg: string);
      function _CreateURL(const AIncludeParams: Boolean = True): string;
      procedure _ExecuteRequest(const AMethod: TInfraHTTPRestMethod);

    public
      constructor Create; virtual;
      destructor Destroy; override;

      function AcceptEncoding: string; overload;
      function AcceptEncoding(const AAcceptEncoding: string): TRequestIndy; overload;
      function AcceptCharset: string; overload;
      function AcceptCharset(const AAcceptCharset: string): TRequestIndy; overload;
      function Accept: string; overload;
      function Accept(const AAccept: string): TRequestIndy; overload;
      function Timeout: Integer; overload;
      function Timeout(const ATimeout: Integer): TRequestIndy; overload;
      function BaseURL(const ABaseURL: string): TRequestIndy; overload;
      function BaseURL: string; overload;
      function Resource(const AResource: string): TRequestIndy; overload;
      function Resource: string; overload;
      function ResourcePrefix(const AResourceSuffix: string): TRequestIndy; overload;
      function ResourcePrefix: string; overload;
      function ResourceSuffix(const AResourceSuffix: string): TRequestIndy; overload;
      function ResourceSuffix: string; overload;
      function RaiseExceptionOn500: Boolean; overload;
      function RaiseExceptionOn500(const ARaiseException: Boolean): TRequestIndy; overload;
      function Token(const AToken: string): TRequestIndy;
      function TokenBearer(const AToken: string): TRequestIndy;
      function BasicAuthentication(const AUsername, APassword: string): TRequestIndy;
      function Retry(const ARetries: Integer): TRequestIndy;
      function Get: TResponseIndy;
      function Post: TResponseIndy;
      function Put: TResponseIndy;
      function Delete: TResponseIndy;
      function Patch: TResponseIndy;
      function Options: TResponseIndy;
      function Response: TResponseIndy;
      function FullRequestURL(const AIncludeParams: Boolean = True): string;
      function ClearBody: TRequestIndy;
      function AddBody(const AContent: string): TRequestIndy; overload;
      function AddBody(const AContent: TJSONObject; const AOwns: Boolean = True): TRequestIndy; overload;
      function AddBody(const AContent: TJSONArray; const AOwns: Boolean = True): TRequestIndy; overload;
      function AddBody(const AContent: TObject; const AOwns: Boolean = True): TRequestIndy; overload;
      function AddBody(const AContent: TStream; const AOwns: Boolean = True): TRequestIndy; overload;
      function AddUrlSegment(const AName, AValue: string): TRequestIndy;
      function ClearHeaders: TRequestIndy;
      function AddHeader(const AName, AValue: string): TRequestIndy;
      function ClearParams: TRequestIndy;
      function ContentType(const AContentType: string): TRequestIndy;
      function UserAgent(const AName: string): TRequestIndy;
      function AddCookies(const ACookies: TStrings): TRequestIndy;
      function AddCookie(const ACookieName, ACookieValue: string): TRequestIndy;
      function AddParam(const AName, AValue: string): TRequestIndy;
      function AddFile(const AName: string; const AValue: TStream): TRequestIndy;
      function Proxy(const AServer, APassword, AUsername: string; const APort: Integer): TRequestIndy;
      function DeactivateProxy: TRequestIndy;

    end;
  private
    FRequest: TRequestIndy;
    function GetResponse: TResponseIndy;
  public
    constructor Create; virtual;
    destructor Destroy; override;

    property Request: TRequestIndy read FRequest write FRequest;
    property Response: TResponseIndy read GetResponse;

  end;

implementation

{ TAlephCRMHttpRestClientAbstract }

uses
  Neon.Core.Persistence.JSON,
  Neon.Core.Utils,
  AlephCRM.Providers.Consts;

constructor TInfraHttpRestClient.Create;
begin
  FRequest := TRequestIndy.Create;
end;

destructor TInfraHttpRestClient.Destroy;
begin
  FRequest.Free;
  inherited;
end;

function TInfraHttpRestClient.GetResponse: TResponseIndy;
begin
  Result := FRequest.Response;
end;

{ TAlephCRMHttpRestClientAbstract.EJSONValueError }

constructor TInfraHttpRestClient.EJSONValueError.Create(AError: TJSONValueError; const AMessage: string);
begin
  inherited Create(AMessage);
  FError := AError;
end;

{ TAlephCRMHttpRestClientAbstract.TResponseIndy }

function TInfraHttpRestClient.TResponseIndy.Content: string;
var
  LIndexContentType: Integer;
  LContentType: string;
  LStringStream: TStringStream;
begin
  LIndexContentType := FIdHTTP.Response.RawHeaders.IndexOfName('Content-Type');
  if LIndexContentType > -1 then
    LContentType := FIdHTTP.Response.RawHeaders.ValueFromIndex[LIndexContentType].ToLower;

  if LContentType.Contains('utf-8') then
    LStringStream := TStringStream.Create('', TEncoding.UTF8)
  else
    LStringStream := TStringStream.Create('', TEncoding.Default);
  try
    FIdHTTP.Response.ContentStream.Position := 0;
    LStringStream.CopyFrom(FIdHTTP.Response.ContentStream, FIdHTTP.Response.ContentStream.Size);
    Result := LStringStream.DataString;
  finally
    LStringStream.Free;
  end;
end;

function TInfraHttpRestClient.TResponseIndy.ContentEncoding: string;
begin
  Result := FIdHTTP.Response.ContentEncoding;
end;

function TInfraHttpRestClient.TResponseIndy.ContentLength: Cardinal;
begin
  Result := FIdHTTP.Response.ContentLength;
end;

function TInfraHttpRestClient.TResponseIndy.ContentStream: TStream;
begin
  Result := FIdHTTP.Response.ContentStream;
  Result.Position := 0;
end;

function TInfraHttpRestClient.TResponseIndy.ContentType: string;
begin
  Result := FIdHTTP.Response.ContentType;
end;

constructor TInfraHttpRestClient.TResponseIndy.Create(const AIdHTTP: TIdHTTP);
begin
  FIdHTTP := AIdHTTP;
end;

destructor TInfraHttpRestClient.TResponseIndy.Destroy;
begin
  if Assigned(FJSONValue) then
    FJSONValue.Free;
  inherited;
end;

function TInfraHttpRestClient.TResponseIndy.Headers: TStrings;
var
  i: Integer;
begin
  Result := TStringList.Create;
  for i := 0 to Pred(FIdHTTP.Response.RawHeaders.Count) do
    Result.Values[FIdHTTP.Response.RawHeaders.Names[i]] := FIdHTTP.Response.RawHeaders.Values[FIdHTTP.Response.RawHeaders.Names[i]];
end;

{$IFDEF FPC}


function TAlephCRMHttpRestClientAbstract.TResponseIndy.JSONValue: TJSONData;
var
  LContent: string;
  LJSONParser: TJSONParser;
begin
  if not(Assigned(FJSONValue)) then
  begin
    LContent := Content.Trim;
    LJSONParser := TJSONParser.Create(LContent, False);
    try
      if LContent.StartsWith('{') then
        FJSONValue := LJSONParser.Parse as TJSONObject
      else if LContent.StartsWith('[') then
        FJSONValue := LJSONParser.Parse as TJSONArray
      else
        raise Exception.Create('The return content is not a valid JSON value.');
    finally
      LJSONParser.Free;
    end;
  end;
  Result := FJSONValue;
end;
{$ELSE}


function TInfraHttpRestClient.TResponseIndy.JSONValue: TJSONValue;
var
  LContent: string;
begin
  if not(Assigned(FJSONValue)) then
  begin
    LContent := Content.Trim;
    if LContent.StartsWith('{') then
      FJSONValue := (TJSONObject.ParseJSONValue(LContent) as TJSONObject)
    else if LContent.StartsWith('[') then
      FJSONValue := (TJSONObject.ParseJSONValue(LContent) as TJSONArray)
    else
      raise Exception.Create('The return content is not a valid JSON value.');
  end;
  Result := FJSONValue;
end;
{$ENDIF}


function TInfraHttpRestClient.TResponseIndy.RawBytes: TBytes;
begin
  Result := TStringStream(FIdHTTP.Response.ContentStream).Bytes;
end;

function TInfraHttpRestClient.TResponseIndy.StatusCode: Integer;
begin
  Result := FIdHTTP.Response.ResponseCode;
end;

function TInfraHttpRestClient.TResponseIndy.StatusText: string;
begin
  Result := FIdHTTP.Response.ResponseText;
end;

{ TInfraHttpRestClient.TRequestIndy }

function TInfraHttpRestClient.TRequestIndy.Accept(const AAccept: string): TRequestIndy;
begin
  Result := Self;
  FIdHTTP.Request.Accept := AAccept;
end;

function TInfraHttpRestClient.TRequestIndy.Accept: string;
begin
  Result := FIdHTTP.Request.Accept;
end;

function TInfraHttpRestClient.TRequestIndy.AcceptCharset(const AAcceptCharset: string): TRequestIndy;
begin
  Result := Self;
  FIdHTTP.Request.AcceptCharset := AAcceptCharset;
end;

function TInfraHttpRestClient.TRequestIndy.AcceptCharset: string;
begin
  Result := FIdHTTP.Request.AcceptCharset;
end;

function TInfraHttpRestClient.TRequestIndy.AcceptEncoding: string;
begin
  Result := FIdHTTP.Request.AcceptEncoding;
end;

function TInfraHttpRestClient.TRequestIndy.AcceptEncoding(const AAcceptEncoding: string): TRequestIndy;
begin
  Result := Self;
  FIdHTTP.Request.AcceptEncoding := AAcceptEncoding;
end;

function TInfraHttpRestClient.TRequestIndy.AddBody(const AContent: TStream; const AOwns: Boolean): TRequestIndy;
begin
  Result := Self;
  try
    if not Assigned(FStreamSend) then
      FStreamSend := TStringStream.Create;
    TStringStream(FStreamSend).CopyFrom(AContent, AContent.Size);
    FStreamSend.Position := 0;
  finally
    if AOwns then
    begin
      {$IFDEF MSWINDOWS OR FPC}
      AContent.Free;
      {$ELSE}
      AContent.DisposeOf;
      {$ENDIF}
    end;
  end;
end;

function TInfraHttpRestClient.TRequestIndy.AddBody(const AContent: TObject; const AOwns: Boolean): TRequestIndy;
var
  LJSONObject: TJSONObject;
  {$IFDEF FPC}
  LJSONStreamer: TJSONStreamer;
  {$ENDIF}
begin
  {$IFDEF FPC}
  LJSONStreamer := TJSONStreamer.Create(NIL);
  LJSONObject := LJSONStreamer.ObjectToJSON(AContent);
  {$ELSE}
  LJSONObject := TNeon.ObjectToJSON(AContent) as TJSONObject;
  {$ENDIF}
  try
    Result := Self.AddBody(LJSONObject, False);
  finally
    {$IFDEF FPC}
    LJSONStreamer.Free;
    {$ENDIF}
    LJSONObject.Free;
    if AOwns then
    begin
      {$IFDEF MSWINDOWS OR FPC}
      AContent.Free;
      {$ELSE}
      AContent.DisposeOf;
      {$ENDIF}
    end;
  end;
end;

function TInfraHttpRestClient.TRequestIndy.AddBody(const AContent: string): TRequestIndy;
begin
  Result := Self;
  if not Assigned(FStreamSend) then
    FStreamSend := TStringStream.Create(AContent, TEncoding.UTF8)
  else
    TStringStream(FStreamSend).WriteString(AContent);
  FStreamSend.Position := 0;
end;

function TInfraHttpRestClient.TRequestIndy.AddBody(const AContent: TJSONObject; const AOwns: Boolean): TRequestIndy;
begin
  {$IFDEF FPC}
  Result := Self.AddBody(AContent.AsJSON);
  {$ELSE}
  Result := Self.AddBody(TJSONUtils.ToJSON(AContent));
  {$ENDIF}
  if AOwns then
  begin
    {$IFDEF MSWINDOWS OR FPC}
    AContent.Free;
    {$ELSE}
    AContent.DisposeOf;
    {$ENDIF}
  end;
end;

function TInfraHttpRestClient.TRequestIndy.AddBody(const AContent: TJSONArray; const AOwns: Boolean): TRequestIndy;
begin
  {$IFDEF FPC}
  Result := Self.AddBody(AContent.AsJSON);
  {$ELSE}
  Result := Self.AddBody(TJSONUtils.ToJSON(AContent));
  {$ENDIF}
  if AOwns then
  begin
    {$IFDEF MSWINDOWS OR FPC}
    AContent.Free;
    {$ELSE}
    AContent.DisposeOf;
    {$ENDIF}
  end;
end;

function TInfraHttpRestClient.TRequestIndy.AddCookie(const ACookieName, ACookieValue: string): TRequestIndy;
var
  cookies: TStringList;
begin
  cookies := TStringList.Create;
  cookies.AddPair(ACookieName, ACookieValue);
  Result := AddCookies(cookies);
end;

function TInfraHttpRestClient.TRequestIndy.AddCookies(const ACookies: TStrings): TRequestIndy;
var
  LURI: TIdURI;
begin
  Result := Self;
  LURI := TIdURI.Create(_CreateURL(False));
  try
    if not Assigned(FIdHTTP.CookieManager) then
      FIdHTTP.CookieManager := TIdCookieManager.Create(FIdHTTP);
    FIdHTTP.CookieManager.AddServerCookies(ACookies, LURI);
  finally
    {$IFDEF MSWINDOWS OR FPC}
    ACookies.Free;
    {$ELSE}
    ACookies.DisposeOf;
    {$ENDIF}
    LURI.Free;
  end;
end;

function TInfraHttpRestClient.TRequestIndy.AddFile(const AName: string; const AValue: TStream): TRequestIndy;
begin
  raise Exception.Create('Not implemented');
end;

function TInfraHttpRestClient.TRequestIndy.AddHeader(const AName, AValue: string): TRequestIndy;
begin
  Result := Self;
  if AName.Trim.IsEmpty or AValue.Trim.IsEmpty then
    Exit;
  if FHeaders.IndexOf(AName) < 0 then
    FHeaders.Add(AName);
  FIdHTTP.Request.CustomHeaders.AddValue(AName, AValue);
end;

function TInfraHttpRestClient.TRequestIndy.AddParam(const AName, AValue: string): TRequestIndy;
begin
  Result := Self;
  if (not AName.Trim.IsEmpty) and (not AValue.Trim.IsEmpty) then
    FQueryParams.AddOrSetValue(AName, AValue);
end;

function TInfraHttpRestClient.TRequestIndy.AddUrlSegment(const AName, AValue: string): TRequestIndy;
begin
  Result := Self;
  if AName.Trim.IsEmpty or AValue.Trim.IsEmpty then
    Exit;
  if not FullRequestURL(False).Contains(AName) then
  begin
    if (not ResourceSuffix.Trim.IsEmpty) and (not ResourceSuffix.EndsWith('/')) then
      ResourceSuffix(ResourceSuffix + '/');
    ResourceSuffix(ResourceSuffix + '{' + AName + '}');
  end;
  if FUrlSegments.IndexOf(AName) < 0 then
    FUrlSegments.Add(Format('%s=%s', [AName, AValue]));
end;

function TInfraHttpRestClient.TRequestIndy.BaseURL(
  const ABaseURL: string): TRequestIndy;
begin
  Result := Self;
  FBaseURL := ABaseURL;
end;

function TInfraHttpRestClient.TRequestIndy.BaseURL: string;
begin
  Result := FBaseURL;
end;

function TInfraHttpRestClient.TRequestIndy.BasicAuthentication(
  const AUsername, APassword: string): TRequestIndy;
begin
  Result := Self;
  FIdHTTP.Request.BasicAuthentication := True;
  FIdHTTP.Request.Username := AUsername;
  FIdHTTP.Request.Password := APassword;
end;

function TInfraHttpRestClient.TRequestIndy.ClearBody: TRequestIndy;
begin
  Result := Self;
  if Assigned(FStreamSend) then
    FreeAndNil(FStreamSend);
end;

function TInfraHttpRestClient.TRequestIndy.ClearHeaders: TRequestIndy;
var
  i: Integer;
begin
  Result := Self;
  for i := 0 to Pred(FHeaders.Count) do
    FIdHTTP.Request.CustomHeaders.Delete(FIdHTTP.Request.CustomHeaders.IndexOfName(FHeaders[i]));
end;

function TInfraHttpRestClient.TRequestIndy.ClearParams: TRequestIndy;
begin
  Result := Self;
  FQueryParams.Clear;
  FQueryParams.TrimExcess;
end;

function TInfraHttpRestClient.TRequestIndy.ContentType(const AContentType: string): TRequestIndy;
begin
  Result := Self;
  Self.AddHeader('Content-Type', AContentType);
end;

constructor TInfraHttpRestClient.TRequestIndy.Create;
begin

  FIdHTTP := TIdHTTP.Create(nil);
  FIdHTTP.Request.Connection := 'Keep-Alive';
  FIdHTTP.Request.UserAgent := 'User-Agent:Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.96 Safari/537.36';
  FIdHTTP.HandleRedirects := True;
  FIdHTTP.HTTPOptions := FIdHTTP.HTTPOptions - [hoNoProtocolErrorException];
  FIdHTTP.Compressor := TIdCompressorZLib.Create(FIdHTTP);
  FIdSSLIOHandlerSocketOpenSSL := TIdSSLIOHandlerSocketOpenSSL.Create;
  FIdHTTP.IOHandler := FIdSSLIOHandlerSocketOpenSSL;
  FIdSSLIOHandlerSocketOpenSSL.SSLOptions.SSLVersions := [sslvTLSv1, sslvTLSv1_1, sslvTLSv1_2];
  FIdSSLIOHandlerSocketOpenSSL.OnStatusInfoEx := Self._OnStatusInfoEx;

  FQueryParams := TDictionary<string, string>.Create;
  FHeaders := TStringList.Create;
  FUrlSegments := TStringList.Create;
  FStreamResult := TStringStream.Create;
  FResponse := TResponseIndy.Create(FIdHTTP);
  FRetries := 0;
  Self.ContentType('application/json');
  Self.AcceptCharset('UTF-8');
  Self.Accept('application/json');
  Self.AcceptEncoding('gzip, deflate');
  Self.Timeout(360000);

end;

function TInfraHttpRestClient.TRequestIndy.DeactivateProxy: TRequestIndy;
begin
  Result := Self;
  FIdHTTP.ProxyParams.ProxyServer := EmptyStr;
  FIdHTTP.ProxyParams.ProxyPassword := EmptyStr;
  FIdHTTP.ProxyParams.ProxyUsername := EmptyStr;
  FIdHTTP.ProxyParams.ProxyPort := 0;
end;

function TInfraHttpRestClient.TRequestIndy.Delete: TResponseIndy;
begin
  Result := FResponse;
  _ExecuteRequest(rmDELETE);
end;

destructor TInfraHttpRestClient.TRequestIndy.Destroy;
begin
  FreeAndNil(FIdSSLIOHandlerSocketOpenSSL);
  FreeAndNil(FIdHTTP);
  if Assigned(FStreamSend) then
    FreeAndNil(FStreamSend);
  FreeAndNil(FHeaders);
  FreeAndNil(FQueryParams);
  FreeAndNil(FUrlSegments);
  FreeAndNil(FStreamResult);
  inherited;
end;

function TInfraHttpRestClient.TRequestIndy.FullRequestURL(const AIncludeParams: Boolean): string;
begin
  Result := Self._CreateURL(AIncludeParams);
end;

function TInfraHttpRestClient.TRequestIndy.Get: TResponseIndy;
begin
  Result := FResponse;
  _ExecuteRequest(rmGET);
end;

function TInfraHttpRestClient.TRequestIndy.Options: TResponseIndy;
begin
  Result := FResponse;
  _ExecuteRequest(rmOPTIONS);
end;

function TInfraHttpRestClient.TRequestIndy.Patch: TResponseIndy;
begin
  Result := FResponse;
  _ExecuteRequest(rmPATCH);
end;

function TInfraHttpRestClient.TRequestIndy.Post: TResponseIndy;
begin
  Result := FResponse;
  _ExecuteRequest(rmPOST);
end;

function TInfraHttpRestClient.TRequestIndy.Proxy(const AServer, APassword, AUsername: string; const APort: Integer): TRequestIndy;
begin
  Result := Self;
  FIdHTTP.ProxyParams.ProxyServer := AServer;
  FIdHTTP.ProxyParams.ProxyPassword := APassword;
  FIdHTTP.ProxyParams.ProxyUsername := AUsername;
  FIdHTTP.ProxyParams.ProxyPort := APort;
end;

function TInfraHttpRestClient.TRequestIndy.Put: TResponseIndy;
begin
  Result := FResponse;
  _ExecuteRequest(rmPUT);
end;

function TInfraHttpRestClient.TRequestIndy.RaiseExceptionOn500: Boolean;
begin
  Result := not(hoNoProtocolErrorException in FIdHTTP.HTTPOptions);
end;

function TInfraHttpRestClient.TRequestIndy.RaiseExceptionOn500(
  const ARaiseException: Boolean): TRequestIndy;
begin
  Result := Self;
  if ARaiseException then
    FIdHTTP.HTTPOptions := FIdHTTP.HTTPOptions - [hoNoProtocolErrorException]
  else
    FIdHTTP.HTTPOptions := FIdHTTP.HTTPOptions + [hoNoProtocolErrorException];
end;

function TInfraHttpRestClient.TRequestIndy.Resource(
  const AResource: string): TRequestIndy;
begin
  Result := Self;
  FResource := AResource;
end;

function TInfraHttpRestClient.TRequestIndy.Resource: string;
begin
  Result := FResource;
end;

function TInfraHttpRestClient.TRequestIndy.ResourcePrefix: string;
begin
  Result := FResourcePrefix;
end;

function TInfraHttpRestClient.TRequestIndy.ResourcePrefix(
  const AResourceSuffix: string): TRequestIndy;
begin
  Result := Self;
  FResourcePrefix := AResourceSuffix;
end;

function TInfraHttpRestClient.TRequestIndy.ResourceSuffix(
  const AResourceSuffix: string): TRequestIndy;
begin
  Result := Self;
  FResourceSuffix := AResourceSuffix;
end;

function TInfraHttpRestClient.TRequestIndy.ResourceSuffix: string;
begin
  Result := FResourceSuffix;
end;

function TInfraHttpRestClient.TRequestIndy.Response: TResponseIndy;
begin
  Result := FResponse;
end;

function TInfraHttpRestClient.TRequestIndy.Retry(
  const ARetries: Integer): TRequestIndy;
begin
  Result := Self;
  FRetries := ARetries;
end;

function TInfraHttpRestClient.TRequestIndy.Timeout(const ATimeout: Integer): TRequestIndy;
begin
  Result := Self;
  FIdHTTP.ReadTimeout := ATimeout;
  FIdHTTP.ConnectTimeout := ATimeout;
end;

function TInfraHttpRestClient.TRequestIndy.Timeout: Integer;
begin
  Result := FIdHTTP.ReadTimeout;
end;

function TInfraHttpRestClient.TRequestIndy.Token(
  const AToken: string): TRequestIndy;
begin
  Result := Self;
  Self.AddHeader('Authorization', AToken);
end;

function TInfraHttpRestClient.TRequestIndy.TokenBearer(const AToken: string): TRequestIndy;
begin
  Result := Self;
  Self.AddHeader('Authorization', 'Bearer ' + AToken);
end;

function TInfraHttpRestClient.TRequestIndy.UserAgent(const AName: string): TRequestIndy;
begin
  Result := Self;
  FIdHTTP.Request.UserAgent := AName;
end;

function TInfraHttpRestClient.TRequestIndy._CreateURL(const AIncludeParams: Boolean = True): string;
var
  LParam: string;
  LQueryParams: TStringBuilder;
  i: Integer;
begin
  Result := FBaseURL;

  if not FResourcePrefix.Trim.IsEmpty then
  begin
    if (not Result.EndsWith('/')) and (not FResourcePrefix.StartsWith('/')) then
      Result := Result + '/';
    Result := Result + FResourcePrefix;
  end;
  if not FResource.Trim.IsEmpty then
  begin
    if (not Result.EndsWith('/')) and (not FResource.StartsWith('/')) then
      Result := Result + '/';
    Result := Result + FResource;
  end;
  if not FResourceSuffix.Trim.IsEmpty then
  begin
    if (not Result.EndsWith('/')) and (not FResourceSuffix.StartsWith('/')) then
      Result := Result + '/';
    Result := Result + FResourceSuffix;
  end;
  if FUrlSegments.Count > 0 then
  begin
    for i := 0 to Pred(FUrlSegments.Count) do
    begin
      Result := StringReplace(Result, Format('{%s}', [FUrlSegments.Names[i]]), FUrlSegments.ValueFromIndex[i], [rfReplaceAll, rfIgnoreCase]);
      Result := StringReplace(Result, Format(':%s', [FUrlSegments.Names[i]]), FUrlSegments.ValueFromIndex[i], [rfReplaceAll, rfIgnoreCase]);
    end;
  end;
  if not AIncludeParams then
    Exit;
  if FQueryParams.Count > 0 then
  begin
    LQueryParams := TStringBuilder.Create;
    try
      for LParam in FQueryParams.Keys do
      begin
        LQueryParams.AppendFormat('%s=%s&', [LParam, FQueryParams.Items[LParam]]);
      end;
      Result := Result + '?' + LQueryParams.Remove(LQueryParams.Length - 1, 1).ToString;
    finally
      LQueryParams.Free;
    end;
  end;
end;

procedure TInfraHttpRestClient.TRequestIndy._ExecuteRequest(const AMethod: TInfraHTTPRestMethod);
var
  LAttempts: Integer;
begin
  LAttempts := FRetries + 1;
  while LAttempts > 0 do
  begin
    try
      case AMethod of
        rmGET:
          FIdHTTP.Get(TIdURI.URLEncode(_CreateURL), FStreamResult);
        rmPOST:
          FIdHTTP.Post(TIdURI.URLEncode(_CreateURL), FStreamSend, FStreamResult);
        rmPUT:
          FIdHTTP.Put(TIdURI.URLEncode(_CreateURL), FStreamSend, FStreamResult);
        rmPATCH:
          FIdHTTP.Patch(TIdURI.URLEncode(_CreateURL), FStreamSend, FStreamResult);
        rmDELETE:
          FIdHTTP.Delete(TIdURI.URLEncode(_CreateURL), FStreamResult);
      end;
      LAttempts := 0;
    except
      begin
        LAttempts := LAttempts - 1;
        if LAttempts = 0 then
          raise;
      end;
    end;
  end;
end;

procedure TInfraHttpRestClient.TRequestIndy._OnStatusInfoEx(
  ASender: TObject; const AsslSocket: PSSL; const AWhere, Aret: TIdC_INT;
  const AType, AMsg: string);
begin
  SSL_set_tlsext_host_name(AsslSocket, FIdHTTP.URL.Host);
end;

end.
