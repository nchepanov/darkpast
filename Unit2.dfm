object Form2: TForm2
  Left = 306
  Top = 273
  Width = 321
  Height = 258
  BorderStyle = bsSizeToolWin
  Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object labelline: TLabel
    Left = 16
    Top = 16
    Width = 65
    Height = 13
    Caption = #1063#1080#1089#1083#1086' '#1087#1086#1083#1086#1089
  end
  object labelSS: TLabel
    Left = 16
    Top = 40
    Width = 87
    Height = 13
    Caption = #1044#1083#1080#1085#1072' '#1090#1088#1072#1089#1089#1099', '#1084
  end
  object labelro: TLabel
    Left = 16
    Top = 64
    Width = 196
    Height = 13
    Caption = #1055#1083#1086#1090#1085#1086#1089#1090#1100' '#1087#1086#1090#1086#1082#1072', '#1084#1072#1096#1080#1085'/('#1082#1084'*'#1087#1086#1083#1086#1089#1091')'
  end
  object Labelmu: TLabel
    Left = 16
    Top = 96
    Width = 166
    Height = 13
    Caption = #1050#1086#1101#1092#1092'. '#1090#1088#1077#1085#1080#1103' '#1087#1086#1082#1088#1099#1090#1080#1103' '#1076#1086#1088#1086#1075#1080
  end
  object labelTR: TLabel
    Left = 16
    Top = 120
    Width = 128
    Height = 13
    Caption = #1042#1088#1077#1084#1103' '#1088#1077#1072#1082#1094#1080#1080' '#1074#1086#1076#1080#1090#1077#1083#1103
  end
  object agr: TLabel
    Left = 16
    Top = 160
    Width = 159
    Height = 13
    Caption = #1057#1086#1086#1090#1085#1086#1096#1077#1085#1080#1077' '#1089#1090#1080#1083#1077#1081' '#1074#1086#1078#1076#1077#1085#1080#1103
  end
  object Label9: TLabel
    Left = 216
    Top = 160
    Width = 51
    Height = 20
    Caption = ' :       :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label10: TLabel
    Left = 192
    Top = 144
    Width = 20
    Height = 13
    Caption = #1072#1075#1088'.'
  end
  object Label11: TLabel
    Left = 224
    Top = 144
    Width = 29
    Height = 13
    Caption = #1085#1086#1088#1084'.'
  end
  object Label12: TLabel
    Left = 260
    Top = 144
    Width = 52
    Height = 13
    Caption = #1086#1089#1090#1086#1088#1086#1078#1085'.'
  end
  object Button1: TButton
    Left = 8
    Top = 192
    Width = 201
    Height = 25
    Caption = #1048#1085#1080#1094#1080#1072#1083#1080#1079#1080#1088#1086#1074#1072#1090#1100' '#1085#1086#1074#1091#1102' '#1089#1080#1090#1091#1072#1094#1080#1102
    ModalResult = 1
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 232
    Top = 192
    Width = 75
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    ModalResult = 7
    TabOrder = 1
    OnClick = Button2Click
  end
  object ss1: TEdit
    Left = 232
    Top = 32
    Width = 73
    Height = 21
    BevelInner = bvNone
    MaxLength = 4
    TabOrder = 2
    Text = '0'
    OnKeyPress = ro1KeyPress
  end
  object line1: TSpinEdit
    Left = 272
    Top = 8
    Width = 33
    Height = 22
    Ctl3D = True
    EditorEnabled = False
    MaxValue = 6
    MinValue = 1
    ParentCtl3D = False
    TabOrder = 3
    Value = 1
    OnKeyPress = ss1KeyPress
  end
  object ro1: TEdit
    Left = 232
    Top = 56
    Width = 73
    Height = 21
    BevelInner = bvNone
    MaxLength = 4
    TabOrder = 4
    Text = '0'
    OnKeyPress = ro1KeyPress
  end
  object mu1: TEdit
    Left = 232
    Top = 88
    Width = 73
    Height = 21
    BevelInner = bvNone
    MaxLength = 4
    TabOrder = 5
    Text = '0'
    OnKeyPress = ss1KeyPress
  end
  object tr1: TEdit
    Left = 232
    Top = 112
    Width = 73
    Height = 21
    BevelInner = bvNone
    MaxLength = 4
    TabOrder = 6
    Text = '0'
    OnKeyPress = ss1KeyPress
  end
  object a1: TEdit
    Left = 192
    Top = 160
    Width = 25
    Height = 21
    BevelInner = bvNone
    MaxLength = 2
    TabOrder = 7
    Text = '0'
    OnKeyPress = ro1KeyPress
  end
  object a2: TEdit
    Left = 232
    Top = 160
    Width = 25
    Height = 21
    BevelInner = bvNone
    MaxLength = 2
    TabOrder = 8
    Text = '0'
    OnKeyPress = ro1KeyPress
  end
  object a3: TEdit
    Left = 272
    Top = 160
    Width = 25
    Height = 21
    BevelInner = bvNone
    MaxLength = 2
    TabOrder = 9
    Text = '0'
    OnKeyPress = ro1KeyPress
  end
end
