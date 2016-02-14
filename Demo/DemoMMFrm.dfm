object frmDemoMM: TfrmDemoMM
  Left = 354
  Top = 300
  Width = 407
  Height = 346
  Caption = 'Demo Message Master'
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
  object Label1: TLabel
    Left = 138
    Top = 227
    Width = 99
    Height = 13
    Caption = 'Messages Language'
  end
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
  object GroupBox1: TGroupBox
    Left = 8
    Top = 136
    Width = 257
    Height = 81
    Caption = 'Add On'
    TabOrder = 4
    object BitBtn1: TBitBtn
      Left = 8
      Top = 25
      Width = 113
      Height = 25
      Caption = 'Show Status'
      TabOrder = 0
      OnClick = BitBtn1Click
    end
    object BitBtn2: TBitBtn
      Left = 134
      Top = 25
      Width = 113
      Height = 25
      Caption = 'Close Status'
      TabOrder = 1
      OnClick = BitBtn2Click
    end
    object ScrollBar1: TScrollBar
      Left = 8
      Top = 57
      Width = 239
      Height = 17
      PageSize = 0
      TabOrder = 2
      OnChange = ScrollBar1Change
    end
  end
  object RadioGroup1: TRadioGroup
    Left = 272
    Top = 8
    Width = 121
    Height = 177
    Caption = 'Some ColorScheme'
    ItemIndex = 0
    Items.Strings = (
      'Sky'
      'Sun'
      'Silver'
      'Grass'
      'Desert')
    TabOrder = 5
    OnClick = RadioGroup1Click
  end
  object Button5: TButton
    Left = 272
    Top = 192
    Width = 121
    Height = 25
    Caption = 'Random Color Scheme'
    TabOrder = 6
    OnClick = Button5Click
  end
  object ComboBox1: TComboBox
    Left = 240
    Top = 224
    Width = 153
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 7
    Text = 'Italian'
    OnChange = ComboBox1Change
    Items.Strings = (
      'Italian'
      'English'
      'German'
      'French'
      'Spanish')
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 248
    Width = 385
    Height = 58
    Caption = 'Options'
    TabOrder = 8
    object chkUseCustomPanel: TCheckBox
      Left = 8
      Top = 16
      Width = 121
      Height = 17
      Caption = 'UseCustomPanel'
      Checked = True
      State = cbChecked
      TabOrder = 0
      OnClick = chkUseCustomPanelClick
    end
    object chkUseCustomButtons: TCheckBox
      Left = 8
      Top = 32
      Width = 121
      Height = 17
      Caption = 'UseCustomButtons'
      Checked = True
      State = cbChecked
      TabOrder = 1
      OnClick = chkUseCustomButtonsClick
    end
    object chkUseGradient: TCheckBox
      Left = 152
      Top = 16
      Width = 97
      Height = 17
      Caption = 'UseGradient'
      Checked = True
      State = cbChecked
      TabOrder = 2
      OnClick = chkUseGradientClick
    end
    object chkUseShapedForm: TCheckBox
      Left = 152
      Top = 32
      Width = 97
      Height = 17
      Caption = 'UseShapedForm'
      Checked = True
      State = cbChecked
      TabOrder = 3
      OnClick = chkUseShapedFormClick
    end
    object chkUseBorder: TCheckBox
      Left = 264
      Top = 16
      Width = 97
      Height = 17
      Caption = 'UseBorder'
      TabOrder = 4
      OnClick = chkUseBorderClick
    end
  end
  object Button6: TButton
    Left = 8
    Top = 223
    Width = 97
    Height = 19
    Caption = 'Message Font'
    TabOrder = 9
    OnClick = Button6Click
  end
  object FontDialog1: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Left = 112
    Top = 216
  end
end
