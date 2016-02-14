unit DemoFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TfrmDemo = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmDemo: TfrmDemo;

implementation

{$R *.dfm}

procedure TfrmDemo.Button1Click(Sender: TObject);
begin
  ShowMessage('Hello World!');
end;

procedure TfrmDemo.Button2Click(Sender: TObject);
begin
  MessageDlg('Hello Information MessageDlg Box', mtInformation, [mbYes, mbNo,
    mbCancel], 0);
end;

procedure TfrmDemo.Button3Click(Sender: TObject);
begin
  MessageDlg('Hello Error MessageDlg Box', mtError, [mbAbort, mbRetry,
    mbIgnore], 0);
end;

procedure TfrmDemo.Button4Click(Sender: TObject);
var
  s: string;
begin
  InputBox('The Input Query', 'The Prompt', s);
end;

end.

