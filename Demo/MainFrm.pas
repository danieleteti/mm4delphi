unit MainFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  StdCtrls, Dialogs, Buttons, ExtCtrls, MessDlgs;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses DemoFrm, DemoMMFrm;

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  frmDemo.Show;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  frmDemoMM.Show;
end;

initialization
  MsgOptions.UseBorder := False;
  MsgOptions.UseGradient := True;
  MsgOptions.UseShapedForm := True;
  MsgOptions.UseCustomFont := True;
  MsgOptions.FormRoundSize := 40;
  MsgOptions.StartGradientColor := clNavy;
  MsgOptions.EndGradientColor := clBlack;
  MsgOptions.Font.Name := 'Tahoma';
  MsgOptions.Font.Style := [fsBold];
  MsgOptions.UseCustomButtons := True;
  {
  MsgOptions.CustomButtonsColorScheme := btncsSky;
  MsgOptions.CustomPanelColorScheme := pnlcsSky;
  }
  MsgOptions.UseCustomPanel := True;
end.

