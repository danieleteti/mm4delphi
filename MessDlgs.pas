{ ************************************************************************ }
{ Message Master by Daniele Teti - TDSoft@libero.it }
{ Version 1.0.2 }
{ Version 1.2.0 }
{ }
{ Italian/English/Russian/Portuguese/German/French/Greek/Spanish/... }
{ message/input dialogs }
{ }
{ Delphi Visual Component Library }
{ Copyright (c) 1995,2004 Borland International }
{ }
{ Initial idea and some portions of code by follow people... }
{ }
{ }
{ Tiny portions by Andrew Anoshkin '1997-98 }
{ Portuguese translation by Renato M. Prado }
{ Turkish translation by Egemen ÞEN }
{ German translation by Godfrey McLean }
{ Dutch translation by Leonard Wennekers }
{ French translation by Jean-Fabien Connault }
{ Greek translation by Babis Michail }
{ Spanish translation by Jorge R. Lopez Danieluk }
{ Italian translation by Daniele Teti }
{ }
{ Many thanks to Eugene Genev for his XiComponents }
{
  History:
  02/12/2004 Initial Release
  13/12/2004 Added ShowError Procedure
  20/12/2004 Some bug fix
  21/01/2005 Published on http://dade2000.altervista.org
  14/02/2016 Updated for newer Delphi versions
  {************************************************************************ }

unit MessDlgs;

interface

uses Windows, SysUtils, Consts, Classes, Controls, Graphics, Dialogs, Forms,
  StdCtrls, ExtCtrls,
  XiProgressBar, XiPanel, XiButton;

{ Message/Input dialogs }

type
  TLangType = (ltEnglish, ltRussian, ltPortuguese, ltTurkish, ltGerman, ltDutch,
    ltFrench, ltGreek, ltSpanish, ltItalian);
  TProgressColorScheme = (procsCustom, procsDesert, procsGrass, procsSilver,
    procsSky, procsRose, procsSun, procsHackers, procsNight, procsVelvet,
    procsMetal, procsViolet, procsToxic);
  TPanelColorScheme = (pnlcsCustom, pnlcsDesert, pnlcsGrass, pnlcsSilver,
    pnlcsSky, pnlcsRose, pnlcsSun);

  TButtonColorScheme = (btncsNeoDesert, btncsNeoSky, btncsNeoGrass,
    btncsNeoSilver, btncsNeoRose, btncsNeoSun, btncsDesert, btncsGrass,
    btncsSky, btncsSun, btncsRose, btncsSilver, btncsCustom);

  TPercentage = 1 .. 100;

  TMsgOptions = record
    { Prima di visualizzare la finestra di status controlla che l'applicazione
      abbia il focus e che sia quella attiva }
    SilentStatus: Boolean;
    { Prima di visualizzare la finestra di status controlla che l'applicazione
      abbia il focus e che la form visualizzata abbia questo handle }
    ShowStatusOnlyOnForm: THandle;

    // Lingua
    DefLang: TLangType;
    UseGradient: Boolean; // Abilita il gradient

    { ------------------------------ }
    UseBorder: Boolean; // = True;
    UseCustomButtons: Boolean; // XiButtons
    CustomButtonsColorScheme: TButtonColorScheme; // XiButtons Color Scheme
    CustomPanelColorScheme: TPanelColorScheme; // XiPanel Color Scheme
    CustomProgressColorScheme: TProgressColorScheme; // XiProgress Color Scheme
    StatusWidth: Cardinal;
    UseCustomPanel: Boolean;
    { ------------------------------ }

    UseCustomFont: Boolean; // Abilita il font personalizzato
    UseShapedForm: Boolean; // Abilita l'usa di form con bordi stondati
    FormRoundSize: Cardinal; // Raggio dell'angolo delle form
    StartGradientColor, EndGradientColor: TColor;
    // Colore di inizio e di fine gradient
    Font: TFont; // Font usato (nal caso si CustomFont abilitato)
  end;

var
  MsgOptions: TMsgOptions;

const
{$I International.inc}
procedure DrawGradient(ACanvas: TCanvas; Rect: TRect; Horizontal: Boolean;
  Colors: array of TColor);

procedure ShowMessage(const Message: string);
procedure ShowError(const Message: string);

function MessageDlg(const Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; HelpCtx: Longint): Integer;

function MessageDlgI(const Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; HelpCtx: Longint; Lang: TLangType): Integer;
function MessageDlgPosI(const Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; HelpCtx: Longint; X, Y: Integer;
  Lang: TLangType): Integer;

function InputQueryI(const ACaption, APrompt: string; var Value: string;
  Lang: TLangType): Boolean;

function InputQuery(const ACaption, APrompt: string; var Value: string)
  : Boolean;

function InputBoxI(const ACaption, APrompt, ADefault: string;
  Lang: TLangType): string;
function InputBox(const ACaption, APrompt, ADefault: string): string;

function CreateMessageDialogI(const Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; Lang: TLangType): TForm;

{ -------- Status --------------------- }
procedure ShowStatus(const sCaption: string; ProgressVisible: Boolean = True);
procedure ShowStatusPos(const sCaption: string; sPosition: TPoint;
  ProgressVisible: Boolean = True);
procedure UpdateStatus(const Perc: TPercentage); overload;
procedure UpdateStatus(const sCaption: string); overload;
procedure UpdateStatus(const Perc: TPercentage;
  const sCaption: string); overload;
procedure CloseStatus;

implementation

uses Types;

var
  FormRegion: HRGN;
  StatusForm: TForm = nil;
  StatusLabel: TLabel;
  StatusProgress: TXiProgressBar;

procedure DrawGradient(ACanvas: TCanvas; Rect: TRect; Horizontal: Boolean;
  Colors: array of TColor);
type
  RGBArray = array [0 .. 2] of Byte;
var
  X, Y, z, stelle, mx, bis, faColorsh, mass: Integer;
  Faktor: double;
  A: RGBArray;
  B: array of RGBArray;
  merkw: Integer;
  merks: TPenStyle;
  merkp: TColor;
begin
  mx := High(Colors);
  if mx > 0 then
  begin
    if Horizontal then
      mass := Rect.Right - Rect.Left
    else
      mass := Rect.Bottom - Rect.Top;
    SetLength(B, mx + 1);
    for X := 0 to mx do
    begin
      Colors[X] := ColorToRGB(Colors[X]);
      B[X][0] := GetRValue(Colors[X]);
      B[X][1] := GetGValue(Colors[X]);
      B[X][2] := GetBValue(Colors[X]);
    end;
    merkw := ACanvas.Pen.Width;
    merks := ACanvas.Pen.Style;
    merkp := ACanvas.Pen.Color;
    ACanvas.Pen.Width := 1;
    ACanvas.Pen.Style := psSolid;
    faColorsh := Round(mass / mx);
    for Y := 0 to mx - 1 do
    begin
      if Y = mx - 1 then
        bis := mass - Y * faColorsh - 1
      else
        bis := faColorsh;
      for X := 0 to bis do
      begin
        stelle := X + Y * faColorsh;
        Faktor := X / bis;
        for z := 0 to 3 do
          A[z] := Trunc(B[Y][z] + ((B[Y + 1][z] - B[Y][z]) * Faktor));
        ACanvas.Pen.Color := RGB(A[0], A[1], A[2]);
        if Horizontal then
        begin
          ACanvas.MoveTo(Rect.Left + stelle, Rect.Top);
          ACanvas.LineTo(Rect.Left + stelle, Rect.Bottom);
        end
        else
        begin
          ACanvas.MoveTo(Rect.Left, Rect.Top + stelle);
          ACanvas.LineTo(Rect.Right, Rect.Top + stelle);
        end;
      end;
    end;
    B := nil;
    ACanvas.Pen.Width := merkw;
    ACanvas.Pen.Style := merks;
    ACanvas.Pen.Color := merkp;
  end
  else
    // Please specify at least two colors
    raise EMathError.Create('Please specify at least two colors');
end;

function Max(I, J: Integer): Integer;
begin
  if I > J then
    Result := I
  else
    Result := J;
end;

function GetAveCharSize(Canvas: TCanvas): TPoint;
var
  I: Integer;
  Buffer: array [0 .. 51] of Char;
begin
  for I := 0 to 25 do
    Buffer[I] := Chr(I + Ord('A'));
  for I := 0 to 25 do
    Buffer[I + 26] := Chr(I + Ord('a'));
  GetTextExtentPoint(Canvas.Handle, Buffer, 52, TSize(Result));
  Result.X := Result.X div 52;
end;

type
  TMessageForm = class(TForm)
  private
    procedure HelpButtonClick(Sender: TObject);
  public
    procedure PaintGradient(Sender: TObject);
    constructor CreateNew(AOwner: TComponent); reintroduce;
    destructor Destroy; override;
  end;

constructor TMessageForm.CreateNew(AOwner: TComponent);
var
  NonClientMetrics: TNonClientMetrics;
begin
  inherited CreateNew(AOwner);

  NonClientMetrics.cbSize := sizeof(NonClientMetrics);
  if SystemParametersInfo(SPI_GETNONCLIENTMETRICS, 0, @NonClientMetrics, 0) then
    Font.Handle := CreateFontIndirect(NonClientMetrics.lfMessageFont);

  if MsgOptions.UseGradient and (not MsgOptions.UseCustomPanel) then
    OnPaint := PaintGradient;

  if MsgOptions.UseCustomFont then
    Font.Assign(MsgOptions.Font);
  PopupMode := pmExplicit;
end;

destructor TMessageForm.Destroy;
begin
  DeleteObject(FormRegion);
  inherited;
end;

procedure TMessageForm.HelpButtonClick(Sender: TObject);
begin
  Application.HelpContext(HelpContext);
end;

function CreateMessageDialogI(const Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; Lang: TLangType): TForm;
const
  mcHorzMargin = 8;
  mcVertMargin = 8;
  mcHorzSpacing = 10;
  mcVertSpacing = 10;
  mcButtonWidth = 50;
  mcButtonHeight = 14;
  mcButtonSpacing = 4;
const
  IconIDs: array [TMsgDlgType] of PChar = (IDI_EXCLAMATION, IDI_HAND,
    IDI_ASTERISK, IDI_QUESTION, nil);

  ButtonNames: array [TMsgDlgBtn] of string = ('Yes', 'No', 'OK', 'Cancel',
    'Abort', 'Retry', 'Ignore', 'All', 'NoToAll', 'YesToAll',
    'Help'{$IF CompilerVersion >= 21}, 'Close'{$ENDIF});

  ModalResults: array [TMsgDlgBtn] of Integer = (mrYes, mrNo, mrOk, mrCancel,
    mrAbort, mrRetry, mrIgnore, mrAll, mrNoToAll, mrYesToAll, 9, mrClose);

var
  DialogUnits: TPoint;
  HorzMargin, VertMargin, HorzSpacing, VertSpacing, ButtonWidth, ButtonHeight,
    ButtonSpacing, ButtonCount, ButtonGroupWidth, IconTextWidth, IconTextHeight,
    X: Integer;
  B, DefaultButton, CancelButton: TMsgDlgBtn;
  IconID: PChar;
  TextRect: TRect;
  TheParent: TWinControl;
  pnl: TXiPanel;
begin
  Result := TMessageForm.CreateNew(Application);
  with Result do
  begin
    if MsgOptions.UseCustomFont then
      Font.Assign(MsgOptions.Font);
    if MsgOptions.UseCustomPanel then
    begin
      pnl := TXiPanel.Create(Result);
      with pnl do
      begin
        Name := 'ThePanel';
        Caption := '';
        Align := alClient;
        ColorScheme := XiPanel.TColorScheme(MsgOptions.CustomPanelColorScheme);
        Parent := Result;
      end;
      TheParent := pnl;
    end
    else
      TheParent := Result;

    if MsgOptions.UseBorder then
      BorderStyle := bsDialog
    else
      BorderStyle := bsNone;

    Canvas.Font.Assign(Font);

    if MsgOptions.UseCustomPanel then
      Canvas.Font.Color := pnl.ColorDark;

    DialogUnits := GetAveCharSize(Canvas);
    HorzMargin := MulDiv(mcHorzMargin, DialogUnits.X, 4);
    VertMargin := MulDiv(mcVertMargin, DialogUnits.Y, 8);
    HorzSpacing := MulDiv(mcHorzSpacing, DialogUnits.X, 4);
    VertSpacing := MulDiv(mcVertSpacing, DialogUnits.Y, 8);
    ButtonWidth := MulDiv(mcButtonWidth, DialogUnits.X, 4);
    ButtonHeight := MulDiv(mcButtonHeight, DialogUnits.Y, 8);
    ButtonSpacing := MulDiv(mcButtonSpacing, DialogUnits.X, 4);
    SetRect(TextRect, 0, 0, Screen.Width div 2, 0);
    DrawText(Canvas.Handle, PChar(Msg), -1, TextRect, DT_CALCRECT or
      DT_WORDBREAK);
    IconID := IconIDs[DlgType];
    IconTextWidth := TextRect.Right;
    IconTextHeight := TextRect.Bottom;
    if IconID <> nil then
    begin
      Inc(IconTextWidth, 32 + HorzSpacing);
      if IconTextHeight < 32 then
        IconTextHeight := 32;
    end;
    ButtonCount := 0;
    for B := Low(TMsgDlgBtn) to High(TMsgDlgBtn) do
      if B in Buttons then
        Inc(ButtonCount);
    ButtonGroupWidth := 0;
    if ButtonCount <> 0 then
      ButtonGroupWidth := ButtonWidth * ButtonCount + ButtonSpacing *
        (ButtonCount - 1);
    ClientWidth := Max(IconTextWidth, ButtonGroupWidth) + HorzMargin * 2;
    ClientHeight := IconTextHeight + ButtonHeight + VertSpacing +
      VertMargin * 2;
    Left := (Screen.Width div 2) - (Width div 2);
    Top := (Screen.Height div 2) - (Height div 2);

    if DlgType <> mtCustom then
      // Support International
      case Lang of
        ltItalian:
          Caption := CaptionsI[DlgType];
        ltRussian:
          Caption := CaptionsR[DlgType];
        ltPortuguese:
          Caption := CaptionsP[DlgType];
        ltTurkish:
          Caption := CaptionsT[DlgType];
        ltGerman:
          Caption := CaptionsG[DlgType];
        ltDutch:
          Caption := CaptionsD[DlgType];
        ltFrench:
          Caption := CaptionsF[DlgType];
        ltGreek:
          Caption := CaptionsGr[DlgType];
        ltSpanish:
          Caption := CaptionsS[DlgType];
      else // ltEnglish
        Caption := CaptionsE[DlgType]
      end // end of Case
    else
      Caption := Application.Title;

    if IconID <> nil then
      with TImage.Create(TheParent) do
      begin
        Name := 'Image';
        Parent := TheParent;
        Picture.Icon.Handle := LoadIcon(0, IconID);
        SetBounds(HorzMargin, VertMargin, 32, 32);
      end;
    with TLabel.Create(TheParent) do
    begin
      // Color:=clRed;
      Autosize := True; // ?
      Transparent := True;
      // Transparent := false;

      Name := 'Message';
      Parent := TheParent;
      WordWrap := True;
      Caption := Msg;
      Font.Assign(MsgOptions.Font);
      if MsgOptions.UseCustomPanel then
        Font.Color := pnl.ColorDark;

      BoundsRect := TextRect;
      SetBounds(IconTextWidth - TextRect.Right + HorzMargin, VertMargin,
        TextRect.Right, TextRect.Bottom * 2);
      BringToFront;
    end;
    if mbOk in Buttons then
      DefaultButton := mbOk
    else if mbYes in Buttons then
      DefaultButton := mbYes
    else
      DefaultButton := mbRetry;
    if mbCancel in Buttons then
      CancelButton := mbCancel
    else if mbNo in Buttons then
      CancelButton := mbNo
    else
      CancelButton := mbOk;
    X := (ClientWidth - ButtonGroupWidth) div 2;
    for B := Low(TMsgDlgBtn) to High(TMsgDlgBtn) do
      if B in Buttons then
      begin
        if MsgOptions.UseCustomButtons then
        begin
          with TXiButton.Create(Result) do
          begin
            ColorScheme := XiButton.TColorScheme
              (MsgOptions.CustomButtonsColorScheme);
            Name := ButtonNames[B];
            Parent := TheParent;

            // Support International
            case Lang of
              ltItalian:
                Caption := ButtonCaptionsI[B];
              ltRussian:
                Caption := ButtonCaptionsR[B];
              ltPortuguese:
                Caption := ButtonCaptionsP[B];
              ltTurkish:
                Caption := ButtonCaptionsT[B];
              ltGerman:
                Caption := ButtonCaptionsG[B];
              ltDutch:
                Caption := ButtonCaptionsD[B];
              ltFrench:
                Caption := ButtonCaptionsF[B];
              ltGreek:
                Caption := ButtonCaptionsGr[B];
              ltSpanish:
                Caption := ButtonCaptionsS[B];
            else // ltEnglish
              Caption := ButtonCaptionsE[B];
            end;

            ModalResult := ModalResults[B];
            if B = DefaultButton then
              Default := True;
            if B = CancelButton then
              Cancel := True;
            SetBounds(X, IconTextHeight + VertMargin + VertSpacing, ButtonWidth,
              ButtonHeight);
            Inc(X, ButtonWidth + ButtonSpacing);
            if B = mbHelp then
              OnClick := TMessageForm(Result).HelpButtonClick;
          end; // End With
        end
        else
        begin
          with TButton.Create(Result) do
          begin
            Name := ButtonNames[B];
            Parent := TheParent;

            // Support International
            case Lang of
              ltItalian:
                Caption := ButtonCaptionsI[B];
              ltRussian:
                Caption := ButtonCaptionsR[B];
              ltPortuguese:
                Caption := ButtonCaptionsP[B];
              ltTurkish:
                Caption := ButtonCaptionsT[B];
              ltGerman:
                Caption := ButtonCaptionsG[B];
              ltDutch:
                Caption := ButtonCaptionsD[B];
              ltFrench:
                Caption := ButtonCaptionsF[B];
              ltGreek:
                Caption := ButtonCaptionsGr[B];
              ltSpanish:
                Caption := ButtonCaptionsS[B];
            else // ltEnglish
              Caption := ButtonCaptionsE[B];
            end;

            ModalResult := ModalResults[B];
            if B = DefaultButton then
              Default := True;
            if B = CancelButton then
              Cancel := True;
            SetBounds(X, IconTextHeight + VertMargin + VertSpacing, ButtonWidth,
              ButtonHeight);
            Inc(X, ButtonWidth + ButtonSpacing);
            if B = mbHelp then
              OnClick := TMessageForm(Result).HelpButtonClick;
          end; // End With
        end;
      end;

    if MsgOptions.UseShapedForm and (not MsgOptions.UseCustomPanel) then
    begin
      BorderStyle := bsNone;
      if MsgOptions.UseBorder then
        Height := Height - 35; // Troppo spazio sotto i bottoni
      FormRegion := CreateRoundRectRgn(0, 0, Width, Height,
        MsgOptions.FormRoundSize, MsgOptions.FormRoundSize);
      SetWindowRgn(Handle, FormRegion, True);
    end;
  end;
end;

function MessageDlgI(const Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; HelpCtx: Longint; Lang: TLangType): Integer;
begin
  Result := MessageDlgPosI(Msg, DlgType, Buttons, HelpCtx, -1, -1, Lang);
end;

function MessageDlg(const Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; HelpCtx: Longint): Integer;
begin
  Result := MessageDlgI(Msg, DlgType, Buttons, HelpCtx, MsgOptions.DefLang);
end;

function MessageDlgPosI(const Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; HelpCtx: Longint; X, Y: Integer;
  Lang: TLangType): Integer;
begin
  with CreateMessageDialogI(Msg, DlgType, Buttons, Lang) do
    try
      HelpContext := HelpCtx;
      if X >= 0 then
        Left := X;
      if Y >= 0 then
        Top := Y;
      Result := ShowModal;
    finally
      Free;
    end;
end;

{ Input dialog }

function InputQueryI(const ACaption, APrompt: string; var Value: string;
  Lang: TLangType): Boolean;
var
  Form: TForm;
  Prompt: TLabel;
  Edit: TEdit;
  DialogUnits: TPoint;
  ButtonTop, ButtonWidth, ButtonHeight: Integer;
  CancelCaption: string;
  pnl: TXiPanel;
  TheParent: TWinControl;
begin
  Result := False;
  // Form := TForm.Create(Application);

  Form := TMessageForm.CreateNew(Application);
  with Form do
    try
      Canvas.Font := Font;
      DialogUnits := GetAveCharSize(Canvas);
      if MsgOptions.UseBorder then
        BorderStyle := bsDialog
      else
        BorderStyle := bsNone;

      Caption := ACaption;
      ClientWidth := MulDiv(180, DialogUnits.X, 4);
      ClientHeight := MulDiv(63, DialogUnits.Y, 8);
      Position := poScreenCenter;

      if MsgOptions.UseCustomPanel then
      begin
        pnl := TXiPanel.Create(Form);
        with pnl do
        begin
          Align := alClient;
          ColorScheme := XiPanel.TColorScheme
            (MsgOptions.CustomPanelColorScheme);
          Parent := Form;
        end;
        TheParent := pnl;
      end
      else
        TheParent := Form;

      Prompt := TLabel.Create(Form);
      with Prompt do
      begin
        Parent := TheParent;
        Autosize := True;
        Left := MulDiv(8, DialogUnits.X, 4);
        Top := MulDiv(8, DialogUnits.Y, 8);
        Caption := APrompt;
        Transparent := True;
      end;
      Edit := TEdit.Create(Form);
      with Edit do
      begin
        Parent := TheParent;
        Left := Prompt.Left;
        Top := MulDiv(19, DialogUnits.Y, 8);
        Width := MulDiv(164, DialogUnits.X, 4);
        MaxLength := 255;
        Text := Value;
        SelectAll;
      end;
      ButtonTop := MulDiv(41, DialogUnits.Y, 8);
      ButtonWidth := MulDiv(50, DialogUnits.X, 4);
      ButtonHeight := MulDiv(14, DialogUnits.Y, 8);

      /// /////// OK Button on InputQuery // Start
      if MsgOptions.UseCustomButtons then
        with TXiButton.Create(Form) do
        begin
          Parent := TheParent;
          Caption := SMsgDlgOK;
          ModalResult := mrOk;
          Default := True;
          SetBounds(MulDiv(38, DialogUnits.X, 4), ButtonTop, ButtonWidth,
            ButtonHeight);
          ColorScheme := XiButton.TColorScheme
            (MsgOptions.CustomButtonsColorScheme);
        end
      else
        with TButton.Create(Form) do
        begin
          Parent := TheParent;
          Caption := SMsgDlgOK;
          ModalResult := mrOk;
          Default := True;
          SetBounds(MulDiv(38, DialogUnits.X, 4), ButtonTop, ButtonWidth,
            ButtonHeight);
        end;
      /// /////// OK Button on InputQuery // End

      /// /// International support for Cancel Caption
      case Lang of
        ltItalian:
          CancelCaption := sCancelCaptionI;
        ltRussian:
          CancelCaption := sCancelCaptionR;
        ltPortuguese:
          CancelCaption := sCancelCaptionP;
        ltTurkish:
          CancelCaption := sCancelCaptionT;
        ltGerman:
          CancelCaption := sCancelCaptionG;
        ltDutch:
          CancelCaption := sCancelCaptionD;
        ltFrench:
          CancelCaption := sCancelCaptionF;
        ltGreek:
          CancelCaption := sCancelCaptionGr;
        ltSpanish:
          CancelCaption := sCancelCaptionS;
      else // ltEnglish
        CancelCaption := sCancelCaptionE;
      end;

      /// /
      if MsgOptions.UseCustomButtons then
        with TXiButton.Create(Form) do
        begin
          Parent := TheParent;
          ModalResult := mrCancel;
          Cancel := True;
          SetBounds(MulDiv(92, DialogUnits.X, 4), ButtonTop, ButtonWidth,
            ButtonHeight);
          ColorScheme := XiButton.TColorScheme
            (MsgOptions.CustomButtonsColorScheme);
          Caption := CancelCaption;
        end
      else
        with TButton.Create(Form) do
        begin
          Parent := TheParent;
          ModalResult := mrCancel;
          Cancel := True;
          SetBounds(MulDiv(92, DialogUnits.X, 4), ButtonTop, ButtonWidth,
            ButtonHeight);
          Caption := CancelCaption;
        end;

      if MsgOptions.UseShapedForm and (not MsgOptions.UseCustomPanel) then
      begin
        BorderStyle := bsNone;
        if MsgOptions.UseBorder then
          Height := Height - 35; // Troppo spazio sotto i bottoni
        FormRegion := CreateRoundRectRgn(0, 0, Width, Height,
          MsgOptions.FormRoundSize, MsgOptions.FormRoundSize);
        SetWindowRgn(Handle, FormRegion, True);
      end;

      if ShowModal = mrOk then
      begin
        Value := Edit.Text;
        Result := True;
      end;
    finally
      Form.Free;
    end;
end;

function InputQuery(const ACaption, APrompt: string; var Value: string)
  : Boolean;
begin
  Result := InputQueryI(ACaption, APrompt, Value, MsgOptions.DefLang);
end;

function InputBoxI(const ACaption, APrompt, ADefault: string;
  Lang: TLangType): string;
begin
  Result := ADefault;
  InputQueryI(ACaption, APrompt, Result, Lang);
end;

function InputBox(const ACaption, APrompt, ADefault: string): string;
begin
  Result := InputBoxI(ACaption, APrompt, ADefault, MsgOptions.DefLang);
end;

procedure ShowMessage(const Message: string);
begin
  MessageDlg(Message, mtInformation, [mbOk], 0);
end;

procedure ShowError(const Message: string);
begin
  MessageDlg(Message, mtError, [mbOk], 0);
end;

procedure TMessageForm.PaintGradient(Sender: TObject);
begin
  DrawGradient(self.Canvas, ClientRect, False, [MsgOptions.StartGradientColor,
    MsgOptions.EndGradientColor]);
end;

{ ------------- Status --------- }

procedure CheckStatus(StatusMustBeCreated: Boolean);
begin
  if StatusMustBeCreated and (StatusForm = nil) then
    raise Exception.Create('Status not created');
  if (not StatusMustBeCreated) and (StatusForm <> nil) then
    raise Exception.Create('Status already created');
end;

procedure ShowStatusPos(const sCaption: string; sPosition: TPoint;
  ProgressVisible: Boolean = True);
var
  Panel: TXiPanel;
begin
  CheckStatus(False);
  StatusForm := TMessageForm.CreateNew(Application);
  with StatusForm do
  begin
    Position := TPosition.poDesigned;
    Left := sPosition.X;
    Top := sPosition.Y;
    FormStyle := fsStayOnTop;
    BorderStyle := bsNone;
    BorderIcons := [];
    Canvas.Font := Font;
    Width := MsgOptions.StatusWidth;
    Height := 80;
  end;

  Panel := TXiPanel.Create(StatusForm);
  with Panel do
  begin
    Parent := StatusForm;
    Align := alClient;
    ColorScheme := XiPanel.TColorScheme(MsgOptions.CustomPanelColorScheme);
    Caption := '';
  end;

  StatusProgress := TXiProgressBar.Create(StatusForm);
  with StatusProgress do
  begin
    Visible := ProgressVisible;
    Top := Trunc(StatusForm.Height * 0.6);
    Left := Trunc(StatusForm.Width * 0.05);
    Width := Trunc(StatusForm.Width * 0.90);
    Parent := Panel;
    ColorScheme := XiProgressBar.TColorScheme
      (MsgOptions.CustomProgressColorScheme);
  end;
  StatusLabel := TLabel.Create(StatusForm);
  with StatusLabel do
  begin
    Autosize := False;
    WordWrap := True;
    Top := Trunc(StatusForm.Height * 0.1);
    Left := Trunc(StatusForm.Width * 0.05);
    Width := StatusForm.Width - Left * 2;
    Parent := Panel;
    Transparent := True;
    Font.Assign(MsgOptions.Font);
    Font.Color := Panel.ColorDark; // Colore dell'ombra del pannello
    Font.Style := [fsBold];
    Caption := sCaption
  end;

  if MsgOptions.SilentStatus and not Application.Active then
    StatusForm.Visible := False
  else if (MsgOptions.ShowStatusOnlyOnForm = 0) or
    (GetForegroundWindow = MsgOptions.ShowStatusOnlyOnForm) then
  begin
    StatusForm.Visible := True;
    StatusForm.Update;
  end;
end;

procedure ShowStatus(const sCaption: string; ProgressVisible: Boolean = True);
var
  p: TPoint;
begin
  p := CenterPoint(Screen.DesktopRect);
  p.X := p.X - (MsgOptions.StatusWidth div 2);
  ShowStatusPos(sCaption, p, ProgressVisible);
end;

procedure UpdateStatus(const Perc: TPercentage);
begin
  CheckStatus(True);
  StatusProgress.Position := Perc;
  StatusForm.Update;
end;

procedure UpdateStatus(const sCaption: string);
begin
  CheckStatus(True);
  StatusLabel.Caption := sCaption;
  StatusForm.Update;
end;

procedure UpdateStatus(const Perc: TPercentage; const sCaption: string);
begin
  UpdateStatus(Perc);
  UpdateStatus(sCaption);
end;

procedure CloseStatus;
begin
  CheckStatus(True);
  FreeAndNil(StatusForm);
end;

initialization

with MsgOptions do
begin
  DefLang := ltEnglish;
  SilentStatus := False;
  ShowStatusOnlyOnForm := 0;
  UseBorder := True;
  UseGradient := False;
  UseCustomButtons := False;
  CustomButtonsColorScheme := btncsSky;
  CustomPanelColorScheme := pnlcsSky;
  CustomProgressColorScheme := procsSky;
  StatusWidth := 300;
  UseCustomFont := False;
  StartGradientColor := 15448477; // clGradientInactiveCaption;
  EndGradientColor := 16749885; // clGradientActiveCaption;
  UseShapedForm := False;
  FormRoundSize := 15;
  Font := TFont.Create;
  with Font do
  begin
    // Name := 'Verdana';
    // Size := 10;
    // Style := [fsBold];
  end;
end;

finalization

MsgOptions.Font.Free;

end.
