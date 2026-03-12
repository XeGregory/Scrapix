unit Scrapix.Core;

interface

uses
  {Winapi}
  WinApi.Windows, WinApi.Messages,
  {System}
  System.SysUtils, System.Classes, System.Generics.Collections,
  System.RegularExpressions, System.Types, System.Net.HttpClient,
  System.Net.URLClient, System.IOUtils, System.Threading, System.SyncObjs,
  {Vcl}
  Vcl.ComCtrls, Vcl.StdCtrls, Vcl.CheckLst, Vcl.Graphics,
  {StyleControls VCL}
  scControls,
  {Translate.Core}
  Translate.Core;

const
  // États d'exploration
  STATE_RUNNING = 0;
  STATE_PAUSED = 1;
  STATE_CANCEL = 2;

  // User-Agent utilisé pour toutes les requêtes HTTP
  UserAgent = 'Scrapix/1.0';

type
  TScrapix = class
  private
    { --- Données de suivi et compteurs --- }
    VisitedLinks: TDictionary<string, Boolean>;
    FFoundFiles: TDictionary<string, Boolean>;
    FBrokenLinks: TDictionary<string, Boolean>;
    TotalLinks: Integer;
    FileCount: Integer;
    BrokenCount: Integer;
    FRobotsBlocked: Integer;
    FLinksTraversed: Integer;

    { --- Contrôle d'exécution --- }
    FState: Integer;
    FPauseEvent: TEvent;
    FStoppedEvent: TEvent;

    { --- Paramètres de crawl --- }
    RequestTimeoutMs: Integer;
    RequestDelayMs: Integer;
    SameDomainOnly: Boolean;
    RootDomain: string;

    { --- Téléchargement --- }
    FAutoDownload: Boolean;
    DownloadFolder: string;

    { --- Robots.txt --- }
    RobotsRules: TDictionary<string, TStringList>;
    FRespectRobots: Boolean;

    { --- Filtres de ressources --- }
    FSearchImages: Boolean;
    FSearchDocuments: Boolean;
    FSearchAudio: Boolean;
    FSearchVideo: Boolean;
    FSearchWeb: Boolean;

    { --- Exécution courante --- }
    FRunning: Boolean;
    FMaxDepth: Integer;

    { --- Chemins de rapports temporaires --- }
    FVisitedFilePath: string;
    FBrokenFilePath: string;
    FFoundFilePath: string;

    FLogFilePath: string;
    FLogLock: TCriticalSection;

    FDisableUIUpdates: Boolean;

    { --- Limites configurables --- }
    FFoundFilesLimit: Integer;
    FExploreLimit: Integer;

    { --- Fonctions internes --- }

    // Retourne true si les mises à jour UI sont autorisées
    function UIUpdatesAllowed: Boolean;

    // Récupère le contenu d'une URL via GET et met à jour le ListView (thread-safe)
    function GetWebContent(const URL: string; ListView: TscListView;
      Depth: Integer; Logging: TscListBox): string;

    // Extrait les liens <a href="..."> et normalise les URL
    procedure ExtractLinks(const HTML: string; BaseURL: string;
      var LinkList: TStringList);

    // Extrait sources médias (images, docs, audio, vidéo, ressources web) selon les flags actifs
    procedure ExtractMediaSources(const HTML: string; BaseURL: string;
      var ImageList, DocList, AudioList, VideoList, WebList: TStringList);

    // Incrémente le compteur d'URL bloquées par robots.txt et met à jour le StatusBar
    procedure IncrementRobotsBlocked(StatusBar: TscStatusBar);

    // Incrémente le compteur de liens parcourus et applique la limite d'exploration
    procedure IncrementLinksTraversed(StatusBar: TscStatusBar);

    // Traite et enregistre un lien cassé : UI, dictionnaire, fichier rapport
    procedure MarkBrokenLink(const URL: string; ListView: TscListView;
      StatusBar: TscStatusBar; Logging: TscListBox);

    // Vérifie la disponibilité d'un fichier via HEAD; fallback GET range si HEAD échoue
    function IsFileAvailable(const URL: string; ListView: TscListView;
      StatusBar: TscStatusBar; Depth: Integer; Logging: TscListBox): Boolean;

    // Télécharge une ressource dans le dossier de téléchargement (organisé par type)
    function DownloadFile(const URL: string; Client: THTTPClient;
      out LocalPath: string; Logging: TscListBox): Boolean;

    // Routine factorisée pour traiter une liste de ressources (vérif, robots, dispo, download)
    procedure ProcessResourceGroup(ResourceList: TStringList;
      const AcceptExts: array of string; StatusBar: TscStatusBar;
      ListView: TscListView; Depth: Integer; const DefaultUIType: string;
      Logging: TscListBox);

    // Traite toutes les listes de ressources extraites d'une page (appel ProcessResourceGroup)
    procedure ProcessFoundFiles(ImageList, DocList, AudioList, VideoList,
      WebList: TStringList; StatusBar: TscStatusBar; ListView: TscListView;
      CheckList: TscCheckListBox; Depth: Integer; Logging: TscListBox);

    // Exploration récursive d'une page : récupération, extraction, traitement, récursion
    procedure ExploreLinksRecursive(const URL: string; ListView: TscListView;
      StatusBar: TscStatusBar; CheckList: TscCheckListBox; Depth: Integer;
      Logging: TscListBox);

    // Vérifie si LinkURL appartient au même domaine que BaseURL (ou sous-domaine)
    function IsSameDomain(const BaseURL, LinkURL: string): Boolean;

    // Normalise une URL relative ou absolue en URL absolue utilisable
    function NormalizeURL(const BaseURL, RelOrAbsURL: string): string;

    // Wrappers thread-safe pour mise à jour ListView / StatusBar
    procedure SafeUpdateListViewStatus(ListView: TscListView;
      const URL, StatusText: string; const Method: string = '');
    procedure SafeUpdateListViewDownloadState(ListView: TscListView;
      const URL, DownloadState: string);
    procedure SafeUpdateListViewInfo(ListView: TscListView; const URL: string;
      RespMs: Integer; const SizeBytes: string; Depth: Integer);
    procedure SafeScrollListViewToBottom(ListView: TscListView);
    procedure SafeSetStatusBarPanel(StatusBar: TscStatusBar;
      PanelIndex: Integer; const Text: string);

    // Logging thread-safe vers une TscListBox
    procedure SafeLog(Logging: TscListBox; const Msg: string);

    // robots.txt helpers : parse, cache et vérifie l'autorisation
    function ParseRobots(const RobotsText: string;
      OutList: TStringList): Boolean;
    function EnsureRobotsForHost(const Host, Scheme: string): Boolean;
    function IsAllowedByRobots(const URL: string): Boolean;

  public
    // Constructeur : initialise structure et valeurs par défaut
    constructor Create;
    // Destructeur : annule, attend et libère ressources
    destructor Destroy; override;

    // Configure les paramètres du crawl (timeouts, limites, options)
    procedure ConfigureCrawl(const ARequestTimeoutMs, ARequestDelayMs: Integer;
      ASameDomainOnly: Boolean; AAutoDownload: Boolean; ARespectRobots: Boolean;
      AFoundFilesLimit: Integer; AExploreLimit: Integer);

    // Démarre l'exploration synchroniquement ; crée rapports si demandé
    procedure ExploreLinks(const URL: string; ListView: TscListView;
      StatusBar: TscStatusBar; CheckList: TscCheckListBox; MaxDepth: Integer;
      SaveBrokenToFile, SaveVisitedToFile, SaveFoundFilesToFile: Boolean;
      Logging: TscListBox);

    // Mettre en pause, reprendre ou annuler l'exploration
    procedure PauseExploration;
    procedure ResumeExploration;
    procedure CancelExploration;
    function IsCanceled: Boolean;
    function IsPaused: Boolean;
    function IsRunning: Boolean;

    // Attend l'arrêt complet (bloquant) ; supprime le paramètre Timeout
    function WaitForStop: Boolean;

    // Applique les filtres de types de fichiers depuis une CheckList UI
    procedure ApplyFileTypeFiltersFromCheckList(CheckList: TscCheckListBox);

    // Autorise la désactivation des mises à jour UI (tests, performances)
    property DisableUIUpdates: Boolean read FDisableUIUpdates
      write FDisableUIUpdates;
  end;

implementation

uses
  System.Net.Mime, System.StrUtils;

function TScrapix.UIUpdatesAllowed: Boolean;
begin
  Result := not FDisableUIUpdates;
end;

procedure TScrapix.SafeScrollListViewToBottom(ListView: TscListView);
begin
  if not UIUpdatesAllowed then
    Exit;
  if ListView = nil then
    Exit;

  if TThread.Current.ThreadID = MainThreadID then
  begin
    if (csDestroying in ListView.ComponentState) or
      (not ListView.HandleAllocated) then
      Exit;
    if ListView.Items.Count > 0 then
      ListView.Items[ListView.Items.Count - 1].MakeVisible(False);
  end
  else
  begin
    TThread.Queue(nil,
      procedure
      begin
        if not UIUpdatesAllowed then
          Exit;
        if (ListView = nil) or (csDestroying in ListView.ComponentState) or
          (not ListView.HandleAllocated) then
          Exit;
        if ListView.Items.Count > 0 then
          ListView.Items[ListView.Items.Count - 1].MakeVisible(False);
      end);
  end;
end;

procedure TScrapix.SafeSetStatusBarPanel(StatusBar: TscStatusBar;
PanelIndex: Integer; const Text: string);
begin
  if not UIUpdatesAllowed then
    Exit;
  if StatusBar = nil then
    Exit;
  if PanelIndex < 0 then
    Exit;

  if TThread.Current.ThreadID = MainThreadID then
  begin
    if (csDestroying in StatusBar.ComponentState) or
      (not StatusBar.HandleAllocated) then
      Exit;
    if PanelIndex < StatusBar.Panels.Count then
      StatusBar.Panels[PanelIndex].Text := Text;
  end
  else
  begin
    TThread.Queue(nil,
      procedure
      begin
        if not UIUpdatesAllowed then
          Exit;
        if (StatusBar = nil) or (csDestroying in StatusBar.ComponentState) or
          (not StatusBar.HandleAllocated) then
          Exit;
        if PanelIndex < StatusBar.Panels.Count then
          StatusBar.Panels[PanelIndex].Text := Text;
      end);
  end;
end;

procedure TScrapix.SafeUpdateListViewStatus(ListView: TscListView;
const URL, StatusText: string; const Method: string = '');
var
  sURL, sStatus, sMethod: string;
  I: Integer;
  Item: TListItem;
begin
  if not UIUpdatesAllowed then
    Exit;
  if ListView = nil then
    Exit;

  sURL := NormalizeURL(URL, URL);
  if sURL = '' then
    sURL := URL;
  sStatus := StatusText;
  sMethod := Method;

  if TThread.Current.ThreadID = MainThreadID then
  begin
    if (csDestroying in ListView.ComponentState) or
      (not ListView.HandleAllocated) then
      Exit;

    for I := 0 to ListView.Items.Count - 1 do
    begin
      Item := ListView.Items[I];
      if SameText(Item.Caption, sURL) or SameText(Item.Caption, URL) then
      begin
        while Item.SubItems.Count < 6 do
          Item.SubItems.Add('');
        Item.SubItems[0] := sStatus;
        Item.SubItems[5] := sMethod;
        SafeScrollListViewToBottom(ListView);
        Exit;
      end;
    end;

    Item := ListView.Items.Add;
    Item.Caption := sURL;
    while Item.SubItems.Count < 6 do
      Item.SubItems.Add('');
    Item.SubItems[0] := sStatus;
    Item.SubItems[5] := sMethod;
    SafeScrollListViewToBottom(ListView);
  end
  else
  begin
    TThread.Queue(nil,
      procedure
      var
        I2: Integer;
        It: TListItem;
      begin
        if not UIUpdatesAllowed then
          Exit;
        if (ListView = nil) or (csDestroying in ListView.ComponentState) or
          (not ListView.HandleAllocated) then
          Exit;
        for I2 := 0 to ListView.Items.Count - 1 do
        begin
          It := ListView.Items[I2];
          if SameText(It.Caption, sURL) or SameText(It.Caption, URL) then
          begin
            while It.SubItems.Count < 6 do
              It.SubItems.Add('');
            It.SubItems[0] := sStatus;
            It.SubItems[5] := sMethod;
            SafeScrollListViewToBottom(ListView);
            Exit;
          end;
        end;
        It := ListView.Items.Add;
        It.Caption := sURL;
        while It.SubItems.Count < 6 do
          It.SubItems.Add('');
        It.SubItems[0] := sStatus;
        It.SubItems[5] := sMethod;
        SafeScrollListViewToBottom(ListView);
      end);
  end;
end;

procedure TScrapix.SafeUpdateListViewDownloadState(ListView: TscListView;
const URL, DownloadState: string);
var
  sURL, sState: string;
  I: Integer;
  Item: TListItem;
begin
  if not UIUpdatesAllowed then
    Exit;
  if ListView = nil then
    Exit;

  sURL := NormalizeURL(URL, URL);
  if sURL = '' then
    sURL := URL;
  sState := DownloadState;

  if TThread.Current.ThreadID = MainThreadID then
  begin
    if (csDestroying in ListView.ComponentState) or
      (not ListView.HandleAllocated) then
      Exit;
    for I := 0 to ListView.Items.Count - 1 do
    begin
      Item := ListView.Items[I];
      if SameText(Item.Caption, sURL) or SameText(Item.Caption, URL) then
      begin
        while Item.SubItems.Count < 6 do
          Item.SubItems.Add('');
        Item.SubItems[1] := sState;
        SafeScrollListViewToBottom(ListView);
        Exit;
      end;
    end;
    Item := ListView.Items.Add;
    Item.Caption := sURL;
    while Item.SubItems.Count < 6 do
      Item.SubItems.Add('');
    Item.SubItems[1] := sState;
    SafeScrollListViewToBottom(ListView);
  end
  else
  begin
    TThread.Queue(nil,
      procedure
      var
        I2: Integer;
        It: TListItem;
      begin
        if not UIUpdatesAllowed then
          Exit;
        if (ListView = nil) or (csDestroying in ListView.ComponentState) or
          (not ListView.HandleAllocated) then
          Exit;
        for I2 := 0 to ListView.Items.Count - 1 do
        begin
          It := ListView.Items[I2];
          if SameText(It.Caption, sURL) or SameText(It.Caption, URL) then
          begin
            while It.SubItems.Count < 6 do
              It.SubItems.Add('');
            It.SubItems[1] := sState;
            SafeScrollListViewToBottom(ListView);
            Exit;
          end;
        end;
        It := ListView.Items.Add;
        It.Caption := sURL;
        while It.SubItems.Count < 6 do
          It.SubItems.Add('');
        It.SubItems[1] := sState;
        SafeScrollListViewToBottom(ListView);
      end);
  end;
end;

procedure TScrapix.SafeUpdateListViewInfo(ListView: TscListView;
const URL: string; RespMs: Integer; const SizeBytes: string; Depth: Integer);
var
  sURL, sRespMs, sSizeLocal, sDepth: string;
  DepthLocal: Integer;
  I: Integer;
  Item: TListItem;
begin
  if not UIUpdatesAllowed then
    Exit;
  if ListView = nil then
    Exit;

  sURL := NormalizeURL(URL, URL);
  if sURL = '' then
    sURL := URL;

  if RespMs < 0 then
    sRespMs := ''
  else
    sRespMs := IntToStr(RespMs);
  sSizeLocal := SizeBytes;
  DepthLocal := Depth;
  if DepthLocal > 0 then
    sDepth := IntToStr(DepthLocal)
  else
    sDepth := '';

  if TThread.Current.ThreadID = MainThreadID then
  begin
    if (csDestroying in ListView.ComponentState) or
      (not ListView.HandleAllocated) then
      Exit;
    for I := 0 to ListView.Items.Count - 1 do
    begin
      Item := ListView.Items[I];
      if SameText(Item.Caption, sURL) or SameText(Item.Caption, URL) then
      begin
        while Item.SubItems.Count < 6 do
          Item.SubItems.Add('');
        Item.SubItems[2] := sRespMs;
        Item.SubItems[3] := sSizeLocal;
        if sDepth <> '' then
          Item.SubItems[4] := sDepth;
        SafeScrollListViewToBottom(ListView);
        Exit;
      end;
    end;
    Item := ListView.Items.Add;
    Item.Caption := sURL;
    while Item.SubItems.Count < 6 do
      Item.SubItems.Add('');
    Item.SubItems[2] := sRespMs;
    Item.SubItems[3] := sSizeLocal;
    if sDepth <> '' then
      Item.SubItems[4] := sDepth;
    SafeScrollListViewToBottom(ListView);
  end
  else
  begin
    TThread.Queue(nil,
      procedure
      begin
        if not UIUpdatesAllowed then
          Exit;
        SafeUpdateListViewInfo(ListView, URL, RespMs, SizeBytes, Depth);
      end);
  end;
end;

procedure TScrapix.SafeLog(Logging: TscListBox; const Msg: string);
const
  HORIZONTAL_MARGIN = 16;
var
  NewWidth, CurrExtent, ClientW: Integer;
  CanvasHandle: TCanvas;
  S: string;
begin
  S := Msg;

  if UIUpdatesAllowed and (Logging <> nil) then
  begin
    if TThread.Current.ThreadID = MainThreadID then
    begin
      if (not(csDestroying in Logging.ComponentState)) and Logging.HandleAllocated
      then
      begin
        try
          Logging.Items.Add(S);
          Logging.ItemIndex := Logging.Items.Count - 1;
        except
        end;
        try
          CanvasHandle := Logging.Canvas;
          NewWidth := CanvasHandle.TextWidth(S) + HORIZONTAL_MARGIN;
        except
          NewWidth := 0;
        end;
        if NewWidth > 0 then
        begin
          CurrExtent := SendMessage(Logging.Handle,
            LB_GETHORIZONTALEXTENT, 0, 0);
          if NewWidth > CurrExtent then
            SendMessage(Logging.Handle, LB_SETHORIZONTALEXTENT, NewWidth, 0)
          else
          begin
            ClientW := Logging.ClientWidth;
            if CurrExtent < ClientW then
              SendMessage(Logging.Handle, LB_SETHORIZONTALEXTENT, ClientW, 0);
          end;
        end;
      end;
    end
    else
    begin
      TThread.Queue(nil,
        procedure
        var
          W: Integer;
          Ce: Integer;
          Cw: Integer;
        begin
          if not UIUpdatesAllowed then
            Exit;
          if (Logging = nil) or (csDestroying in Logging.ComponentState) or
            (not Logging.HandleAllocated) then
            Exit;
          try
            Logging.Items.Add(S);
            Logging.ItemIndex := Logging.Items.Count - 1;
          except
          end;
          try
            W := Logging.Canvas.TextWidth(S) + HORIZONTAL_MARGIN;
          except
            W := 0;
          end;
          if W > 0 then
          begin
            Ce := SendMessage(Logging.Handle, LB_GETHORIZONTALEXTENT, 0, 0);
            if W > Ce then
              SendMessage(Logging.Handle, LB_SETHORIZONTALEXTENT, W, 0)
            else
            begin
              Cw := Logging.ClientWidth;
              if Ce < Cw then
                SendMessage(Logging.Handle, LB_SETHORIZONTALEXTENT, Cw, 0);
            end;
          end;
        end);
    end;
  end;

  if (FLogFilePath <> '') and Assigned(FLogLock) then
  begin
    try
      FLogLock.Acquire;
      try
        try
          TFile.AppendAllText(FLogFilePath, S + sLineBreak, TEncoding.UTF8);
        except
        end;
      finally
        FLogLock.Release;
      end;
    except
    end;
  end;
end;

function TScrapix.NormalizeURL(const BaseURL, RelOrAbsURL: string): string;
var
  S: string;
  BaseUri: TURI;
  SchemeHost, BasePath, BaseTrimmed: string;
  Idx: Integer;
begin
  Result := '';
  S := Trim(RelOrAbsURL);
  if S = '' then
    Exit;

  Idx := Pos('#', S);
  if Idx > 0 then
    Delete(S, Idx, MaxInt);

  if S.StartsWith('mailto:', True) or S.StartsWith('javascript:', True) or
    S.StartsWith('tel:', True) or S.StartsWith('data:', True) then
    Exit;

  if S.StartsWith('//') then
  begin
    Result := 'https:' + S;
    Exit;
  end;

  if S.StartsWith('http://', True) or S.StartsWith('https://', True) then
  begin
    try
      Result := TURI.Create(S).ToString
    except
      Result := S
    end;
    Exit;
  end;

  if BaseURL = '' then
    Exit;
  try
    BaseUri := TURI.Create(BaseURL)
  except
    Exit
  end;

  SchemeHost := BaseUri.Scheme + '://' + BaseUri.Host;
  if BaseUri.Port > 0 then
    SchemeHost := SchemeHost + ':' + IntToStr(BaseUri.Port);

  if S.StartsWith('/') then
  begin
    Result := SchemeHost + S;
    Exit;
  end;

  BasePath := BaseUri.Path;
  if (BasePath = '') or BasePath.EndsWith('/') then
    BaseTrimmed := BasePath
  else
    BaseTrimmed := ExtractFilePath(BasePath);
  if (BaseTrimmed = '') or (BaseTrimmed[1] <> '/') then
    BaseTrimmed := '/' + BaseTrimmed;

  Result := SchemeHost + BaseTrimmed;
  if not Result.EndsWith('/') then
    Result := Result + '/';
  Result := Result + S;

  try
    Result := TURI.Create(Result).ToString
  except
  end;
end;

function GetResponseHeaderValue(const Resp: IHTTPResponse;
const HeaderName: string): string;
var
  I: Integer;
begin
  Result := '';
  if Resp = nil then
    Exit;
  for I := 0 to Length(Resp.Headers) - 1 do
    if SameText(Resp.Headers[I].Name, HeaderName) then
      Exit(Resp.Headers[I].Value);
end;

function FormatBytes(const SizeBytes: string): string;
var
  Bytes: Int64;
  d: Double;
  DigitsOnly: string;
begin
  Result := '';
  if Trim(SizeBytes) = '' then
    Exit;
  if Trim(SizeBytes).ToLower = 'n/a' then
  begin
    Result := 'n/a';
    Exit;
  end;

  try
    Bytes := StrToInt64(Trim(SizeBytes))
  except
    DigitsOnly := TRegEx.Replace(SizeBytes, '[^0-9]', '');
    if DigitsOnly = '' then
      Exit;
    try
      Bytes := StrToInt64(DigitsOnly)
    except
      Exit
    end;
  end;

  if Bytes = 0 then
  begin
    Result := 'n/a';
    Exit;
  end;

  if Bytes < 1024 then
    Result := Format('%d Octets', [Bytes])
  else if Bytes < Int64(1024) * 1024 then
  begin
    d := Bytes / 1024;
    Result := FormatFloat('0.##', d) + ' Ko';
  end
  else if Bytes < Int64(1024) * 1024 * 1024 then
  begin
    d := Bytes / (1024 * 1024);
    Result := FormatFloat('0.##', d) + ' Mo';
  end
  else
  begin
    d := Bytes / (1024 * 1024 * 1024);
    Result := FormatFloat('0.##', d) + ' Go';
  end;
end;

function TScrapix.ParseRobots(const RobotsText: string;
OutList: TStringList): Boolean;
var
  Lines: TArray<string>;
  I: Integer;
  CurrentAgents: TStringList;
  L: string;
  AgentMatched: Boolean;
  PathPart: string;
begin
  Result := False;
  OutList.Clear;
  if RobotsText = '' then
    Exit;

  Lines := RobotsText.Split([#13#10, #10, #13],
    TStringSplitOptions.ExcludeEmpty);
  CurrentAgents := TStringList.Create;
  try
    CurrentAgents.Clear;
    AgentMatched := False;
    for I := 0 to Length(Lines) - 1 do
    begin
      L := Trim(Lines[I]);
      if L = '' then
      begin
        CurrentAgents.Clear;
        AgentMatched := False;
        Continue;
      end;

      if StartsText('User-agent:', L) then
      begin
        CurrentAgents.Clear;
        CurrentAgents.Add(Trim(Copy(L, Length('User-agent:') + 1, MaxInt)
          ).ToLower);
        AgentMatched := SameText(CurrentAgents[0], 'Scrapix') or
          SameText(CurrentAgents[0], '*');
        Continue;
      end;

      if AgentMatched and StartsText('Disallow:', L) then
      begin
        PathPart := Trim(Copy(L, Length('Disallow:') + 1, MaxInt));
        if PathPart = '' then
          Continue;
        if not PathPart.StartsWith('/') then
          PathPart := '/' + PathPart;
        if OutList.IndexOf(PathPart) = -1 then
          OutList.Add(PathPart);
      end;
    end;
  finally
    CurrentAgents.Free;
  end;
  Result := True;
end;

function TScrapix.EnsureRobotsForHost(const Host, Scheme: string): Boolean;
var
  Key: string;
  RobotsURL, RobotsText: string;
  Client: THTTPClient;
  RespStream: TStringStream;
  Resp: IHTTPResponse;
  SL, NewSL: TStringList;
begin
  if Host = '' then
    Exit(False);
  Key := LowerCase(Host);
  if RobotsRules = nil then
    RobotsRules := TDictionary<string, TStringList>.Create;
  if RobotsRules.ContainsKey(Key) then
    Exit(True);

  RobotsURL := Scheme + '://' + Host + '/robots.txt';

  Client := THTTPClient.Create;
  try
    Client.ConnectionTimeout := RequestTimeoutMs;
    Client.ResponseTimeout := RequestTimeoutMs;
    Client.UserAgent := UserAgent;
    RespStream := TStringStream.Create('', TEncoding.UTF8);
    try
      try
        Resp := Client.Get(RobotsURL, RespStream);
        RobotsText := RespStream.DataString
      except
        RobotsText := '';
      end;
    finally
      RespStream.Free;
    end;
  finally
    Client.Free;
  end;

  SL := TStringList.Create;
  try
    ParseRobots(RobotsText, SL);
    NewSL := TStringList.Create;
    NewSL.Assign(SL);
    RobotsRules.Add(Key, NewSL);
  finally
    SL.Free;
  end;
  Result := True;
end;

function TScrapix.IsAllowedByRobots(const URL: string): Boolean;
var
  Host, Scheme, Path: string;
  Rules: TStringList;
  Key: string;
  U: TURI;
  I: Integer;
  DisallowPath: string;
begin
  if not FRespectRobots then
    Exit(True);
  Result := True;
  if URL = '' then
    Exit(True);

  try
    U := TURI.Create(URL);
    Host := U.Host;
    Scheme := U.Scheme;
    Path := U.Path;
    if Path = '' then
      Path := '/';
  except
    Exit(True);
  end;

  Key := LowerCase(Host);
  if (RobotsRules = nil) or (not RobotsRules.ContainsKey(Key)) then
    EnsureRobotsForHost(Host, Scheme);

  if (RobotsRules <> nil) and RobotsRules.ContainsKey(Key) then
  begin
    Rules := RobotsRules[Key];
    for I := 0 to Rules.Count - 1 do
    begin
      DisallowPath := Rules[I];
      if Path.StartsWith(DisallowPath, True) then
      begin
        Result := False;
        Exit;
      end;
    end;
  end;
end;

constructor TScrapix.Create;
begin
  inherited Create;
  VisitedLinks := nil;
  FFoundFiles := nil;
  RequestTimeoutMs := 30000;
  RequestDelayMs := 0;
  SameDomainOnly := True;

  FState := STATE_RUNNING;
  FPauseEvent := TEvent.Create(nil, True, True, '');
  FStoppedEvent := TEvent.Create(nil, True, True, '');

  TotalLinks := 0;
  FileCount := 0;
  BrokenCount := 0;
  FRobotsBlocked := 0;
  FLinksTraversed := 0;

  FAutoDownload := False;
  DownloadFolder := '';

  RobotsRules := nil;
  FRespectRobots := True;

  FSearchImages := True;
  FSearchDocuments := True;
  FSearchAudio := True;
  FSearchVideo := True;
  FSearchWeb := True;

  FFoundFiles := TDictionary<string, Boolean>.Create;
  FBrokenLinks := TDictionary<string, Boolean>.Create;

  FRunning := False;
  FMaxDepth := 0;

  FFoundFilesLimit := 2000;
  FExploreLimit := 100;

  FVisitedFilePath := '';
  FBrokenFilePath := '';
  FFoundFilePath := '';

  FLogFilePath := '';
  FLogLock := TCriticalSection.Create;

  FDisableUIUpdates := False;
end;

destructor TScrapix.Destroy;
var
  SL: TStringList;
begin
  CancelExploration;
  WaitForStop;

  FreeAndNil(VisitedLinks);
  FreeAndNil(FFoundFiles);
  FreeAndNil(FBrokenLinks);

  FreeAndNil(FPauseEvent);
  FreeAndNil(FStoppedEvent);

  FreeAndNil(FLogLock);

  if Assigned(RobotsRules) then
  begin
    for SL in RobotsRules.Values do
      SL.Free;
    RobotsRules.Free;
  end;

  inherited;
end;

procedure TScrapix.PauseExploration;
begin
  TInterlocked.Exchange(FState, STATE_PAUSED);
  if Assigned(FPauseEvent) then
    FPauseEvent.ResetEvent;
end;

procedure TScrapix.ResumeExploration;
begin
  TInterlocked.Exchange(FState, STATE_RUNNING);
  if Assigned(FPauseEvent) then
    FPauseEvent.SetEvent;
end;

procedure TScrapix.CancelExploration;
begin
  TInterlocked.Exchange(FState, STATE_CANCEL);
  if Assigned(FPauseEvent) then
    FPauseEvent.SetEvent;
end;

function TScrapix.IsCanceled: Boolean;
begin
  Result := TInterlocked.CompareExchange(FState, 0, 0) = STATE_CANCEL;
end;

function TScrapix.IsPaused: Boolean;
begin
  Result := TInterlocked.CompareExchange(FState, 0, 0) = STATE_PAUSED;
end;

function TScrapix.IsRunning: Boolean;
begin
  Result := TInterlocked.CompareExchange(PInteger(@FRunning)^, 0, 0) <> 0;
end;

function TScrapix.WaitForStop: Boolean;
begin
  CancelExploration;

  if Assigned(FStoppedEvent) then
  begin
    Result := FStoppedEvent.WaitFor(INFINITE) = wrSignaled;
    Exit;
  end;

  while FRunning do
    Sleep(20);
  Result := not FRunning;
end;

procedure TScrapix.ConfigureCrawl(const ARequestTimeoutMs, ARequestDelayMs
  : Integer; ASameDomainOnly: Boolean; AAutoDownload: Boolean;
ARespectRobots: Boolean; AFoundFilesLimit: Integer; AExploreLimit: Integer);
begin
  if ARequestTimeoutMs <= 0 then
    RequestTimeoutMs := 30000
  else
    RequestTimeoutMs := ARequestTimeoutMs;
  if ARequestDelayMs < 0 then
    RequestDelayMs := 0
  else
    RequestDelayMs := ARequestDelayMs;
  SameDomainOnly := ASameDomainOnly;

  FAutoDownload := AAutoDownload;
  FRespectRobots := ARespectRobots;

  if AFoundFilesLimit < 1 then
    FFoundFilesLimit := 1
  else if AFoundFilesLimit > 2000 then
    FFoundFilesLimit := 2000
  else
    FFoundFilesLimit := AFoundFilesLimit;

  if AExploreLimit < 1 then
    FExploreLimit := 1
  else if AExploreLimit > 100 then
    FExploreLimit := 100
  else
    FExploreLimit := AExploreLimit;
end;

function TScrapix.GetWebContent(const URL: string; ListView: TscListView;
Depth: Integer; Logging: TscListBox): string;
var
  Client: THTTPClient;
  Mem: TMemoryStream;
  Resp: IHTTPResponse;
  ContentType, ContentLength: string;
  StatusCode: Integer;
  NormURL: string;
  StartTick, EndTick, ElapsedMs: Cardinal;
  S: RawByteString;
  I: Integer;
begin
  Result := '';
  if URL = '' then
    Exit;
  NormURL := NormalizeURL(URL, URL);
  if NormURL = '' then
    Exit;

  Client := THTTPClient.Create;
  try
    Client.ConnectionTimeout := RequestTimeoutMs;
    Client.ResponseTimeout := RequestTimeoutMs;
    Client.UserAgent := UserAgent;
    Mem := TMemoryStream.Create;
    try
      try
        StartTick := GetTickCount;
        Resp := Client.Get(NormURL, Mem);
        EndTick := GetTickCount;
        ElapsedMs := EndTick - StartTick;

        StatusCode := -1;
        ContentType := '';
        ContentLength := '';
        if Resp <> nil then
        begin
          StatusCode := Resp.StatusCode;
          ContentType := GetResponseHeaderValue(Resp, 'Content-Type');
          ContentLength := GetResponseHeaderValue(Resp, 'Content-Length');
          if ContentLength = '' then
            ContentLength := GetResponseHeaderValue(Resp, 'Content-Range');
          if (ContentLength <> '') and ContentLength.StartsWith('bytes', True)
          then
          begin
            I := LastDelimiter('/', ContentLength);
            if I > 0 then
              ContentLength := Copy(ContentLength, I + 1, MaxInt);
          end;
        end;

        if ContentLength = '' then
          ContentLength := IntToStr(Mem.Size);

        if Mem.Size > 0 then
        begin
          SetLength(S, Mem.Size);
          Mem.Position := 0;
          Mem.ReadBuffer(S[1], Mem.Size);
          Result := string(S);
        end
        else
          Result := '';

        if Assigned(ListView) then
        begin
          SafeUpdateListViewStatus(ListView, NormURL,
            Format('%d %s', [StatusCode, ContentType]), 'GET');
          SafeUpdateListViewInfo(ListView, NormURL, ElapsedMs,
            FormatBytes(ContentLength), Depth);
        end;

        if Assigned(Logging) then
          SafeLog(Logging, Format('GET %s -> %d %s (%s)', [NormURL, StatusCode,
            ContentType, FormatBytes(ContentLength)]));
      except
        on E: Exception do
        begin
          if Assigned(ListView) then
          begin
            SafeUpdateListViewStatus(ListView, NormURL,
              'Exception : ' + E.Message, 'GET');
            SafeUpdateListViewInfo(ListView, NormURL, -1, '', Depth);
          end;
          if Assigned(Logging) then
            SafeLog(Logging, Format('GET Exception %s : %s',
              [NormURL, E.Message]));
          Result := '';
        end;
      end;
    finally
      Mem.Free;
    end;

    if RequestDelayMs > 0 then
      TThread.Sleep(RequestDelayMs);
  finally
    Client.Free;
  end;
end;

procedure TScrapix.ExtractLinks(const HTML: string; BaseURL: string;
var LinkList: TStringList);
var
  Regex: TRegEx;
  Match: TMatch;
  RawLink, Link: string;
begin
  Regex := TRegEx.Create('<a\s+(?:[^>]*?\s+)?href="([^"]*)"', [roIgnoreCase]);
  Match := Regex.Match(HTML);
  while Match.Success do
  begin
    RawLink := Match.Groups[1].Value.Trim;
    Match := Match.NextMatch;
    if RawLink = '' then
      Continue;
    Link := NormalizeURL(BaseURL, RawLink);
    if Link = '' then
      Continue;
    if (VisitedLinks = nil) or not VisitedLinks.ContainsKey(Link) then
      if LinkList.IndexOf(Link) = -1 then
        LinkList.Add(Link);
  end;
end;

function RemoveURLParams(const URL: string): string;
var
  P: Integer;
begin
  Result := URL;
  P := Pos('?', Result);
  if P > 0 then
    Result := Copy(Result, 1, P - 1);
end;

procedure TScrapix.ExtractMediaSources(const HTML: string; BaseURL: string;
var ImageList, DocList, AudioList, VideoList, WebList: TStringList);
var
  RegexImg, RegexDoc, RegexAudio, RegexVideo: TRegEx;
  RegexCss, RegexJs, RegexFont, RegexHtmlLink: TRegEx;
  Match: TMatch;
  RawSource, Source: string;

  procedure AddIfNew(List: TStringList; const S: string);
  begin
    if (S <> '') and (TPath.GetExtension(S) <> '') and (List.IndexOf(S) = -1)
    then
      List.Add(S);
  end;

begin
  if FSearchImages then
  begin
    RegexImg := TRegEx.Create
      ('<img\s+[^>]*src="([^"]+\.(jpg|jpeg|png|gif|bmp|webp|svg))"',
      [roIgnoreCase]);
    Match := RegexImg.Match(HTML);
    while Match.Success do
    begin
      RawSource := Match.Groups[1].Value;
      Source := RemoveURLParams(RawSource);
      Source := NormalizeURL(BaseURL, Source);
      AddIfNew(ImageList, Source);
      Match := Match.NextMatch;
    end;
  end;

  if FSearchDocuments then
  begin
    RegexDoc := TRegEx.Create
      ('<a\s+[^>]*href="([^"]+\.(pdf|zip|rtf|doc|docx|xls|xlsx|ppt|pptx))"',
      [roIgnoreCase]);
    Match := RegexDoc.Match(HTML);
    while Match.Success do
    begin
      RawSource := Match.Groups[1].Value;
      Source := RemoveURLParams(RawSource);
      Source := NormalizeURL(BaseURL, Source);
      AddIfNew(DocList, Source);
      Match := Match.NextMatch;
    end;
  end;

  if FSearchAudio then
  begin
    RegexAudio := TRegEx.Create
      ('(?:<audio\b[^>]*>.*?<source[^>]*src="([^"]+\.(mp3|wav|ogg|m4a|flac))")|href="([^"]+\.(mp3|wav|ogg|m4a|flac))"',
      [roIgnoreCase, roSingleLine]);
    Match := RegexAudio.Match(HTML);
    while Match.Success do
    begin
      if Match.Groups[1].Value <> '' then
        RawSource := Match.Groups[1].Value
      else
        RawSource := Match.Groups[3].Value;
      Source := RemoveURLParams(RawSource);
      Source := NormalizeURL(BaseURL, Source);
      AddIfNew(AudioList, Source);
      Match := Match.NextMatch;
    end;
  end;

  if FSearchVideo then
  begin
    RegexVideo := TRegEx.Create
      ('(?:<video\b[^>]*>.*?<source[^>]*src="([^"]+\.(mp4|webm|mov|ogv|mkv))")|href="([^"]+\.(mp4|webm|mov|ogv|mkv))"',
      [roIgnoreCase, roSingleLine]);
    Match := RegexVideo.Match(HTML);
    while Match.Success do
    begin
      if Match.Groups[1].Value <> '' then
        RawSource := Match.Groups[1].Value
      else
        RawSource := Match.Groups[3].Value;
      Source := RemoveURLParams(RawSource);
      Source := NormalizeURL(BaseURL, Source);
      AddIfNew(VideoList, Source);
      Match := Match.NextMatch;
    end;
  end;

  if FSearchWeb then
  begin
    RegexCss := TRegEx.Create('<link\s+[^>]*href="([^"]+\.(css))"[^>]*>',
      [roIgnoreCase]);
    Match := RegexCss.Match(HTML);
    while Match.Success do
    begin
      RawSource := Match.Groups[1].Value;
      Source := RemoveURLParams(RawSource);
      Source := NormalizeURL(BaseURL, Source);
      AddIfNew(WebList, Source);
      Match := Match.NextMatch;
    end;

    RegexJs := TRegEx.Create('<script\s+[^>]*src="([^"]+\.js)"',
      [roIgnoreCase]);
    Match := RegexJs.Match(HTML);
    while Match.Success do
    begin
      RawSource := Match.Groups[1].Value;
      Source := RemoveURLParams(RawSource);
      Source := NormalizeURL(BaseURL, Source);
      AddIfNew(WebList, Source);
      Match := Match.NextMatch;
    end;

    RegexHtmlLink := TRegEx.Create('<a\s+[^>]*href="([^"]+\.(html|htm))"',
      [roIgnoreCase]);
    Match := RegexHtmlLink.Match(HTML);
    while Match.Success do
    begin
      RawSource := Match.Groups[1].Value;
      Source := RemoveURLParams(RawSource);
      Source := NormalizeURL(BaseURL, Source);
      AddIfNew(WebList, Source);
      Match := Match.NextMatch;
    end;

    RegexFont := TRegEx.Create
      ('(?:href|src)=["'']([^"''\)]+?\.(woff2?|ttf|otf))["'']', [roIgnoreCase]);
    Match := RegexFont.Match(HTML);
    while Match.Success do
    begin
      RawSource := Match.Groups[1].Value;
      Source := RemoveURLParams(RawSource);
      Source := NormalizeURL(BaseURL, Source);
      AddIfNew(WebList, Source);
      Match := Match.NextMatch;
    end;
  end;
end;

procedure TScrapix.MarkBrokenLink(const URL: string; ListView: TscListView;
StatusBar: TscStatusBar; Logging: TscListBox);
begin
  Inc(BrokenCount);
  if Assigned(ListView) then
    SafeUpdateListViewStatus(ListView, URL, GetTranslate('Broken'));
  if Assigned(FBrokenLinks) and not FBrokenLinks.ContainsKey(URL) then
    FBrokenLinks.Add(URL, True);
  if FBrokenFilePath <> '' then
    try
      TFile.AppendAllText(FBrokenFilePath, URL + sLineBreak, TEncoding.UTF8)
    except
    end;
  if Assigned(StatusBar) then
    SafeSetStatusBarPanel(StatusBar, 3, IntToStr(BrokenCount));
  if Assigned(Logging) then
    SafeLog(Logging, Format(GetTranslate('BrokenLinkLog'), [URL]));
end;

procedure TScrapix.IncrementRobotsBlocked(StatusBar: TscStatusBar);
begin
  Inc(FRobotsBlocked);
  if Assigned(StatusBar) then
    SafeSetStatusBarPanel(StatusBar, 5, IntToStr(FRobotsBlocked));
end;

procedure TScrapix.IncrementLinksTraversed(StatusBar: TscStatusBar);
begin
  Inc(FLinksTraversed);
  if Assigned(StatusBar) then
    SafeSetStatusBarPanel(StatusBar, 7, IntToStr(FLinksTraversed));
  if (FExploreLimit > 0) and (FLinksTraversed >= FExploreLimit) then
    CancelExploration;
end;

function TScrapix.IsFileAvailable(const URL: string; ListView: TscListView;
StatusBar: TscStatusBar; Depth: Integer; Logging: TscListBox): Boolean;
var
  Client: THTTPClient;
  Resp: IHTTPResponse;
  Headers: TNetHeaders;
  RespMem: TMemoryStream;
  StatusCode: Integer;
  ContentType: string;
  NormURL: string;
  StartTick, EndTick, ElapsedMs: Cardinal;
  ContentLength: string;
  I: Integer;
begin
  Result := False;
  if URL = '' then
    Exit;
  NormURL := NormalizeURL(URL, URL);
  if NormURL = '' then
    Exit;

  if FRespectRobots and not IsAllowedByRobots(NormURL) then
  begin
    if Assigned(ListView) then
      SafeUpdateListViewStatus(ListView, NormURL,
        GetTranslate('BlockedByRobots'), 'HEAD');
    IncrementRobotsBlocked(StatusBar);
    if Assigned(Logging) then
      SafeLog(Logging, Format(GetTranslate('BlockedRobotsHEADLog'), [NormURL]));
    Exit(False);
  end;

  Client := THTTPClient.Create;
  try
    Client.ConnectionTimeout := RequestTimeoutMs;
    Client.ResponseTimeout := RequestTimeoutMs;
    Client.UserAgent := UserAgent;
    Resp := nil;
    ContentLength := '';

    StartTick := 0;

    try
      try
        StartTick := GetTickCount;
        Resp := Client.Head(NormURL);
        EndTick := GetTickCount;
      except
        Resp := nil;
        EndTick := GetTickCount;
      end;

      ElapsedMs := EndTick - StartTick;

      if Resp = nil then
      begin
        SetLength(Headers, 1);
        Headers[0].Name := 'Range';
        Headers[0].Value := 'bytes=0-0';
        RespMem := TMemoryStream.Create;
        try
          try
            StartTick := GetTickCount;
            Resp := Client.Get(NormURL, RespMem, Headers);
            EndTick := GetTickCount;
            ElapsedMs := EndTick - StartTick;
            ContentLength := GetResponseHeaderValue(Resp, 'Content-Length');
            if ContentLength = '' then
              ContentLength := GetResponseHeaderValue(Resp, 'Content-Range');
            if (ContentLength <> '') and ContentLength.StartsWith('bytes', True)
            then
            begin
              I := LastDelimiter('/', ContentLength);
              if I > 0 then
                ContentLength := Copy(ContentLength, I + 1, MaxInt);
            end;
            if ContentLength = '' then
              ContentLength := IntToStr(RespMem.Size);
          except
            Resp := nil;
            ContentLength := '';
          end;
        finally
          RespMem.Free;
        end;
        SetLength(Headers, 0);
      end
      else
      begin
        ContentLength := GetResponseHeaderValue(Resp, 'Content-Length');
      end;

      if Resp <> nil then
      begin
        StatusCode := Resp.StatusCode;
        ContentType := GetResponseHeaderValue(Resp, 'Content-Type');

        Result := (StatusCode >= 200) and (StatusCode < 300);
        if Assigned(ListView) then
        begin
          if ContentLength = '' then
            ContentLength := '0';
          SafeUpdateListViewStatus(ListView, NormURL,
            Format('%d %s', [StatusCode, ContentType]), 'HEAD');
          SafeUpdateListViewInfo(ListView, NormURL, ElapsedMs,
            FormatBytes(ContentLength), Depth);
        end;
        if Assigned(Logging) then
          SafeLog(Logging, Format('HEAD %s -> %d %s (%s)', [NormURL, StatusCode,
            ContentType, FormatBytes(ContentLength)]));
      end
      else
      begin
        if Assigned(ListView) then
          SafeUpdateListViewStatus(ListView, NormURL,
            GetTranslate('NoResponse'), 'HEAD');
        if Assigned(Logging) then
          SafeLog(Logging, Format(GetTranslate('NoResponseHEADLog'),
            [NormURL]));
        Result := False;
      end;
    except
      on E: Exception do
      begin
        if Assigned(ListView) then
        begin
          SafeUpdateListViewStatus(ListView, NormURL,
            'Exception : ' + E.Message, '');
          SafeUpdateListViewInfo(ListView, NormURL, -1, '', Depth);
        end;
        if Assigned(Logging) then
          SafeLog(Logging, Format('HEAD Exception %s : %s',
            [NormURL, E.Message]));
        Result := False;
      end;
    end;
  finally
    Client.Free;
  end;
end;

function TScrapix.DownloadFile(const URL: string; Client: THTTPClient;
out LocalPath: string; Logging: TscListBox): Boolean;
var
  FileName, Ext, UriPath, CandidateFolder, CandidateFile, BaseName: string;
  FS: TFileStream;
  Resp: IHTTPResponse;
  NormURL: string;
  Suffix: Integer;

  function DetermineSubFolderByExtension(const AExt: string): string;
  begin
    if AExt = '' then
      Exit('Autre');
    if SameText(AExt, '.jpg') or SameText(AExt, '.jpeg') or
      SameText(AExt, '.png') or SameText(AExt, '.gif') or SameText(AExt, '.bmp')
      or SameText(AExt, '.webp') or SameText(AExt, '.svg') then
      Exit('Image');
    if SameText(AExt, '.pdf') or SameText(AExt, '.zip') or
      SameText(AExt, '.rtf') or SameText(AExt, '.doc') or
      SameText(AExt, '.docx') or SameText(AExt, '.xls') or
      SameText(AExt, '.xlsx') or SameText(AExt, '.ppt') or
      SameText(AExt, '.pptx') or SameText(AExt, '.txt') then
      Exit('Document');
    if SameText(AExt, '.mp3') or SameText(AExt, '.wav') or
      SameText(AExt, '.ogg') or SameText(AExt, '.m4a') or SameText(AExt, '.flac')
    then
      Exit('Audio');
    if SameText(AExt, '.mp4') or SameText(AExt, '.webm') or
      SameText(AExt, '.mov') or SameText(AExt, '.ogv') or SameText(AExt, '.mkv')
    then
      Exit('Vidéo');
    if SameText(AExt, '.css') then
      Exit(TPath.Combine('Ressources Web', 'CSS'));
    if SameText(AExt, '.js') then
      Exit(TPath.Combine('Ressources Web', 'JS'));
    if SameText(AExt, '.html') or SameText(AExt, '.htm') then
      Exit(TPath.Combine('Ressources Web', 'HTML'));
    if SameText(AExt, '.woff') or SameText(AExt, '.woff2') or
      SameText(AExt, '.ttf') or SameText(AExt, '.otf') then
      Exit(TPath.Combine('Ressources Web', 'Fonts'));
    Result := 'Autre';
  end;

begin
  Result := False;
  LocalPath := '';
  if (URL = '') or (Client = nil) then
    Exit;
  NormURL := NormalizeURL(URL, URL);
  if NormURL = '' then
    Exit;

  if FRespectRobots and not IsAllowedByRobots(NormURL) then
  begin
    if Assigned(Logging) then
      SafeLog(Logging, Format(GetTranslate('BlockedRobotsDownLog'), [NormURL]));
    Exit(False);
  end;

  try
    try
      try
        UriPath := TURI.Create(NormURL).Path
      except
        UriPath := '';
      end;
      FileName := TPath.GetFileName(UriPath);
      if FileName = '' then
        FileName := 'file';
      BaseName := TPath.GetFileNameWithoutExtension(FileName);
      Ext := TPath.GetExtension(FileName);
      if Ext = '' then
        Ext := '';

      CandidateFolder := TPath.Combine(DownloadFolder,
        DetermineSubFolderByExtension(Ext));
      if not TDirectory.Exists(CandidateFolder) then
        try
          TDirectory.CreateDirectory(CandidateFolder)
        except
          Exit(False)
        end;

      CandidateFile := TPath.Combine(CandidateFolder, BaseName + Ext);
      Suffix := 0;
      while TFile.Exists(CandidateFile) do
      begin
        Inc(Suffix);
        CandidateFile := TPath.Combine(CandidateFolder,
          BaseName + '_' + IntToStr(Suffix) + Ext);
        if Suffix > 10000 then
          Break;
      end;

      LocalPath := CandidateFile;
      FS := TFileStream.Create(LocalPath, fmCreate);
      try
        Resp := Client.Get(NormURL, FS);
        if Resp <> nil then
          Result := (Resp.StatusCode >= 200) and (Resp.StatusCode < 300)
        else
          Result := False;
      finally
        FS.Free;
        if not Result then
        begin
          try
            if TFile.Exists(LocalPath) then
              TFile.Delete(LocalPath)
          except
          end;
          LocalPath := '';
        end;
      end;
      if Result then
      begin
        if Assigned(Logging) then
          SafeLog(Logging, Format(GetTranslate('DonwLog'),
            [NormURL, LocalPath]));
      end
      else
      begin
        if Assigned(Logging) then
          SafeLog(Logging, Format(GetTranslate('DonwFailedLog'), [NormURL]));
      end;
    except
      on E: Exception do
      begin
        Result := False;
        LocalPath := '';
        if Assigned(Logging) then
          SafeLog(Logging, Format(GetTranslate('ExceptDonwLog'),
            [URL, E.Message]));
      end;
    end;
  finally
  end;
end;

procedure TScrapix.ProcessResourceGroup(ResourceList: TStringList;
const AcceptExts: array of string; StatusBar: TscStatusBar;
ListView: TscListView; Depth: Integer; const DefaultUIType: string;
Logging: TscListBox);
var
  I: Integer;
  URL: string;
  Available: Boolean;
  DLClient: THTTPClient;
  LocalPath: string;
  AddedCount: Integer;
  AcceptAny: Boolean;

  function IsExtAccepted(const AURL: string): Boolean;
  var
    E: string;
    AExt: string;
  begin
    if Length(AcceptExts) = 0 then
    begin
      Result := True;
      Exit;
    end;
    AExt := LowerCase(TPath.GetExtension(AURL));
    for E in AcceptExts do
      if AExt = LowerCase(E) then
        Exit(True);
    Result := False;
  end;

begin
  if (ResourceList = nil) or (ResourceList.Count = 0) then
    Exit;
  AddedCount := 0;
  AcceptAny := Length(AcceptExts) = 0;

  for I := 0 to ResourceList.Count - 1 do
  begin
    if IsCanceled then
      Exit;
    while IsPaused do
    begin
      if IsCanceled then
        Exit;
      if Assigned(FPauseEvent) then
        FPauseEvent.WaitFor(250);
    end;

    URL := ResourceList[I];

    if (not AcceptAny) and (not IsExtAccepted(URL)) then
      Continue;
    if (FFoundFiles <> nil) and FFoundFiles.ContainsKey(URL) then
      Continue;

    if FRespectRobots and not IsAllowedByRobots(URL) then
    begin
      SafeUpdateListViewStatus(ListView, URL, GetTranslate('BlockedByRobots'));
      SafeUpdateListViewDownloadState(ListView, URL, GetTranslate('Ignored'));
      IncrementRobotsBlocked(StatusBar);
      if Assigned(Logging) then
        SafeLog(Logging, Format(GetTranslate('BlockedRobotsResLog'), [URL]));
      Continue;
    end;

    Available := IsFileAvailable(URL, ListView, StatusBar, Depth, Logging);
    if Available then
    begin
      if FAutoDownload then
      begin
        DLClient := THTTPClient.Create;
        try
          DLClient.ConnectionTimeout := RequestTimeoutMs;
          DLClient.ResponseTimeout := RequestTimeoutMs;
          DLClient.UserAgent := UserAgent;

          SafeUpdateListViewDownloadState(ListView, URL,
            GetTranslate('Downloading'));
          if DownloadFile(URL, DLClient, LocalPath, Logging) then
          begin
            SafeUpdateListViewDownloadState(ListView, URL,
              GetTranslate('Downloaded'));
            Inc(AddedCount);
            if FFoundFiles <> nil then
            begin
              FFoundFiles.Add(URL, True);
              if FFoundFilePath <> '' then
                try
                  TFile.AppendAllText(FFoundFilePath, URL + sLineBreak,
                    TEncoding.UTF8)
                except
                end;
            end;
          end
          else
          begin
            SafeUpdateListViewDownloadState(ListView, URL,
              GetTranslate('DownloadFailed'));
            SafeUpdateListViewStatus(ListView, URL,
              GetTranslate('DownloadFailed'));
          end;
        finally
          DLClient.Free;
        end;
      end
      else
      begin
        Inc(AddedCount);
        SafeUpdateListViewDownloadState(ListView, URL,
          GetTranslate('NotDownloaded'));
        if FFoundFiles <> nil then
        begin
          FFoundFiles.Add(URL, True);
          if FFoundFilePath <> '' then
            try
              TFile.AppendAllText(FFoundFilePath, URL + sLineBreak,
                TEncoding.UTF8)
            except
            end;
        end;
        if Assigned(Logging) then
          SafeLog(Logging, Format(GetTranslate('FoundNotDownLog'), [URL]));
      end;
    end
    else
    begin
      if not FAutoDownload then
      begin
        MarkBrokenLink(URL, ListView, StatusBar, Logging);
        SafeUpdateListViewDownloadState(ListView, URL, GetTranslate('Broken'));
      end
      else
      begin
        SafeUpdateListViewStatus(ListView, URL, GetTranslate('Broken_Ignored'));
        SafeUpdateListViewDownloadState(ListView, URL,
          GetTranslate('Broken_Ignored'));
        if Assigned(FBrokenLinks) and not FBrokenLinks.ContainsKey(URL) then
          FBrokenLinks.Add(URL, True);
        if Assigned(Logging) then
          SafeLog(Logging, Format(GetTranslate('CorruptedDownLog'), [URL]));
      end;
    end;

    if (FFoundFilesLimit > 0) and (FileCount + AddedCount >= FFoundFilesLimit)
    then
    begin
      CancelExploration;
      Break;
    end;
  end;

  if AddedCount > 0 then
    Inc(FileCount, AddedCount);
  if Assigned(StatusBar) then
    SafeSetStatusBarPanel(StatusBar, 1, IntToStr(FileCount));
  if (FFoundFilesLimit > 0) and (FileCount >= FFoundFilesLimit) then
    CancelExploration;
end;

procedure TScrapix.ProcessFoundFiles(ImageList, DocList, AudioList, VideoList,
  WebList: TStringList; StatusBar: TscStatusBar; ListView: TscListView;
CheckList: TscCheckListBox; Depth: Integer; Logging: TscListBox);
begin
  if FSearchImages then
    ProcessResourceGroup(ImageList, ['.jpg', '.jpeg', '.png', '.gif', '.bmp',
      '.webp', '.svg'], StatusBar, ListView, Depth, 'Image', Logging);

  if FSearchDocuments then
    ProcessResourceGroup(DocList, ['.pdf', '.zip', '.rtf', '.doc', '.docx',
      '.xls', '.xlsx', '.ppt', '.pptx', '.txt'], StatusBar, ListView, Depth,
      'Document', Logging);

  if FSearchVideo then
    ProcessResourceGroup(VideoList, ['.mp4', '.webm', '.mov', '.ogv', '.mkv'],
      StatusBar, ListView, Depth, 'Vidéo', Logging);

  if FSearchAudio then
    ProcessResourceGroup(AudioList, ['.mp3', '.wav', '.ogg', '.m4a', '.flac'],
      StatusBar, ListView, Depth, 'Audio', Logging);

  if FSearchWeb then
    ProcessResourceGroup(WebList, ['.css', '.js', '.html', '.htm', '.woff',
      '.woff2', '.ttf', '.otf'], StatusBar, ListView, Depth,
      'RessourceWeb', Logging);
end;

function TScrapix.IsSameDomain(const BaseURL, LinkURL: string): Boolean;
var
  HostBase, HostLink: string;
  TempBase: string;

  function HostIsSuffixOf(const SuffixHost, FullHost: string): Boolean;
  begin
    Result := (SuffixHost = FullHost) or FullHost.EndsWith('.' + SuffixHost);
  end;

begin
  Result := False;
  if LinkURL = '' then
    Exit;
  TempBase := Trim(BaseURL);
  if TempBase = '' then
    Exit;

  if Pos('://', TempBase) = 0 then
    HostBase := LowerCase(TempBase)
  else
    try
      HostBase := LowerCase(TURI.Create(TempBase).Host)
    except
      HostBase := ''
    end;
  if HostBase = '' then
    Exit;

  try
    HostLink := LowerCase(TURI.Create(LinkURL).Host)
  except
    HostLink := ''
  end;
  if HostLink = '' then
    Exit;

  Result := HostIsSuffixOf(HostBase, HostLink);
end;

procedure TScrapix.ExploreLinksRecursive(const URL: string;
ListView: TscListView; StatusBar: TscStatusBar; CheckList: TscCheckListBox;
Depth: Integer; Logging: TscListBox);
var
  HTMLContent: string;
  Links, Images, Docs, Audio, Video, Webs: TStringList;
  I: Integer;
  Item: TListItem;
  NormURL: string;
  NeedExtract: Boolean;
  CurrentDepth: Integer;
begin
  if IsCanceled then
    Exit;
  if Depth <= 0 then
    Exit;

  if FMaxDepth <= 0 then
    CurrentDepth := Depth
  else
    CurrentDepth := FMaxDepth - Depth + 1;

  NormURL := NormalizeURL(URL, URL);
  if NormURL = '' then
    Exit;
  if (VisitedLinks <> nil) and VisitedLinks.ContainsKey(NormURL) then
    Exit;

  if FRespectRobots and not IsAllowedByRobots(NormURL) then
  begin
    if Assigned(ListView) then
    begin
      SafeUpdateListViewStatus(ListView, NormURL,
        GetTranslate('BlockedByRobots'));
      SafeUpdateListViewDownloadState(ListView, NormURL,
        GetTranslate('Ignored'));
    end;
    IncrementRobotsBlocked(StatusBar);
    if Assigned(Logging) then
      SafeLog(Logging, Format(GetTranslate('BlockedRobotsLog'), [NormURL]));
    Exit;
  end;

  while IsPaused do
  begin
    if IsCanceled then
      Exit;
    if Assigned(FPauseEvent) then
      FPauseEvent.WaitFor(250);
  end;

  VisitedLinks.Add(NormURL, True);
  Inc(TotalLinks);
  IncrementLinksTraversed(StatusBar);

  if Assigned(Logging) then
    SafeLog(Logging, Format(GetTranslate('VisitedLog'),
      [NormURL, CurrentDepth]));

  if IsCanceled then
    Exit;
  if (FFoundFilesLimit > 0) and (FileCount >= FFoundFilesLimit) then
  begin
    CancelExploration;
    Exit;
  end;
  if (FExploreLimit > 0) and (FLinksTraversed >= FExploreLimit) then
  begin
    CancelExploration;
    Exit;
  end;

  if FVisitedFilePath <> '' then
    try
      TFile.AppendAllText(FVisitedFilePath, NormURL + sLineBreak,
        TEncoding.UTF8)
    except
    end;

  if Assigned(ListView) and UIUpdatesAllowed then
  begin
    if TThread.Current.ThreadID = MainThreadID then
    begin
      Item := ListView.Items.Add;
      Item.Caption := NormURL;
      while Item.SubItems.Count < 6 do
        Item.SubItems.Add('');
      Item.SubItems[0] := GetTranslate('OnHold');
      Item.SubItems[4] := IntToStr(CurrentDepth);
      SafeScrollListViewToBottom(ListView);
    end
    else
    begin
      var
      LV := ListView;
      var
      sURL := NormURL;
      var
      sDepth := IntToStr(CurrentDepth);
      TThread.Queue(nil,
        procedure
        begin
          if not UIUpdatesAllowed then
            Exit;
          if (LV = nil) or (csDestroying in LV.ComponentState) or
            (not LV.HandleAllocated) then
            Exit;
          Item := LV.Items.Add;
          while Item.SubItems.Count < 6 do
            Item.SubItems.Add('');
          Item.Caption := sURL;
          Item.SubItems[0] := GetTranslate('OnHold');
          Item.SubItems[4] := sDepth;
          SafeScrollListViewToBottom(LV);
        end);
    end;
  end;

  HTMLContent := GetWebContent(NormURL, ListView, CurrentDepth, Logging);

  if HTMLContent = '' then
  begin
    if not FAutoDownload then
    begin
      if Assigned(Logging) then
        SafeLog(Logging, Format(GetTranslate('MarkBrokenLinkLog'), [NormURL]));
      MarkBrokenLink(NormURL, ListView, StatusBar, Logging)
    end
    else
    begin
      SafeUpdateListViewStatus(ListView, NormURL,
        GetTranslate('Broken_Ignored'));
      if Assigned(Logging) then
        SafeLog(Logging, Format(GetTranslate('NoContentLog'), [NormURL]));
    end;
    Exit;
  end;

  Links := TStringList.Create;
  Images := TStringList.Create;
  Docs := TStringList.Create;
  Audio := TStringList.Create;
  Video := TStringList.Create;
  Webs := TStringList.Create;
  try
    ExtractLinks(HTMLContent, NormURL, Links);

    NeedExtract := FSearchImages or FSearchDocuments or FSearchAudio or
      FSearchVideo or FSearchWeb;
    if NeedExtract then
      ExtractMediaSources(HTMLContent, NormURL, Images, Docs, Audio,
        Video, Webs);

    ProcessFoundFiles(Images, Docs, Audio, Video, Webs, StatusBar, ListView,
      CheckList, CurrentDepth, Logging);

    if IsCanceled then
      Exit;
    if (FFoundFilesLimit > 0) and (FileCount >= FFoundFilesLimit) then
      Exit;
    if (FExploreLimit > 0) and (FLinksTraversed >= FExploreLimit) then
      Exit;

    for I := 0 to Links.Count - 1 do
    begin
      if IsCanceled then
        Exit;
      while IsPaused do
      begin
        if IsCanceled then
          Exit;
        if Assigned(FPauseEvent) then
          FPauseEvent.WaitFor(250);
      end;

      if SameDomainOnly then
      begin
        if not IsSameDomain(RootDomain, Links[I]) then
          Continue;
      end;

      ExploreLinksRecursive(Links[I], ListView, StatusBar, CheckList,
        Depth - 1, Logging);
    end;

    if Assigned(StatusBar) then
    begin
      SafeSetStatusBarPanel(StatusBar, 1, IntToStr(FileCount));
      SafeSetStatusBarPanel(StatusBar, 3, IntToStr(BrokenCount));
      SafeSetStatusBarPanel(StatusBar, 5, IntToStr(FRobotsBlocked));
      SafeSetStatusBarPanel(StatusBar, 7, IntToStr(FLinksTraversed));
    end;
  finally
    Links.Free;
    Images.Free;
    Docs.Free;
    Audio.Free;
    Video.Free;
    Webs.Free;
  end;
end;

procedure TScrapix.ExploreLinks(const URL: string; ListView: TscListView;
StatusBar: TscStatusBar; CheckList: TscCheckListBox; MaxDepth: Integer;
SaveBrokenToFile, SaveVisitedToFile, SaveFoundFilesToFile: Boolean;
Logging: TscListBox);
var
  UriStart: TURI;
  RootFolder, StartUrlFolder, ReportFolder, StartFolderName: string;
  DocFolder, FileName, FilePath, LogFolder: string;
  SL: TStringList;
  Key: string;
begin
  if Assigned(FStoppedEvent) then
    FStoppedEvent.ResetEvent;
  FRunning := True;
  try
    FreeAndNil(VisitedLinks);
    VisitedLinks := TDictionary<string, Boolean>.Create;
    if Assigned(FFoundFiles) then
      FFoundFiles.Clear;
    if Assigned(FBrokenLinks) then
      FBrokenLinks.Clear;
    TotalLinks := 0;
    FileCount := 0;
    BrokenCount := 0;
    FRobotsBlocked := 0;
    FLinksTraversed := 0;

    FVisitedFilePath := '';
    FBrokenFilePath := '';
    FFoundFilePath := '';

    TInterlocked.Exchange(FState, STATE_RUNNING);
    if Assigned(FPauseEvent) then
      FPauseEvent.SetEvent;

    if RequestTimeoutMs <= 0 then
      RequestTimeoutMs := 30000;
    if RequestDelayMs < 0 then
      RequestDelayMs := 0;

    if Assigned(Logging) then
      SafeLog(Logging, Format(GetTranslate('StartingLog'), [URL, MaxDepth]));

    try
      try
        UriStart := TURI.Create(URL);
        RootDomain := UriStart.Host
      except
        RootDomain := ''
      end;

      RootFolder := TPath.Combine(TPath.GetDocumentsPath, 'Scrapix');
      StartFolderName := RootDomain;
      StartUrlFolder := TPath.Combine(RootFolder, StartFolderName);
      ReportFolder := TPath.Combine(StartUrlFolder, 'Report');

      try
        if not TDirectory.Exists(RootFolder) then
          TDirectory.CreateDirectory(RootFolder);
        if not TDirectory.Exists(StartUrlFolder) then
          TDirectory.CreateDirectory(StartUrlFolder);
        if not TDirectory.Exists(ReportFolder) then
          TDirectory.CreateDirectory(ReportFolder);
      except
      end;

      try
        LogFolder := TPath.Combine(ReportFolder, 'Logging');
        if not TDirectory.Exists(LogFolder) then
          TDirectory.CreateDirectory(LogFolder);
        FLogFilePath := TPath.Combine(LogFolder, 'Logging.txt');

        try
          TFile.WriteAllText(FLogFilePath, '', TEncoding.UTF8);
        except
          FLogFilePath := '';
        end;
      except
        FLogFilePath := '';
      end;

      DownloadFolder := TPath.Combine(StartUrlFolder, 'download');
      try
        if not TDirectory.Exists(DownloadFolder) then
          TDirectory.CreateDirectory(DownloadFolder);
        if not TDirectory.Exists(TPath.Combine(DownloadFolder, 'Image')) then
          TDirectory.CreateDirectory(TPath.Combine(DownloadFolder, 'Image'));
        if not TDirectory.Exists(TPath.Combine(DownloadFolder, 'Document')) then
          TDirectory.CreateDirectory(TPath.Combine(DownloadFolder, 'Document'));
        if not TDirectory.Exists(TPath.Combine(DownloadFolder, 'Audio')) then
          TDirectory.CreateDirectory(TPath.Combine(DownloadFolder, 'Audio'));
        if not TDirectory.Exists(TPath.Combine(DownloadFolder, 'Vidéo')) then
          TDirectory.CreateDirectory(TPath.Combine(DownloadFolder, 'Vidéo'));
        if not TDirectory.Exists(TPath.Combine(DownloadFolder, 'Web Document'))
        then
          TDirectory.CreateDirectory(TPath.Combine(DownloadFolder,
            'Web Document'));
      except
      end;

      if SaveBrokenToFile then
      begin
        FileName := 'BrokenLinks.txt';
        FBrokenFilePath := TPath.Combine(ReportFolder, FileName);
        try
          TFile.WriteAllText(FBrokenFilePath, '', TEncoding.UTF8)
        except
          FBrokenFilePath := ''
        end;
      end;

      if SaveVisitedToFile then
      begin
        FileName := 'VisitedLinks.txt';
        FVisitedFilePath := TPath.Combine(ReportFolder, FileName);
        try
          TFile.WriteAllText(FVisitedFilePath, '', TEncoding.UTF8)
        except
          FVisitedFilePath := ''
        end;
      end;

      if SaveFoundFilesToFile then
      begin
        FileName := 'FoundFiles.txt';
        FFoundFilePath := TPath.Combine(ReportFolder, FileName);
        try
          TFile.WriteAllText(FFoundFilePath, '', TEncoding.UTF8)
        except
          FFoundFilePath := ''
        end;
      end;

      FMaxDepth := MaxDepth;
      if Assigned(Logging) then
        SafeLog(Logging, GetTranslate('LaunchingLog'));
      ExploreLinksRecursive(URL, ListView, StatusBar, CheckList,
        MaxDepth, Logging);
    finally
      FreeAndNil(VisitedLinks);
    end;

    if SaveBrokenToFile and Assigned(FBrokenLinks) and (FBrokenLinks.Count > 0)
    then
    begin
      DocFolder := TPath.GetDocumentsPath;
      FileName := 'BrokenLinks.txt';
      FilePath := TPath.Combine(DocFolder, FileName);
      SL := TStringList.Create;
      try
        for Key in FBrokenLinks.Keys do
          SL.Add(Key);
        try
          SL.SaveToFile(FilePath, TEncoding.UTF8)
        except
        end;
      finally
        SL.Free;
      end;
    end;

    if SaveVisitedToFile and Assigned(VisitedLinks) and (VisitedLinks.Count > 0)
    then
    begin
      DocFolder := TPath.GetDocumentsPath;
      if FVisitedFilePath <> '' then
        FilePath := FVisitedFilePath
      else
        FilePath := TPath.Combine(DocFolder, 'VisitedLinks.txt');
      SL := TStringList.Create;
      try
        for Key in VisitedLinks.Keys do
          SL.Add(Key);
        try
          SL.SaveToFile(FilePath, TEncoding.UTF8)
        except
        end;
      finally
        SL.Free;
      end;
    end;

    if SaveFoundFilesToFile and Assigned(FFoundFiles) and (FFoundFiles.Count > 0)
    then
    begin
      DocFolder := TPath.GetDocumentsPath;
      if FFoundFilePath <> '' then
        FilePath := FFoundFilePath
      else
        FilePath := TPath.Combine(DocFolder, 'FoundFiles.txt');
      SL := TStringList.Create;
      try
        for Key in FFoundFiles.Keys do
          SL.Add(Key);
        try
          SL.SaveToFile(FilePath, TEncoding.UTF8)
        except
        end;
      finally
        SL.Free;
      end;
    end;
  finally
    if Assigned(Logging) then
      SafeLog(Logging, Format(GetTranslate('FinishedLog'),
        [FileCount, BrokenCount, TotalLinks]));
    FVisitedFilePath := '';
    FBrokenFilePath := '';
    FFoundFilePath := '';
    FRunning := False;
    if Assigned(FStoppedEvent) then
      FStoppedEvent.SetEvent;
  end;
end;

procedure TScrapix.ApplyFileTypeFiltersFromCheckList
  (CheckList: TscCheckListBox);
var
  Idx: Integer;
  Txt: string;
begin
  FSearchImages := False;
  FSearchDocuments := False;
  FSearchAudio := False;
  FSearchVideo := False;
  FSearchWeb := False;
  if CheckList = nil then
    Exit;

  for Idx := 0 to CheckList.Count - 1 do
  begin
    if not CheckList.Checked[Idx] then
      Continue;
    Txt := Trim(CheckList.Items[Idx]);
    if StartsText('Image', Txt) then
      FSearchImages := True
    else if StartsText('Document', Txt) then
      FSearchDocuments := True
    else if StartsText('Audio', Txt) then
      FSearchAudio := True
    else if StartsText('Vidéo', Txt) or StartsText('Video', Txt) then
      FSearchVideo := True
    else if StartsText('Web Document', Txt) then
      FSearchWeb := True
    else
      case Idx of
        0:
          FSearchImages := True;
        1:
          FSearchDocuments := True;
        2:
          FSearchAudio := True;
        3:
          FSearchVideo := True;
        4:
          FSearchWeb := True;
      end;
  end;
end;

end.
