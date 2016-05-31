object Form1: TForm1
  Left = 238
  Top = 128
  Width = 449
  Height = 143
  Caption = 'Classificação da Bacia pelo Critério de Otto Pfaffstetter'
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
    Left = 56
    Top = 88
    Width = 3
    Height = 13
  end
  object Label2: TLabel
    Left = 96
    Top = 64
    Width = 52
    Height = 13
    Caption = 'Nó da Foz:'
  end
  object Button1: TButton
    Left = 168
    Top = 16
    Width = 75
    Height = 25
    Caption = 'Executar'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 168
    Top = 56
    Width = 121
    Height = 21
    TabOrder = 1
  end
  object OpenDialog1: TOpenDialog
    Filter = 'Text Files|*.txt'
    Left = 16
    Top = 8
  end
end
