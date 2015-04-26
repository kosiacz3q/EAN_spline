object SplineValForm: TSplineValForm
  Left = 0
  Top = 0
  Align = alClient
  BorderStyle = bsNone
  Caption = 'SplineValForm'
  ClientHeight = 434
  ClientWidth = 668
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 19
    Width = 21
    Height = 13
    Caption = 'N = '
  end
  object Button1: TButton
    Left = 32
    Top = 303
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 0
  end
  object StringGrid1: TStringGrid
    Left = 167
    Top = 8
    Width = 329
    Height = 65
    ColCount = 2
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goEditing]
    TabOrder = 1
    OnSetEditText = StringGrid1SetEditText
  end
  object editN: TEdit
    Left = 43
    Top = 16
    Width = 64
    Height = 21
    TabOrder = 2
    Text = '1'
    OnChange = editNChange
  end
  object DebugMemo: TMemo
    Left = 240
    Top = 160
    Width = 185
    Height = 89
    Lines.Strings = (
      'DebugMemo')
    TabOrder = 3
  end
end
