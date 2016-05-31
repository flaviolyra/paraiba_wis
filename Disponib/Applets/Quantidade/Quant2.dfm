object Form2: TForm2
  Left = 296
  Top = 227
  BorderStyle = bsDialog
  Caption = 'Seleção do Período'
  ClientHeight = 126
  ClientWidth = 257
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 16
    Width = 50
    Height = 13
    Caption = 'Mês Inicial'
  end
  object Label2: TLabel
    Left = 128
    Top = 16
    Width = 49
    Height = 13
    Caption = 'Ano Inicial'
  end
  object Label3: TLabel
    Left = 8
    Top = 48
    Width = 45
    Height = 13
    Caption = 'Mês Final'
  end
  object Label4: TLabel
    Left = 136
    Top = 48
    Width = 44
    Height = 13
    Caption = 'Ano Final'
  end
  object MesInicial: TEdit
    Left = 64
    Top = 16
    Width = 41
    Height = 21
    TabOrder = 0
  end
  object AnoInicial: TEdit
    Left = 184
    Top = 16
    Width = 49
    Height = 21
    TabOrder = 1
  end
  object MesFinal: TEdit
    Left = 64
    Top = 48
    Width = 41
    Height = 21
    TabOrder = 2
  end
  object AnoFinal: TEdit
    Left = 184
    Top = 48
    Width = 49
    Height = 21
    TabOrder = 3
  end
  object Button1: TButton
    Left = 88
    Top = 88
    Width = 75
    Height = 25
    Caption = 'Visualizar'
    TabOrder = 4
    OnClick = Button1Click
  end
end
