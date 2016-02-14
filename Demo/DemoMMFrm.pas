unit DemoMMFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, MessDlgs, ExtCtrls;

type
  TfrmDemoMM = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    GroupBox1: TGroupBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    ScrollBar1: TScrollBar;
    RadioGroup1: TRadioGroup;
    Button5: TButton;
    ComboBox1: TComboBox;
    Label1: TLabel;
    GroupBox2: TGroupBox;
    chkUseCustomPanel: TCheckBox;
    FontDialog1: TFontDialog;
    Button6: TButton;
    chkUseCustomButtons: TCheckBox;
    chkUseGradient: TCheckBox;
    chkUseShapedForm: TCheckBox;
    chkUseBorder: TCheckBox;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure ScrollBar1Change(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure chkUseCustomPanelClick(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure chkUseCustomButtonsClick(Sender: TObject);
    procedure chkUseGradientClick(Sender: TObject);
    procedure chkUseShapedFormClick(Sender: TObject);
    procedure chkUseBorderClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmDemoMM: TfrmDemoMM;

implementation

uses Math;

{$R *.dfm}
const
  STATUS_CAPTION = 'This is a Status Progress';

procedure TfrmDemoMM.Button1Click(Sender: TObject);
begin
  ShowMessage('Hello World!');
end;

procedure TfrmDemoMM.Button2Click(Sender: TObject);
begin
  MessageDlg('Hello Information MessageDlg Box', mtInformation, [mbYes, mbNo,
    mbCancel], 0);
end;

procedure TfrmDemoMM.Button3Click(Sender: TObject);
begin
  MessageDlg('Hello Error MessageDlg Box', mtError, [mbAbort, mbRetry,
    mbIgnore], 0);
end;

procedure TfrmDemoMM.Button4Click(Sender: TObject);
var
  s: string;
begin
  InputBox('The Input Query', 'The Prompt', s);
end;

procedure TfrmDemoMM.BitBtn1Click(Sender: TObject);
begin
  ShowStatusPos(STATUS_CAPTION, Point(50, 50), True);
end;

procedure TfrmDemoMM.BitBtn2Click(Sender: TObject);
begin
  CloseStatus;
end;

procedure TfrmDemoMM.ScrollBar1Change(Sender: TObject);
begin
  UpdateStatus(ScrollBar1.Position, Format(STATUS_CAPTION + ' %2d%%',
    [ScrollBar1.Position]));
end;

procedure TfrmDemoMM.RadioGroup1Click(Sender: TObject);
begin
  case RadioGroup1.ItemIndex of
    0:
      begin
        MsgOptions.CustomButtonsColorScheme := btncsSky;
        MsgOptions.CustomPanelColorScheme := pnlcsSky;
        MsgOptions.CustomProgressColorScheme := procsSky;

      end;
    1:
      begin
        MsgOptions.CustomButtonsColorScheme := btncsSun;
        MsgOptions.CustomPanelColorScheme := pnlcsSun;
        MsgOptions.CustomProgressColorScheme := procsSun;

      end;
    2:
      begin
        MsgOptions.CustomButtonsColorScheme := btncsSilver;
        MsgOptions.CustomPanelColorScheme := pnlcsSilver;
        MsgOptions.CustomProgressColorScheme := procsSilver;
      end;
    3:
      begin
        MsgOptions.CustomButtonsColorScheme := btncsGrass;
        MsgOptions.CustomPanelColorScheme := pnlcsGrass;
        MsgOptions.CustomProgressColorScheme := procsGrass;
      end;
    4:
      begin
        MsgOptions.CustomButtonsColorScheme := btncsDesert;
        MsgOptions.CustomPanelColorScheme := pnlcsDesert;
        MsgOptions.CustomProgressColorScheme := procsDesert;
      end;

  end;

end;

procedure TfrmDemoMM.Button5Click(Sender: TObject);
begin
  MsgOptions.CustomButtonsColorScheme := TButtonColorScheme(RandomRange(0,
    Ord(High(MessDlgs.TButtonColorScheme))));

  MsgOptions.CustomPanelColorScheme := TPanelColorScheme(RandomRange(0,
    Ord(High(MessDlgs.TPanelColorScheme))));

  MsgOptions.CustomProgressColorScheme := TProgressColorScheme(RandomRange(0,
    Ord(High(MessDlgs.TProgressColorScheme))));
  ShowMessage('This is a Random ColorScheme');
end;

procedure TfrmDemoMM.ComboBox1Change(Sender: TObject);
begin
  {
        Italian
        English
        German
        French
        Spanish
        And many others...
  }
  case ComboBox1.ItemIndex of
    0: MsgOptions.DefLang := ltItalian;
    1: MsgOptions.DefLang := ltEnglish;
    2: MsgOptions.DefLang := ltGerman;
    3: MsgOptions.DefLang := ltFrench;
    4: MsgOptions.DefLang := ltSpanish;
  end;
end;

procedure TfrmDemoMM.Button6Click(Sender: TObject);
begin
  FontDialog1.Font.Assign(MsgOptions.Font);
  if FontDialog1.Execute then
    MsgOptions.Font.Assign(FontDialog1.Font);
end;

procedure TfrmDemoMM.chkUseCustomPanelClick(Sender: TObject);
begin
  MsgOptions.UseCustomPanel := chkUseCustomPanel.Checked;
end;

procedure TfrmDemoMM.chkUseCustomButtonsClick(Sender: TObject);
begin
  MsgOptions.UseCustomButtons := chkUseCustomButtons.Checked;
end;

procedure TfrmDemoMM.chkUseGradientClick(Sender: TObject);
begin
  MsgOptions.UseGradient := chkUseGradient.Checked;
end;

procedure TfrmDemoMM.chkUseShapedFormClick(Sender: TObject);
begin
  MsgOptions.UseShapedForm := chkUseShapedForm.Checked;
end;

procedure TfrmDemoMM.chkUseBorderClick(Sender: TObject);
begin
  MsgOptions.UseBorder := chkUseBorder.Checked;
end;

end.

