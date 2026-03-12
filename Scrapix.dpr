program Scrapix;

uses
  Vcl.Forms,
  UScrapix in 'UScrapix.pas' {FScrapix},
  Vcl.Themes,
  Vcl.Styles,
  Scrapix.Core in 'Scrapix.Core.pas',
  Translate.Core in 'Translate.Core.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Scrapix';
  TStyleManager.TrySetStyle('Windows10 Pattens Blue SE');
  Application.CreateForm(TFScrapix, FScrapix);
  Application.Run;
end.
