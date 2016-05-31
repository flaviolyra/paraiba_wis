object Form1: TForm1
  Left = 237
  Top = 162
  Width = 407
  Height = 227
  Caption = 'Uso do Solo - Vers�o Access 97'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object DBChart1: TDBChart
    Left = 0
    Top = 0
    Width = 399
    Height = 200
    AllowPanning = pmNone
    BackWall.Brush.Color = clWhite
    BackWall.Brush.Style = bsClear
    BackWall.Pen.Visible = False
    Title.AdjustFrame = False
    Title.Alignment = taLeftJustify
    Title.Font.Charset = ANSI_CHARSET
    Title.Font.Color = clNavy
    Title.Font.Height = -13
    Title.Font.Name = 'Tahoma'
    Title.Font.Style = [fsBold]
    Title.Text.Strings = (
      'Uso do Solo na Bacia Contribuinte '
      '       ao Trecho de Interesse')
    AxisVisible = False
    ClipPoints = False
    Frame.Visible = False
    Legend.Color = clSilver
    Legend.Frame.Visible = False
    Legend.LegendStyle = lsValues
    Legend.ShadowSize = 0
    Legend.TextStyle = ltsRightPercent
    Legend.TopPos = 28
    View3DOptions.Elevation = 315
    View3DOptions.Orthogonal = False
    View3DOptions.Perspective = 0
    View3DOptions.Rotation = 360
    View3DWalls = False
    Zoom.Allow = False
    Align = alClient
    TabOrder = 0
    object Series1: TPieSeries
      Marks.ArrowLength = 8
      Marks.Visible = False
      DataSource = UsoMontanteTrechoInteresse
      SeriesColor = clRed
      XLabelsSource = 'Nome da Classe'
      Circled = True
      CustomXRadius = 80
      ExplodeBiggest = 25
      PieValues.DateTime = False
      PieValues.Name = 'Pie'
      PieValues.Order = loNone
      PieValues.ValueSource = '�rea'
      RotationAngle = 350
    end
  end
  object Database1: TDatabase
    AliasName = 'SADOut'
    Connected = True
    DatabaseName = 'SADout'
    LoginPrompt = False
    SessionName = 'Default'
    Left = 288
    Top = 8
  end
  object UsoMontanteTrechoInteresse: TQuery
    DatabaseName = 'SADout'
    SQL.Strings = (
      
        'SELECT [Uso do Solo a Montante].Nome, [Uso do Solo a Montante].[' +
        'Comprimento Acumulado], [Uso do Solo a Montante].[Nome da Classe' +
        '], [Uso do Solo a Montante].Percentual, [Uso do Solo a Montante]' +
        '.�rea'
      
        'FROM [Trecho de Interesse] INNER JOIN [Uso do Solo a Montante] O' +
        'N [Trecho de Interesse].Trecho = [Uso do Solo a Montante].Trecho'
      'ORDER BY [Uso do Solo a Montante].Percentual DESC;')
    Left = 320
    Top = 8
  end
  object DataSource1: TDataSource
    DataSet = UsoMontanteTrechoInteresse
    Left = 352
    Top = 8
  end
end
