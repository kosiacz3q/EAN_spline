object Form1: TForm1
  Left = 249
  Top = 145
  Caption = 'Interpolacja funkcjami sklejanymi trzeciego stopnia'
  ClientHeight = 538
  ClientWidth = 996
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
  object Button1: TButton
    Left = 89
    Top = 505
    Width = 75
    Height = 25
    Caption = 'val'
    TabOrder = 0
    OnClick = Button1Click
  end
  object ButtonSplineCoeffs: TButton
    Left = 8
    Top = 505
    Width = 75
    Height = 25
    Caption = 'coeffs'
    TabOrder = 1
    OnClick = ButtonSplineCoeffsClick
  end
  object Memo1: TMemo
    Left = 8
    Top = 8
    Width = 985
    Height = 491
    Lines.Strings = (
      'Memo1')
    TabOrder = 2
  end
  object ButtonIntervalValue: TButton
    Left = 170
    Top = 505
    Width = 145
    Height = 25
    Caption = 'ButtonIntervalValue'
    TabOrder = 3
    OnClick = ButtonIntervalValueClick
  end
  object ButtonIntervalCoeffs: TButton
    Left = 321
    Top = 505
    Width = 216
    Height = 25
    Caption = 'ButtonIntervalCoeffs'
    TabOrder = 4
    OnClick = ButtonIntervalCoeffsClick
  end
  object XPManifest1: TXPManifest
    Left = 816
    Top = 464
  end
end
