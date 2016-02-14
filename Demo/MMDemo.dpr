program MMDemo;

uses
  Forms,
  MainFrm in 'MainFrm.pas' {Form1},
  DemoMMFrm in 'DemoMMFrm.pas' {frmDemoMM},
  DemoFrm in 'DemoFrm.pas' {frmDemo},
  MessDlgs in '..\MessDlgs.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TfrmDemoMM, frmDemoMM);
  Application.CreateForm(TfrmDemo, frmDemo);
  Application.Run;
end.
