object frmMain: TfrmMain
  Left = 427
  Top = 305
  BorderStyle = bsToolWindow
  Caption = 'UnitsAdder  -  tdsoft@libero.it'
  ClientHeight = 206
  ClientWidth = 327
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 4
    Top = 64
    Width = 317
    Height = 137
  end
  object Label1: TLabel
    Left = 8
    Top = 68
    Width = 77
    Height = 13
    Caption = 'Source directory'
  end
  object Label2: TLabel
    Left = 8
    Top = 110
    Width = 52
    Height = 13
    Caption = 'Unit to add'
  end
  object Label3: TLabel
    Left = 8
    Top = 154
    Width = 168
    Height = 13
    Caption = 'Add only if this unit already included'
  end
  object btnStart: TSpeedButton
    Left = 224
    Top = 167
    Width = 89
    Height = 23
    Caption = '&Start'
    Flat = True
    Glyph.Data = {
      06020000424D0602000000000000760000002800000028000000140000000100
      0400000000009001000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333333333FFFFFF33333333333330000003333333333333F888888FFF
      333333333009999990033333333338877777788FF33333330999999999903333
      3333877777777778FF333330999FFFFFF999033333387773333337778FF33309
      9FFFFFFFFFF9903333877F3FF33FF33778F333099F00FF00FFF9903333877388
      F388F33778FF3099FFF0FFF0FFFF99033877F3383F383333778F3099FFFF0F0F
      FFFF99033877F3F3838F3F33778F3099F0FF000F0FFF99033877F83F888F8333
      778F3099FF0F0000FFFF99033877F3838888F333778F3099FFF00000FFFF9903
      3877F33888883333778F3099FFFF000FFFFF99033877FF338883333377833309
      9FFFF0FFFFF9903333877F3338FF333778F333099FFF000FFFF9903333877FFF
      888333F778333330999FF0FFF99903333338777FF8FFF7778333333309999999
      9990333333338777777777783333333330099999900333333333388777777883
      3333333333300000033333333333333888888333333333333333333333333333
      33333333333333333333}
    NumGlyphs = 2
    OnClick = btnStartClick
  end
  object JvgWizardHeader1: TJvgWizardHeader
    Left = 0
    Top = 0
    Width = 327
    Height = 60
    CaptionFont.Charset = DEFAULT_CHARSET
    CaptionFont.Color = clWindowText
    CaptionFont.Height = -11
    CaptionFont.Name = 'MS Sans Serif'
    CaptionFont.Style = [fsBold]
    CommentFont.Charset = DEFAULT_CHARSET
    CommentFont.Color = clWindowText
    CommentFont.Height = -11
    CommentFont.Name = 'MS Sans Serif'
    CommentFont.Style = []
    SymbolFont.Charset = DEFAULT_CHARSET
    SymbolFont.Color = clHighlightText
    SymbolFont.Height = -35
    SymbolFont.Name = 'Wingdings'
    SymbolFont.Style = [fsBold]
    Captions.Strings = (
      'UnitsAdder')
    Comments.Strings = (
      'Pascal'#39's uses clause modifications...')
    Gradient.FromColor = clHighlight
    Gradient.ToColor = clWindow
    Gradient.Active = True
    Gradient.Orientation = fgdVertical
    BufferedDraw = False
  end
  object DirectoryEdit: TJvDirectoryEdit
    Left = 8
    Top = 84
    Width = 301
    Height = 21
    DialogKind = dkWin32
    TabOrder = 0
    Text = 'C:\Butta\unitaddertest'
  end
  object EditUnit: TEdit
    Left = 8
    Top = 126
    Width = 197
    Height = 21
    TabOrder = 1
    Text = 'MessDlgs'
  end
  object EditMust: TEdit
    Left = 8
    Top = 168
    Width = 197
    Height = 21
    TabOrder = 2
    Text = 'Dialogs'
  end
end
