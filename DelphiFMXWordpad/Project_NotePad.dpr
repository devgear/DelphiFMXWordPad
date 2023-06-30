program Project_NotePad;

uses
  System.StartUpCopy,
  FMX.Forms,
  UMain_NotePad in 'UMain_NotePad.pas' {MainForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
