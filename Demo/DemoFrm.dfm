object frmDemo: TfrmDemo
  Left = 319
  Top = 320
  Width = 284
  Height = 179
  Caption = 'Demo'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 12
    Top = 8
    Width = 250
    Height = 25
    Caption = 'Show Message'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 12
    Top = 40
    Width = 250
    Height = 25
    Caption = 'mtInformation + YesNoCancel'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 12
    Top = 72
    Width = 250
    Height = 25
    Caption = 'mtError + AbortRetryIgnore'
    TabOrder = 2
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 12
    Top = 104
    Width = 250
    Height = 25
    Caption = 'InputQuery'
    TabOrder = 3
    OnClick = Button4Click
  end
end
