program UnitsAdder;

uses
  Forms,
  MainFrm in 'MainFrm.pas' {frmMain};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'UnitsAdder';
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
