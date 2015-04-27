object SplineCoeffsIntervalForm: TSplineCoeffsIntervalForm
  Left = 0
  Top = 0
  Align = alClient
  BorderStyle = bsNone
  Caption = 'SplineCoeffsIntervalForm'
  ClientHeight = 455
  ClientWidth = 950
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  ExplicitWidth = 320
  ExplicitHeight = 240
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 15
    Top = 20
    Width = 7
    Height = 13
    Caption = 'N'
  end
  object Label2: TLabel
    Left = 16
    Top = 59
    Width = 6
    Height = 13
    Caption = 'x'
  end
  object Label3: TLabel
    Left = 13
    Top = 87
    Width = 18
    Height = 13
    Caption = 'f(x)'
  end
  object buttonResult: TButton
    Left = 16
    Top = 187
    Width = 75
    Height = 25
    Caption = 'Oblicz'
    TabOrder = 0
    OnClick = buttonResultClick
  end
  object StringGrid1: TStringGrid
    Left = 48
    Top = 56
    Width = 878
    Height = 73
    BevelWidth = 2
    BorderStyle = bsNone
    ColCount = 2
    FixedColor = clBackground
    RowCount = 2
    GradientEndColor = clLime
    GridLineWidth = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goEditing]
    TabOrder = 1
    OnSetEditText = StringGrid1SetEditText
    RowHeights = (
      24
      24)
  end
  object editN: TEdit
    Left = 48
    Top = 17
    Width = 64
    Height = 21
    TabOrder = 2
    Text = '1'
    OnChange = editNChange
  end
  object ErrorMemo: TMemo
    Left = 48
    Top = 148
    Width = 878
    Height = 21
    BorderStyle = bsNone
    TabOrder = 3
  end
  object StringGrid2: TStringGrid
    Left = 104
    Top = 187
    Width = 822
    Height = 246
    BorderStyle = bsNone
    ColCount = 1
    DefaultColWidth = 200
    FixedCols = 0
    RowCount = 1
    FixedRows = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine]
    TabOrder = 4
    RowHeights = (
      24)
  end
end
