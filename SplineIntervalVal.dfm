object SplineIntervalValForm: TSplineIntervalValForm
  Left = 0
  Top = 0
  Align = alClient
  BorderStyle = bsNone
  Caption = 'SplineIntervalValForm'
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
    Width = 7
    Height = 13
    Caption = 'N'
  end
  object Label2: TLabel
    Left = 15
    Top = 60
    Width = 14
    Height = 13
    Caption = 'X_l'
  end
  object Label3: TLabel
    Left = 10
    Top = 116
    Width = 26
    Height = 13
    Caption = 'f(x)_l'
  end
  object Label4: TLabel
    Left = 16
    Top = 205
    Width = 20
    Height = 13
    Caption = 'XX_l'
  end
  object Label5: TLabel
    Left = 15
    Top = 87
    Width = 18
    Height = 13
    Caption = 'X_p'
  end
  object Label6: TLabel
    Left = 11
    Top = 142
    Width = 30
    Height = 13
    Caption = 'f(x)_p'
  end
  object Label7: TLabel
    Left = 16
    Top = 233
    Width = 24
    Height = 13
    Caption = 'XX_p'
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
    Height = 121
    BevelWidth = 2
    BorderStyle = bsNone
    ColCount = 2
    FixedColor = clBackground
    RowCount = 4
    GradientEndColor = clLime
    GridLineWidth = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goEditing]
    TabOrder = 1
    OnSetEditText = StringGrid1SetEditText
    RowHeights = (
      24
      24
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
    Top = 202
    Width = 64
    Height = 21
    TabOrder = 4
    Text = '1'
    OnChange = editXXChange
  end
  object ErrorMemo: TMemo
    Left = 16
    Top = 308
    Width = 902
    Height = 89
    BorderStyle = bsNone
    TabOrder = 5
  end
  object editXX_l: TEdit
    Left = 46
    Top = 229
    Width = 64
    Height = 21
    TabOrder = 6
    Text = '1'
    OnChange = editXX_lChange
  end
end
