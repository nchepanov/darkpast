object Form3: TForm3
  Left = 108
  Top = 103
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1048#1089#1089#1083#1077#1076#1086#1074#1072#1085#1080#1103
  ClientHeight = 573
  ClientWidth = 792
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
  object Label1: TLabel
    Left = 492
    Top = 20
    Width = 15
    Height = 16
    Alignment = taCenter
    Caption = #1086#1090
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 556
    Top = 20
    Width = 16
    Height = 16
    Alignment = taCenter
    Caption = #1076#1086
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 621
    Top = 20
    Width = 50
    Height = 16
    Alignment = taCenter
    Caption = #1089' '#1096#1072#1075#1086#1084
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 92
    Top = 20
    Width = 388
    Height = 16
    Alignment = taCenter
    Caption = 
      #1048#1089#1089#1083#1077#1076#1086#1074#1072#1090#1100' '#1079#1072#1074#1080#1089#1080#1084#1086#1089#1090#1100' '#1086#1090'                                   '#1074' '#1087 +
      #1088#1086#1084#1077#1078#1091#1090#1082#1077
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Chart1: TChart
    Left = 0
    Top = 136
    Width = 792
    Height = 437
    AllowPanning = pmNone
    AllowZoom = False
    BackWall.Brush.Color = clWhite
    BackWall.Brush.Style = bsClear
    MarginBottom = 1
    MarginLeft = 1
    MarginRight = 1
    MarginTop = 0
    Title.Text.Strings = (
      #1047#1072#1074#1080#1089#1080#1084#1086#1089#1090#1100' '#1089#1088#1077#1076#1085#1077#1081' '#1089#1082#1086#1088#1086#1089#1090#1080)
    Chart3DPercent = 25
    LeftAxis.Automatic = False
    LeftAxis.AutomaticMinimum = False
    LeftAxis.Title.Caption = #1059#1076#1086#1074#1083#1077#1090#1074#1086#1088#1077#1085#1085#1086#1089#1090#1100' '#1089#1088#1077#1076#1085#1077#1081' '#1087#1091#1090#1077#1074#1086#1081' '#1089#1082#1086#1088#1086#1089#1090#1100#1102
    Legend.Alignment = laBottom
    Legend.ResizeChart = False
    Legend.ShadowSize = 1
    Legend.TextStyle = ltsPlain
    Legend.VertMargin = 20
    View3D = False
    View3DOptions.Elevation = 346
    View3DOptions.Rotation = 351
    Align = alBottom
    TabOrder = 0
    object Series1: TFastLineSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = clBlack
      Title = #1042#1089#1077
      LinePen.Width = 2
      XValues.DateTime = False
      XValues.Name = 'X'
      XValues.Multiplier = 1.000000000000000000
      XValues.Order = loAscending
      YValues.DateTime = False
      YValues.Name = 'Y'
      YValues.Multiplier = 1.000000000000000000
      YValues.Order = loNone
    end
    object Series2: TFastLineSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = clRed
      Title = #1040#1075#1088#1077#1089#1089#1080#1074#1085#1099#1077
      LinePen.Color = clRed
      LinePen.Style = psDashDotDot
      LinePen.Width = 2
      XValues.DateTime = False
      XValues.Name = 'X'
      XValues.Multiplier = 1.000000000000000000
      XValues.Order = loAscending
      YValues.DateTime = False
      YValues.Name = 'Y'
      YValues.Multiplier = 1.000000000000000000
      YValues.Order = loNone
    end
    object Series3: TFastLineSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = 11842740
      Title = #1057#1088#1077#1076#1085#1077#1089#1090#1072#1090#1080#1089#1090#1080#1095#1077#1089#1082#1080#1077
      LinePen.Color = 11842740
      LinePen.Width = 2
      XValues.DateTime = False
      XValues.Name = 'X'
      XValues.Multiplier = 1.000000000000000000
      XValues.Order = loAscending
      YValues.DateTime = False
      YValues.Name = 'Y'
      YValues.Multiplier = 1.000000000000000000
      YValues.Order = loNone
    end
    object Series4: TFastLineSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      SeriesColor = 55552
      Title = #1054#1089#1090#1086#1088#1086#1078#1085#1099#1077
      LinePen.Color = 55552
      LinePen.Width = 2
      XValues.DateTime = False
      XValues.Name = 'X'
      XValues.Multiplier = 1.000000000000000000
      XValues.Order = loAscending
      YValues.DateTime = False
      YValues.Name = 'Y'
      YValues.Multiplier = 1.000000000000000000
      YValues.Order = loNone
    end
  end
  object Button1: TButton
    Left = 0
    Top = 16
    Width = 81
    Height = 25
    Caption = #1053#1072#1095#1072#1090#1100
    TabOrder = 1
    OnClick = Button1Click
  end
  object ProgressBar1: TProgressBar
    Left = 0
    Top = 0
    Width = 792
    Height = 9
    Align = alTop
    TabOrder = 2
  end
  object ComboBox1: TComboBox
    Left = 290
    Top = 16
    Width = 95
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 2
    TabOrder = 3
    Text = #1087#1083#1086#1090#1085#1086#1089#1090#1080' '#1087#1086#1090#1086#1082#1072
    OnChange = ComboBox1Change
    Items.Strings = (
      #1095#1080#1089#1083#1072' '#1087#1086#1083#1086#1089
      #1076#1083#1080#1085#1099' '#1090#1088#1072#1089#1089#1099
      #1087#1083#1086#1090#1085#1086#1089#1090#1080' '#1087#1086#1090#1086#1082#1072
      #1082#1086#1101#1092#1092' '#1090#1088#1077#1085#1080#1103
      #1074#1088#1077#1084#1077#1085#1080' '#1088#1077#1072#1082#1094#1080#1080)
  end
  object Edit1: TEdit
    Left = 516
    Top = 16
    Width = 33
    Height = 21
    BiDiMode = bdLeftToRight
    ParentBiDiMode = False
    TabOrder = 4
    Text = '20'
    OnKeyPress = Edit1KeyPress
  end
  object Edit2: TEdit
    Left = 581
    Top = 16
    Width = 33
    Height = 21
    BiDiMode = bdLeftToRight
    ParentBiDiMode = False
    TabOrder = 5
    Text = '50'
    OnKeyPress = Edit1KeyPress
  end
  object Edit3: TEdit
    Left = 686
    Top = 16
    Width = 41
    Height = 21
    TabOrder = 6
    Text = '5'
    OnKeyPress = Edit1KeyPress
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 48
    Width = 729
    Height = 81
    Caption = #1053#1072#1095#1072#1083#1100#1085#1099#1077' '#1087#1072#1088#1072#1084#1077#1090#1088#1099
    TabOrder = 7
    object labelline: TLabel
      Left = 8
      Top = 24
      Width = 65
      Height = 13
      Caption = #1063#1080#1089#1083#1086' '#1087#1086#1083#1086#1089
    end
    object labelSS: TLabel
      Left = 8
      Top = 56
      Width = 87
      Height = 13
      Caption = #1044#1083#1080#1085#1072' '#1090#1088#1072#1089#1089#1099', '#1084
    end
    object labelro: TLabel
      Left = 172
      Top = 24
      Width = 196
      Height = 13
      Caption = #1055#1083#1086#1090#1085#1086#1089#1090#1100' '#1087#1086#1090#1086#1082#1072', '#1084#1072#1096#1080#1085'/('#1082#1084'*'#1087#1086#1083#1086#1089#1091')'
    end
    object Labelmu: TLabel
      Left = 172
      Top = 56
      Width = 166
      Height = 13
      Caption = #1050#1086#1101#1092#1092'. '#1090#1088#1077#1085#1080#1103' '#1087#1086#1082#1088#1099#1090#1080#1103' '#1076#1086#1088#1086#1075#1080
    end
    object labelTR: TLabel
      Left = 432
      Top = 24
      Width = 128
      Height = 13
      Caption = #1042#1088#1077#1084#1103' '#1088#1077#1072#1082#1094#1080#1080' '#1074#1086#1076#1080#1090#1077#1083#1103
    end
    object agr: TLabel
      Left = 432
      Top = 56
      Width = 159
      Height = 13
      Caption = #1057#1086#1086#1090#1085#1086#1096#1077#1085#1080#1077' '#1089#1090#1080#1083#1077#1081' '#1074#1086#1078#1076#1077#1085#1080#1103
    end
    object Label9: TLabel
      Left = 624
      Top = 56
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
      Left = 600
      Top = 40
      Width = 20
      Height = 13
      Caption = #1072#1075#1088'.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label11: TLabel
      Left = 632
      Top = 40
      Width = 29
      Height = 13
      Caption = #1085#1086#1088#1084'.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Label12: TLabel
      Left = 668
      Top = 40
      Width = 52
      Height = 13
      Caption = #1086#1089#1090#1086#1088#1086#1078#1085'.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object Shape1: TShape
      Left = 168
      Top = 6
      Width = 1
      Height = 73
    end
    object Shape2: TShape
      Left = 428
      Top = 6
      Width = 1
      Height = 73
    end
    object ss1: TEdit
      Left = 112
      Top = 48
      Width = 49
      Height = 21
      BevelInner = bvNone
      MaxLength = 4
      TabOrder = 0
      Text = '0'
      OnKeyPress = ss1KeyPress
    end
    object line1: TSpinEdit
      Left = 128
      Top = 19
      Width = 33
      Height = 22
      Ctl3D = True
      EditorEnabled = False
      MaxValue = 6
      MinValue = 1
      ParentCtl3D = False
      TabOrder = 1
      Value = 1
    end
    object ro1: TEdit
      Left = 380
      Top = 19
      Width = 41
      Height = 21
      BevelInner = bvNone
      MaxLength = 3
      TabOrder = 2
      Text = '0'
      OnKeyPress = ss1KeyPress
    end
    object mu1: TEdit
      Left = 380
      Top = 48
      Width = 41
      Height = 21
      BevelInner = bvNone
      MaxLength = 4
      TabOrder = 3
      Text = '0'
      OnKeyPress = mu1KeyPress
    end
    object tr1: TEdit
      Left = 600
      Top = 19
      Width = 73
      Height = 21
      BevelInner = bvNone
      MaxLength = 4
      TabOrder = 4
      Text = '0'
      OnKeyPress = mu1KeyPress
    end
    object a1: TEdit
      Left = 600
      Top = 56
      Width = 25
      Height = 21
      BevelInner = bvNone
      MaxLength = 2
      TabOrder = 5
      Text = '0'
      OnKeyPress = ss1KeyPress
    end
    object a2: TEdit
      Left = 640
      Top = 56
      Width = 25
      Height = 21
      BevelInner = bvNone
      MaxLength = 2
      TabOrder = 6
      Text = '0'
      OnKeyPress = ss1KeyPress
    end
    object a3: TEdit
      Left = 680
      Top = 56
      Width = 25
      Height = 21
      BevelInner = bvNone
      MaxLength = 2
      TabOrder = 7
      Text = '0'
      OnKeyPress = ss1KeyPress
    end
  end
  object Timer1: TTimer
    Interval = 5
    OnTimer = Timer1Timer
    Left = 752
    Top = 40
  end
end
