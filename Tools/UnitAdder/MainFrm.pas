unit MainFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, MessDlgs, StdCtrls, Mask, JvExMask, JvToolEdit, Buttons,
  ExtCtrls, JvExControls, JvComponent, JvgWizardHeader;

type
  TfrmMain = class(TForm)
    DirectoryEdit: TJvDirectoryEdit;
    EditUnit: TEdit;
    EditMust: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    btnStart: TSpeedButton;
    JvgWizardHeader1: TJvgWizardHeader;
    Bevel1: TBevel;
    procedure btnStartClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    UnitMap: TStringList;
    procedure HandleFile(const Directory: string; const FileInfo: TSearchRec);
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

uses
  jclStrings, FastStrings, jclFileUtils, regexpr, StrUtils;

{$R *.dfm}

var
  re: TRegExpr;
const
  REGEXPR = 'interface.*uses.*(%s).*;';

procedure TfrmMain.HandleFile(const Directory: string;
  const FileInfo: TSearchRec);
var
  s: string;
  i, i2: Int64;
begin
  if not CopyFile(PAnsiChar(Directory + FileInfo.Name), PAnsiChar(Directory +
    FileInfo.Name + '.bak'),
    true) then
  begin
    MessageDlg('Cannot make backup of ' + Directory +
      FileInfo.Name + sLineBreak +
      '(N.B. Check if already exists backup file)', mtError,
      [mbOk], 0);
    Exit;
  end;

  s := FileToString(Directory + FileInfo.Name);

  if (Trim(EditMust.Text) <> '') and (not re.Exec(s)) then
    Exit;

  //Aggiungo La Unit
  i := FastPosNoCase(s, 'uses', Length(s), Length('uses'), 1);
  if i > 0 then
  begin
    i2 := StrFind(';', s, i);
    if i2 > 0 then
      if FastPos(Copy(s, i, i2), EditUnit.Text, Length(Copy(s, i, i2)),
        Length(EditUnit.Text), 1) = 0 then
      begin
        Insert(', {Added by UnitsAdder} ' + EditUnit.Text, s, i2);
        StringToFile(Directory + FileInfo.Name, s);
        UnitMap.Add('Modified ' + FileInfo.Name);
      end;
  end;
end;

procedure TfrmMain.btnStartClick(Sender: TObject);
begin
  UnitMap.Clear;
  btnStart.Enabled := False;
  re := TRegExpr.Create;
  try
    re.ModifierS := True;
    re.ModifierI := True;
    re.Expression :=
      Format(REGEXPR, [EditMust.Text]);
    EnumFiles(IncludeTrailingPathDelimiter(DirectoryEdit.Text) + '*.pas',
      HandleFile);
    if UnitMap.Count > 0 then
      ShowMessage('Has been changed following units: ' + UnitMap.CommaText)
    else
      ShowMessage('No units has been changed');
  finally
    re.Free;
    btnStart.Enabled := True;
  end;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  UnitMap := TStringList.Create;
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  UnitMap.free;
end;

initialization
  MsgUseGradient := True;
  MsgUseShapedForm := True;
  MsgStartGradientColor := clGradientActiveCaption;
  MsgEndGradientColor := clGradientInactiveCaption;
  MsgUseCustomFont := True;
  MsgFont.Color := clWhite;
end.

