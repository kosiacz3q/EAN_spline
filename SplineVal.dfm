object SplineValForm: TSplineValForm
  Left = 0
  Top = 0
  Align = alClient
  BorderStyle = bsNone
  Caption = 'SplineValForm'
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
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 15
    Top = 20
    Width = 15
    Height = 27
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
  object Label4: TLabel
    Left = 16
    Top = 149
    Width = 15
    Height = 13
    Caption = 'XX '
  end
  object buttonResult: TButton
    Left = 16
    Top = 403
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
  object ResultMemo: TMemo
    Left = 97
    Top = 403
    Width = 829
    Height = 25
    TabOrder = 3
  end
  object editXX: TEdit
    Left = 48
    Top = 146
    Width = 64
    Height = 21
    TabOrder = 4
    Text = '1'
    OnChange = editXXChange
  end
  object ErrorMemo: TMemo
    Left = 16
    Top = 308
    Width = 910
    Height = 89
    BorderStyle = bsNone
    TabOrder = 5
  end
end
