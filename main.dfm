object Form1: TForm1
  Left = 249
  Top = 145
  Caption = 'Interpolacja funkcjami sklejanymi trzeciego stopnia'
  ClientHeight = 538
  ClientWidth = 981
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
  object ButtonSplineCoeffs: TButton
    Left = 8
    Top = 505
    Width = 75
    Height = 25
    Caption = 'coeffs'
    TabOrder = 0
    OnClick = ButtonSplineCoeffsClick
  end
  object ButtonIntervalValue: TButton
    Left = 170
    Top = 505
    Width = 145
    Height = 25
    Caption = 'ButtonIntervalValue'
    TabOrder = 1
    OnClick = ButtonIntervalValueClick
  end
  object ButtonIntervalCoeffs: TButton
    Left = 321
    Top = 505
    Width = 216
    Height = 25
    Caption = 'ButtonIntervalCoeffs'
    TabOrder = 2
    OnClick = ButtonIntervalCoeffsClick
  end
  object TabControl1: TTabControl
    Left = 8
    Top = 8
    Width = 960
    Height = 466
    TabOrder = 3
    Tabs.Strings = (
      'warto'#347#263' funkcji sklejanej'
      'warto'#347#263' funkcji sklejanej (interwa'#322')'
      'wsp'#243#322'czynniki funkcji sklejanej'
      'wsp'#243#322'czynniki funkcji sklejanej (interwa'#322')')
    TabIndex = 0
    OnChange = TabControl1Change
  end
  object XPManifest1: TXPManifest
    Left = 840
    Top = 480
  end
end
