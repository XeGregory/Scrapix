unit UScrapix;

interface

uses
  {Winapi}
  Winapi.Windows, Winapi.Messages, Winapi.ShellAPI,
  {System}
  System.SysUtils, System.Variants, System.Classes, System.IOUtils,
  System.Net.URLClient, System.UITypes, System.StrUtils, System.ImageList,
  System.SyncObjs,
  {Vcl}
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Mask, Vcl.CheckLst, Vcl.Themes, Vcl.ImgList,
  Vcl.VirtualImageList, Vcl.BaseImageCollection, Vcl.ImageCollection,
  {StyleControls VCL}
  scStyleManager, scControls, scModernControls, scDialogs, scExtControls,
  {Scrapix.Core}
  Scrapix.Core,
  {Translate.Core}
  Translate.Core;

type
  TFScrapix = class(TForm)
    scStyleManager: TscStyleManager;
    Collection: TImageCollection;
    ImageList: TVirtualImageList;
    BoxMain: TscPanel;
    BtnOpenDir: TscButton;
    EdUrl: TscEdit;
    BtnStart: TscButton;
    BtnBreak: TscButton;
    BtnStop: TscButton;
    BtnSettings: TscButton;
    BtnResetUI: TscButton;
    BtnAbout: TscButton;
    BtnTranslate: TscButton;
    BoxScrap: TscPanel;
    ListView: TscListView;
    SplitView: TscSplitView;
    ScrollBox: TscScrollBox;
    LabDepth: TscLabel;
    SeDepth: TscSpinEdit;
    CkSameDomain: TscCheckBox;
    CkRobot: TscCheckBox;
    LabTimeout: TscLabel;
    SeTimeout: TscSpinEdit;
    LabDelay: TscLabel;
    SeDelay: TscSpinEdit;
    LabExploreLimit: TscLabel;
    SeExploreLimit: TscSpinEdit;
    LabFoundFilesLimit: TscLabel;
    SeFoundFilesLimit: TscSpinEdit;
    LabListFileTypes: TLabel;
    CkListFileTypes: TscCheckListBox;
    CkAutoDownload: TscCheckBox;
    LabReport: TscLabel;
    CkSaveBrokenLinks: TscCheckBox;
    CkSaveBrokenToFile: TscCheckBox;
    CkSaveFoundFilesToFile: TscCheckBox;
    ExPanelLog: TscExPanel;
    Logging: TscListBox;
    StatusBar: TscStatusBar;

    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure BtnOpenDirClick(Sender: TObject);
    procedure BtnStartClick(Sender: TObject);
    procedure BtnBreakClick(Sender: TObject);
    procedure BtnStopClick(Sender: TObject);
    procedure BtnSettingsClick(Sender: TObject);
    procedure BtnResetUIClick(Sender: TObject);
    procedure BtnAboutClick(Sender: TObject);
    procedure BtnTranslateClick(Sender: TObject);
    procedure ListViewDblClick(Sender: TObject);

  private
    Scrapix: TScrapix;

    { Met à jour l'état du bouton Pause/Resume selon l'état du crawler. }
    procedure UpdateBtnBreak;
    { Active / désactive les contrôles de l'UI selon le bool Running (thread-safe). }
    procedure UpdateUI(Running: Boolean);
    { Met à jour les libellés traduits dans l'UI. }
    procedure UpdateTranslateUI;
    { Vérifie rapidement que la chaîne donnée est une URL HTTP/HTTPS valide. }
    function IsUrl(const AUrl: string): Boolean;
    { Réinitialise les panneaux de la statusbar (thread-safe). }
    procedure ResetStatusPanels;
    { Routine interne pour restaurer l'UI (appelée toujours sur le thread principal). }
    procedure RestoreUIAfterRun;
  end;

var
  FScrapix: TFScrapix;

implementation

{$R *.dfm}

{ UpdateBtnBreak: adapte le libellé du bouton Pause/Resume selon l'état Scrapix. }
procedure TFScrapix.UpdateBtnBreak;
begin
  if not Assigned(Scrapix) then
  begin
    BtnBreak.Caption := GetTranslate('BtnBreak_Pause');
    Exit;
  end;

  if Scrapix.IsPaused then
    BtnBreak.Caption := GetTranslate('BtnBreak_Resume')
  else
    BtnBreak.Caption := GetTranslate('BtnBreak_Pause');
end;

{ UpdateUI: active ou désactive les contrôles pertinents; exécute via Queue si appelé hors du MainThread. }
procedure TFScrapix.UpdateUI(Running: Boolean);
begin
  if TThread.Current.ThreadID <> MainThreadID then
  begin
    TThread.Queue(nil,
      procedure
      begin
        UpdateUI(Running);
      end);
    Exit;
  end;

  BtnStart.Enabled := not Running;
  BtnStop.Enabled := Running;
  BtnBreak.Enabled := Running;
  BtnSettings.Enabled := not Running;
  BtnResetUI.Enabled := not Running;
  BtnAbout.Enabled := not Running;
  BtnTranslate.Enabled := not Running;
end;

{ UpdateTranslateUI: applique les traductions aux contrôles visibles. }
procedure TFScrapix.UpdateTranslateUI;
var
  I: Integer;
begin
  BtnStart.Caption := GetTranslate('BtnStart');
  BtnStop.Caption := GetTranslate('BtnStop');
  BtnBreak.Caption := GetTranslate('BtnBreak_Pause');

  for I := 0 to ListView.Columns.Count - 1 do
    ListView.Columns[I].Caption := GetTranslate('Col' + IntToStr(I));

  LabDepth.Caption := GetTranslate('LabDepth');
  CkSameDomain.Caption := GetTranslate('CkSameDomain');
  CkRobot.Caption := GetTranslate('CkRobot');
  LabTimeout.Caption := GetTranslate('LabTimeout');
  LabDelay.Caption := GetTranslate('LabDelay');
  LabExploreLimit.Caption := GetTranslate('LabExploreLimit');
  LabFoundFilesLimit.Caption := GetTranslate('LabFoundFilesLimit');
  LabListFileTypes.Caption := GetTranslate('LabListFileTypes');
  CkAutoDownload.Caption := GetTranslate('CkAutoDownload');
  LabReport.Caption := GetTranslate('LabReport');
  CkSaveBrokenLinks.Caption := GetTranslate('CkSaveBrokenLinks');
  CkSaveBrokenToFile.Caption := GetTranslate('CkSaveBrokenToFile');
  CkSaveFoundFilesToFile.Caption := GetTranslate('CkSaveFoundFilesToFile');

  ExPanelLog.Caption := GetTranslate('ExPanelLog');

  StatusBar.Panels[0].Text := GetTranslate('Panel0');
  StatusBar.Panels[2].Text := GetTranslate('Panel2');
  StatusBar.Panels[4].Text := GetTranslate('Panel4');
  StatusBar.Panels[6].Text := GetTranslate('Panel6');
end;

{ IsUrl: vérifie qu'une chaîne est une URL http(s) valide (sans lever d'exception). }
function TFScrapix.IsUrl(const AUrl: string): Boolean;
var
  U: TURI;
begin
  Result := False;
  if AUrl.IsEmpty then
    Exit;
  try
    U := TURI.Create(AUrl);
    Result := ((U.Scheme = 'http') or (U.Scheme = 'https')) and (U.Host <> '');
  except
    Result := False;
  end;
end;

{ FormCreate: initialise valeurs par défaut et UI. }
procedure TFScrapix.FormCreate(Sender: TObject);
begin
  SetLanguage(lgFrench);
  Scrapix := TScrapix.Create;

  SeDepth.MinValue := 1;
  SeDepth.MaxValue := 20;
  SeDepth.Value := 2;

  SeTimeout.MinValue := 1000;
  SeTimeout.MaxValue := 30000;
  SeTimeout.Value := 10000;

  SeDelay.MinValue := 1;
  SeDelay.MaxValue := 60000;
  SeDelay.Value := 100;

  SeExploreLimit.MinValue := 1;
  SeExploreLimit.MaxValue := 100;
  SeExploreLimit.Value := 20;

  SeFoundFilesLimit.MinValue := 1;
  SeFoundFilesLimit.MaxValue := 2000;
  SeFoundFilesLimit.Value := 500;

  CkSameDomain.Checked := False;

  with ListView do
  begin
    Columns.BeginUpdate;
    try
      Columns.Clear;
      with Columns.Add do
        Width := 600;
      with Columns.Add do
        Width := 200;
      with Columns.Add do
        Width := 200;
      with Columns.Add do
        Width := 200;
      with Columns.Add do
        Width := 120;
      with Columns.Add do
        Width := 120;
      with Columns.Add do
        Width := 200;
    finally
      Columns.EndUpdate;
    end;
    ViewStyle := vsReport;
  end;

  CkRobot.Checked := True;

  BtnBreak.Enabled := False;
  BtnStop.Enabled := False;

  with CkListFileTypes do
  begin
    Items.Clear;
    Items.Add('Image');
    Items.Add('Document');
    Items.Add('Audio');
    Items.Add('Vidéo');
    Items.Add('Web Document');

    Checked[0] := True;
    Checked[1] := True;
    Checked[2] := True;
    Checked[3] := True;
    Checked[4] := False;
  end;

  SplitView.Close;
  UpdateUI(False);
  UpdateTranslateUI;

  ExPanelLog.RollUpState := True;

{$IFDEF DEBUG}
  EdUrl.Text := 'https://github.com/';
  SeDepth.Value := 2;
  SeTimeout.Value := 10000;
  SeDelay.Value := 100;
{$ENDIF}
end;

{ FormClose: ordonne l'arrêt du crawler et empêche fuite d'objet. }
procedure TFScrapix.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Assigned(Scrapix) then
  begin
    Scrapix.DisableUIUpdates := True;
    Scrapix.CancelExploration;
    Scrapix.WaitForStop;
    Action := caFree;
  end;
end;

{ FormCloseQuery: empêche la fermeture tant que le crawler est en cours. }
procedure TFScrapix.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if Assigned(Scrapix) and Scrapix.IsRunning then
  begin
    Scrapix.DisableUIUpdates := True;
    Scrapix.CancelExploration;

    if not Scrapix.WaitForStop then
    begin
      CanClose := False;
      Exit;
    end;
  end;
  CanClose := True;
end;

{ FormDestroy: libère l'objet Scrapix de manière sûre. }
procedure TFScrapix.FormDestroy(Sender: TObject);
begin
  if Assigned(Scrapix) then
  begin
    try
      Scrapix.DisableUIUpdates := True;
      Scrapix.CancelExploration;
      Scrapix.WaitForStop;
      FreeAndNil(Scrapix);
    except
      on E: Exception do
        scShowMessage(E.Message);
    end;
  end;
end;

{ BtnOpenDirClick: ouvre le dossier de rapport / téléchargement lié à l'URL saisie. }
procedure TFScrapix.BtnOpenDirClick(Sender: TObject);
var
  Dir, DirDom: String;
  U: TURI;
begin
  DirDom := EmptyStr;
  Dir := TPath.Combine(TPath.GetDocumentsPath, Application.Title);

  if IsUrl(EdUrl.Text) then
  begin
    try
      U := TURI.Create(EdUrl.Text);
      DirDom := TPath.Combine(Dir, U.Host);
    except
      DirDom := EmptyStr;
    end;
  end;

  if DirectoryExists(DirDom) then
    ShellExecute(0, 'open', PChar(DirDom), nil, nil, SW_SHOWNORMAL)
  else if DirectoryExists(Dir) then
    ShellExecute(0, 'open', PChar(Dir), nil, nil, SW_SHOWNORMAL);
end;

{ ResetStatusPanels: remet à zéro les compteurs affichés sur la statusbar (thread-safe). }
procedure TFScrapix.ResetStatusPanels;
begin
  if TThread.Current.ThreadID <> MainThreadID then
  begin
    TThread.Queue(nil,
      procedure
      begin
        ResetStatusPanels;
      end);
    Exit;
  end;
  StatusBar.Panels[1].Text := '0';
  StatusBar.Panels[3].Text := '0';
  StatusBar.Panels[5].Text := '0';
  StatusBar.Panels[7].Text := '0';
end;

{ RestoreUIAfterRun: restaure l'UI après exécution du thread (toujours MainThread). }
procedure TFScrapix.RestoreUIAfterRun;
begin
  UpdateUI(False);
  BtnStart.Caption := GetTranslate('BtnStart');
  UpdateBtnBreak;
end;

{ BtnStartClick: lance l'exploration dans un thread anonyme, protège contre double démarrage. }
procedure TFScrapix.BtnStartClick(Sender: TObject);
begin
  if not IsUrl(Trim(EdUrl.Text)) then
  begin
    scShowMessage(GetTranslate('PleaseProvideUrl'));
    EdUrl.SetFocus;
    Exit;
  end;

  ListView.Items.Clear;
  SplitView.Close;
  UpdateUI(True);
  ResetStatusPanels;

  Logging.Items.Clear;
  ExPanelLog.RollUpState := False;

  if not Assigned(Scrapix) then
    Scrapix := TScrapix.Create;

  Scrapix.ConfigureCrawl(SeTimeout.ValueAsInt, SeDelay.ValueAsInt,
    CkSameDomain.Checked, CkAutoDownload.Checked, CkRobot.Checked,
    SeFoundFilesLimit.ValueAsInt, SeExploreLimit.ValueAsInt);

  BtnStart.Caption := GetTranslate('InProgress');

  TThread.CreateAnonymousThread(
    procedure
    begin
      try
        try
          Scrapix.ApplyFileTypeFiltersFromCheckList(CkListFileTypes);
          Scrapix.ExploreLinks(Trim(EdUrl.Text), ListView, StatusBar,
            CkListFileTypes, SeDepth.ValueAsInt, CkSaveBrokenLinks.Checked,
            CkSaveBrokenToFile.Checked, CkSaveFoundFilesToFile.Checked,
            Logging);
        except
          on E: Exception do
            TThread.Queue(nil,
              procedure
              begin
                scShowMessage('Explorer thread exception : ' + E.Message);
              end);
        end;
      finally
        TThread.Queue(nil,
          procedure
          begin
            if Assigned(Scrapix) and Scrapix.IsRunning then
            begin
              Scrapix.CancelExploration;
              Scrapix.WaitForStop;
            end;
            RestoreUIAfterRun;
          end);
      end;
    end).Start;
end;

{ BtnBreakClick: bascule entre pause et reprise. }
procedure TFScrapix.BtnBreakClick(Sender: TObject);
begin
  if not Assigned(Scrapix) then
    Exit;

  if Scrapix.IsPaused then
    Scrapix.ResumeExploration
  else
    Scrapix.PauseExploration;

  UpdateBtnBreak;
  UpdateUI(True);
end;

{ BtnStopClick: demande l'arrêt et attend la fin (bloquant court sur le thread UI). }
procedure TFScrapix.BtnStopClick(Sender: TObject);
begin
  if Assigned(Scrapix) then
  begin
    Scrapix.CancelExploration;
    Scrapix.WaitForStop;

    UpdateUI(False);
    BtnStart.Enabled := True;
    BtnStart.Caption := GetTranslate('BtnStart');
    BtnStop.Enabled := False;
    BtnBreak.Enabled := False;
  end;
end;

{ BtnSettingsClick: ouvre/ferme le panneau de configuration. }
procedure TFScrapix.BtnSettingsClick(Sender: TObject);
begin
  SplitView.Opened := not SplitView.Opened;

  if SplitView.Opened then
    ScrollBox.VertScrollBar.Position := 0;
end;

{ BtnResetUIClick: Réinitialise l'UI }
procedure TFScrapix.BtnResetUIClick(Sender: TObject);
begin
  EdUrl.Clear;
  ListView.Items.Clear;
  Logging.Items.Clear;
  StatusBar.Panels[1].Text := '0';
  StatusBar.Panels[3].Text := '0';
  StatusBar.Panels[5].Text := '0';
  StatusBar.Panels[7].Text := '0';
end;

{ BtnAboutClick: A propos... }
procedure TFScrapix.BtnAboutClick(Sender: TObject);
begin
  with TStringList.Create do
  begin
    Add('Développé par : XeGregory');
    Add('IDE : Embarcadero Delphi 11');
    Add('');
    Add('Version :');
    Add('- Srapix UI : v1.0');
    Add('- Srapix.Core.pas : v1.0');
    Add('- Translate.Core : v1.0');
    scShowMessage(Text);
    Free;
  end;
end;

{ BtnTranslateClick: change la langue de l'UI et met à jour les libellés. }
procedure TFScrapix.BtnTranslateClick(Sender: TObject);
begin
  case GetLanguage of
    lgFrench:
      begin
        SetLanguage(lgEnglish);
        BtnTranslate.ImageIndex := 3;
      end;
    lgEnglish:
      begin
        SetLanguage(lgFrench);
        BtnTranslate.ImageIndex := 2;
      end;
  end;
  UpdateTranslateUI;
end;

{ ListViewDblClick: ouvre l'URL sélectionnée dans le navigateur, exige que le crawler soit stoppé ou en pause. }
procedure TFScrapix.ListViewDblClick(Sender: TObject);
var
  SelItem: TListItem;
  Url: string;
begin
  SelItem := ListView.Selected;
  if SelItem = nil then
    Exit;

  Url := SelItem.Caption.Trim;
  if Url = '' then
    Exit;

  if Assigned(Scrapix) and not(Scrapix.IsPaused or Scrapix.IsCanceled) then
  begin
    scShowMessage(GetTranslate('StopOrPauseToOpen'));
    Exit;
  end;

  if not IsUrl(Url) then
  begin
    scShowMessage(GetTranslate('InvalidUrl') + Url);
    Exit;
  end;

  ShellExecute(0, 'open', PChar(Url), nil, nil, SW_SHOWNORMAL);
end;

end.
