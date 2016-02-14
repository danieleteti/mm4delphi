object Form1: TForm1
  Left = 467
  Top = 381
  BorderStyle = bsToolWindow
  Caption = 'Message Master Demo'
  ClientHeight = 105
  ClientWidth = 235
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
    Left = 32
    Top = 24
    Width = 177
    Height = 25
    Caption = 'Without Message Master'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 32
    Top = 56
    Width = 177
    Height = 25
    Caption = 'With Message MAster'
    TabOrder = 1
    OnClick = Button2Click
  end
end
