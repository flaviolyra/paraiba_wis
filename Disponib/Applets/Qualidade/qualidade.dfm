object Form_Qualidade: TForm_Qualidade
  Left = 244
  Top = 24
  Width = 543
  Height = 517
  Caption = 'Dados de Qualidade'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object Label3: TLabel
    Left = 8
    Top = 0
    Width = 33
    Height = 13
    Caption = 'Código'
  end
  object Label4: TLabel
    Left = 88
    Top = 0
    Width = 57
    Height = 13
    Caption = 'Localização'
  end
  object Label5: TLabel
    Left = 8
    Top = 40
    Width = 44
    Height = 13
    Caption = 'Operador'
  end
  object Label6: TLabel
    Left = 88
    Top = 40
    Width = 95
    Height = 13
    Caption = 'Codigo do Operador'
  end
  object Label7: TLabel
    Left = 200
    Top = 40
    Width = 90
    Height = 13
    Caption = 'Coordenadas UTM'
  end
  object Label8: TLabel
    Left = 200
    Top = 56
    Width = 8
    Height = 16
    Caption = 'X'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label9: TLabel
    Left = 272
    Top = 56
    Width = 9
    Height = 16
    Caption = 'Y'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label10: TLabel
    Left = 352
    Top = 40
    Width = 33
    Height = 13
    Caption = 'Estado'
  end
  object Label11: TLabel
    Left = 392
    Top = 40
    Width = 75
    Height = 13
    Caption = 'Enquadramento'
  end
  object Label12: TLabel
    Left = 8
    Top = 80
    Width = 16
    Height = 13
    Caption = 'Rio'
  end
  object Label13: TLabel
    Left = 224
    Top = 80
    Width = 48
    Height = 13
    Caption = 'Parâmetro'
  end
  object Guia: TPageControl
    Left = 0
    Top = 128
    Width = 529
    Height = 353
    ActivePage = TabSheet2
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Dados'
      object PageControl1: TPageControl
        Left = 0
        Top = 0
        Width = 521
        Height = 321
        ActivePage = TabSheet4
        TabOrder = 0
        object TabSheet4: TTabSheet
          Caption = 'Gráfico'
          object GroupBox2: TGroupBox
            Left = 8
            Top = 8
            Width = 497
            Height = 281
            Caption = 'Série Temporal dos dados de qualidade'
            TabOrder = 0
            object Graf_SerieTemporal: TDBChart
              Left = 8
              Top = 16
              Width = 473
              Height = 257
              Title.Text.Strings = (
                '')
              BottomAxis.Axis.Width = 1
              BottomAxis.Grid.Style = psSolid
              DepthAxis.Axis.Width = 1
              DepthAxis.Grid.Style = psSolid
              LeftAxis.Axis.Width = 1
              LeftAxis.Grid.Style = psSolid
              Legend.Alignment = laBottom
              Legend.Font.Height = -9
              Legend.Frame.Visible = False
              Legend.LegendStyle = lsSeries
              Legend.ShadowColor = clWhite
              RightAxis.Axis.Width = 1
              RightAxis.Grid.Style = psSolid
              TopAxis.Axis.Width = 1
              TopAxis.Grid.Style = psSolid
              View3D = False
              Zoom.Pen.Color = clBlack
              BevelOuter = bvNone
              Color = clWhite
              TabOrder = 0
              OnDblClick = Graf_SerieTemporalDblClick
              object titulo_grafico: TLabel
                Left = 200
                Top = 8
                Width = 73
                Height = 16
                Alignment = taCenter
                Caption = 'Parâmetro'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -13
                Font.Name = 'MS Sans Serif'
                Font.Style = [fsBold]
                ParentFont = False
              end
              object Series5: TLineSeries
                Marks.ArrowLength = 8
                Marks.Visible = False
                DataSource = SerieTemporal
                SeriesColor = clNavy
                Title = 'Medições'
                Pointer.HorizSize = 2
                Pointer.InflateMargins = True
                Pointer.Style = psRectangle
                Pointer.VertSize = 2
                Pointer.Visible = True
                XValues.DateTime = True
                XValues.Name = 'X'
                XValues.Order = loAscending
                XValues.ValueSource = 'Data'
                YValues.DateTime = False
                YValues.Name = 'Y'
                YValues.Order = loNone
                YValues.ValueSource = 'Valor'
              end
              object Series6: TLineSeries
                Marks.ArrowLength = 8
                Marks.Visible = False
                DataSource = SeriePadroesQualidade
                SeriesColor = clRed
                Title = 'Limite Superior'
                LinePen.Color = clRed
                LinePen.Width = 2
                Pointer.InflateMargins = True
                Pointer.Style = psRectangle
                Pointer.Visible = False
                XValues.DateTime = True
                XValues.Name = 'X'
                XValues.Order = loAscending
                XValues.ValueSource = 'Data'
                YValues.DateTime = False
                YValues.Name = 'Y'
                YValues.Order = loNone
                YValues.ValueSource = 'Valor_Max'
              end
              object Series7: TLineSeries
                Marks.ArrowLength = 8
                Marks.Visible = False
                DataSource = SeriePadroesQualidade
                SeriesColor = clRed
                Title = 'Limite Inferior'
                LinePen.Color = clRed
                LinePen.Width = 2
                Pointer.InflateMargins = True
                Pointer.Style = psRectangle
                Pointer.Visible = False
                XValues.DateTime = True
                XValues.Name = 'X'
                XValues.Order = loAscending
                XValues.ValueSource = 'Data'
                YValues.DateTime = False
                YValues.Name = 'Y'
                YValues.Order = loNone
                YValues.ValueSource = 'Valor_min'
              end
            end
          end
        end
        object TabSheet5: TTabSheet
          Caption = 'Tabela'
          ImageIndex = 1
          object DBGrid1: TDBGrid
            Left = 16
            Top = 8
            Width = 401
            Height = 281
            DataSource = Fonte_SerieTemporal
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            Columns = <
              item
                Alignment = taCenter
                Expanded = False
                FieldName = 'Data'
                Title.Alignment = taCenter
                Width = 50
                Visible = True
              end
              item
                Alignment = taCenter
                Expanded = False
                FieldName = 'Hora'
                Title.Alignment = taCenter
                Width = 50
                Visible = True
              end
              item
                Alignment = taCenter
                Expanded = False
                FieldName = 'Qualificador'
                Title.Alignment = taCenter
                Width = 62
                Visible = True
              end
              item
                Alignment = taCenter
                Expanded = False
                FieldName = 'Valor'
                Title.Alignment = taCenter
                Width = 150
                Visible = True
              end
              item
                Alignment = taCenter
                Expanded = False
                FieldName = 'Unidade'
                Title.Alignment = taCenter
                Width = 50
                Visible = True
              end>
          end
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Estatísticas'
      ImageIndex = 1
      object GroupBox3: TGroupBox
        Left = 8
        Top = 8
        Width = 217
        Height = 49
        Caption = 'Período'
        TabOrder = 0
        object Label16: TLabel
          Left = 8
          Top = 16
          Width = 33
          Height = 13
          Caption = 'Início :'
        end
        object Label17: TLabel
          Left = 118
          Top = 16
          Width = 22
          Height = 13
          Caption = 'Fim :'
        end
        object DBEdit11: TDBEdit
          Left = 48
          Top = 16
          Width = 60
          Height = 21
          Color = clScrollBar
          DataField = 'Inicio'
          DataSource = Fonte_DataBase
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
        object DBEdit12: TDBEdit
          Left = 144
          Top = 16
          Width = 60
          Height = 21
          Color = clScrollBar
          DataField = 'Fim'
          DataSource = Fonte_DataBase
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
        end
      end
      object Trecho: TGroupBox
        Left = 240
        Top = 8
        Width = 273
        Height = 49
        Caption = 'Trecho'
        TabOrder = 1
        object DefinirTrecho: TButton
          Left = 184
          Top = 16
          Width = 81
          Height = 25
          Caption = 'Definir Trecho'
          Enabled = False
          TabOrder = 0
        end
        object Lista_Trechos: TComboBox
          Left = 8
          Top = 16
          Width = 169
          Height = 21
          ItemHeight = 13
          TabOrder = 1
        end
      end
      object Panel1: TPanel
        Left = 8
        Top = 64
        Width = 505
        Height = 33
        TabOrder = 2
        object Label14: TLabel
          Left = 8
          Top = 8
          Width = 95
          Height = 20
          Caption = 'Estatísticas'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -16
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
      end
      object Panel2: TPanel
        Left = 8
        Top = 104
        Width = 245
        Height = 217
        BevelInner = bvLowered
        BevelOuter = bvLowered
        TabOrder = 3
        object Label15: TLabel
          Left = 88
          Top = 8
          Width = 65
          Height = 16
          Caption = 'No Ponto'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Bevel1: TBevel
          Left = 0
          Top = 0
          Width = 249
          Height = 33
        end
        object Label19: TLabel
          Left = 8
          Top = 80
          Width = 89
          Height = 13
          Caption = 'Núm. de Medições'
        end
        object Label20: TLabel
          Left = 8
          Top = 112
          Width = 91
          Height = 26
          Caption = 'Índice de Violação de Classe'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          WordWrap = True
        end
        object Label26: TLabel
          Left = 8
          Top = 48
          Width = 76
          Height = 13
          Caption = 'Limite de Classe'
        end
        object DBText1: TDBText
          Left = 176
          Top = 48
          Width = 65
          Height = 17
          DataField = 'Unidade_banco'
          DataSource = Fonte_LimClasse
        end
        object Label18: TLabel
          Left = 176
          Top = 120
          Width = 8
          Height = 13
          Caption = '%'
        end
        object DBEdit14: TDBEdit
          Left = 120
          Top = 80
          Width = 49
          Height = 21
          DataField = 'NumMedicoes'
          DataSource = Fonte_ViolacoesClasse_Percentuais
          TabOrder = 0
        end
        object Panel3: TPanel
          Left = 8
          Top = 152
          Width = 225
          Height = 57
          TabOrder = 1
          object Bevel2: TBevel
            Left = 0
            Top = 0
            Width = 57
            Height = 40
          end
          object Bevel3: TBevel
            Left = 56
            Top = 0
            Width = 57
            Height = 40
          end
          object Bevel4: TBevel
            Left = 112
            Top = 0
            Width = 57
            Height = 40
          end
          object Bevel5: TBevel
            Left = 168
            Top = 0
            Width = 57
            Height = 40
          end
          object Label21: TLabel
            Left = 8
            Top = 16
            Width = 35
            Height = 13
            Caption = 'Mínimo'
          end
          object Label22: TLabel
            Left = 64
            Top = 16
            Width = 29
            Height = 13
            Caption = 'Médio'
          end
          object Label23: TLabel
            Left = 120
            Top = 16
            Width = 36
            Height = 13
            Caption = 'Máximo'
          end
          object Label24: TLabel
            Left = 176
            Top = 16
            Width = 33
            Height = 13
            Caption = 'Desvio'
          end
          object DBEdit16: TDBEdit
            Left = 0
            Top = 39
            Width = 57
            Height = 21
            Anchors = []
            DataField = 'MínDeValor'
            DataSource = Fonte_MedMaxMin
            Enabled = False
            TabOrder = 0
          end
          object DBEdit17: TDBEdit
            Left = 56
            Top = 39
            Width = 57
            Height = 21
            Anchors = []
            DataField = 'MédiaDeValor'
            DataSource = Fonte_MedMaxMin
            TabOrder = 1
          end
          object DBEdit18: TDBEdit
            Left = 112
            Top = 39
            Width = 57
            Height = 21
            Anchors = []
            DataField = 'MáxDeValor'
            DataSource = Fonte_MedMaxMin
            TabOrder = 2
          end
          object DBEdit19: TDBEdit
            Left = 168
            Top = 39
            Width = 57
            Height = 21
            Anchors = []
            DataField = 'DesvDeValor'
            DataSource = Fonte_MedMaxMin
            TabOrder = 3
          end
        end
        object DBEdit13: TDBEdit
          Left = 120
          Top = 112
          Width = 49
          Height = 21
          DataField = 'Superior'
          DataSource = Fonte_ViolacoesClasse_Percentuais
          TabOrder = 2
        end
        object DBEdit22: TDBEdit
          Left = 120
          Top = 48
          Width = 49
          Height = 21
          DataField = 'Valor_Max'
          DataSource = Fonte_LimClasse
          TabOrder = 3
        end
      end
      object Panel4: TPanel
        Left = 264
        Top = 104
        Width = 245
        Height = 217
        BevelInner = bvLowered
        BevelOuter = bvLowered
        TabOrder = 4
        object Label25: TLabel
          Left = 48
          Top = 8
          Width = 166
          Height = 16
          Caption = 'No Trecho Selecionado'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Bevel6: TBevel
          Left = 0
          Top = 0
          Width = 249
          Height = 33
        end
        object Label27: TLabel
          Left = 8
          Top = 64
          Width = 89
          Height = 13
          Caption = 'Núm. de Medições'
        end
        object Label28: TLabel
          Left = 8
          Top = 88
          Width = 91
          Height = 26
          Caption = 'Índice de Violação de Classe'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          WordWrap = True
        end
        object Label1: TLabel
          Left = 177
          Top = 104
          Width = 8
          Height = 13
          Caption = '%'
        end
        object DBEdit21: TDBEdit
          Left = 120
          Top = 64
          Width = 49
          Height = 21
          DataField = 'NumMedicoes'
          DataSource = Fonte_Viol_Classe_Percentuais_Trecho
          TabOrder = 0
        end
        object Panel5: TPanel
          Left = 8
          Top = 152
          Width = 225
          Height = 57
          TabOrder = 1
          object Bevel7: TBevel
            Left = 0
            Top = 0
            Width = 57
            Height = 41
          end
          object Bevel8: TBevel
            Left = 56
            Top = 0
            Width = 57
            Height = 41
          end
          object Bevel9: TBevel
            Left = 112
            Top = 0
            Width = 57
            Height = 41
          end
          object Bevel10: TBevel
            Left = 168
            Top = 0
            Width = 57
            Height = 41
          end
          object Label29: TLabel
            Left = 8
            Top = 16
            Width = 35
            Height = 13
            Caption = 'Mínimo'
          end
          object Label30: TLabel
            Left = 72
            Top = 16
            Width = 29
            Height = 13
            Caption = 'Médio'
          end
          object Label31: TLabel
            Left = 120
            Top = 16
            Width = 36
            Height = 13
            Caption = 'Máximo'
          end
          object Label32: TLabel
            Left = 176
            Top = 16
            Width = 33
            Height = 13
            Caption = 'Desvio'
          end
          object DBEdit23: TDBEdit
            Left = 0
            Top = 40
            Width = 57
            Height = 21
            DataField = 'MínDeMínDeValor'
            DataSource = Fonte_MedMinMax_trechos
            TabOrder = 0
          end
          object DBEdit24: TDBEdit
            Left = 56
            Top = 40
            Width = 57
            Height = 21
            DataField = 'MédiaDeMédiaDeValor'
            DataSource = Fonte_MedMinMax_trechos
            TabOrder = 1
          end
          object DBEdit25: TDBEdit
            Left = 112
            Top = 40
            Width = 57
            Height = 21
            DataField = 'MáxDeMáxDeValor'
            DataSource = Fonte_MedMinMax_trechos
            TabOrder = 2
          end
          object DBEdit26: TDBEdit
            Left = 168
            Top = 40
            Width = 57
            Height = 21
            DataField = 'DesvDeMédiaDeValor'
            DataSource = Fonte_MedMinMax_trechos
            TabOrder = 3
          end
        end
        object DBEdit20: TDBEdit
          Left = 120
          Top = 96
          Width = 49
          Height = 21
          DataField = 'Superior'
          DataSource = Fonte_Viol_Classe_Percentuais_Trecho
          TabOrder = 2
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Perfil'
      ImageIndex = 2
      object GroupBox1: TGroupBox
        Left = 8
        Top = 16
        Width = 505
        Height = 305
        Caption = 'Perfil de Qualidade de Água'
        TabOrder = 0
        object Graf_Perfil: TDBChart
          Left = 8
          Top = 16
          Width = 489
          Height = 281
          BackWall.Brush.Color = clWhite
          BackWall.Brush.Style = bsClear
          BackWall.Color = clWhite
          PrintProportional = False
          Title.Text.Strings = (
            '')
          BottomAxis.Axis.Width = 1
          BottomAxis.ExactDateTime = False
          BottomAxis.Grid.Color = clBlack
          BottomAxis.Grid.Style = psSolid
          BottomAxis.Inverted = True
          DepthAxis.Axis.Width = 1
          DepthAxis.Grid.Style = psSolid
          LeftAxis.Axis.Width = 1
          LeftAxis.Grid.Style = psSolid
          Legend.Alignment = laBottom
          Legend.Frame.Visible = False
          Legend.ShadowColor = clWhite
          RightAxis.Axis.Width = 1
          RightAxis.Grid.Style = psSolid
          TopAxis.Axis.Width = 1
          TopAxis.Grid.Style = psSolid
          View3D = False
          View3DWalls = False
          Zoom.Animated = True
          Zoom.Pen.Color = clBlack
          BevelOuter = bvNone
          Color = clWhite
          TabOrder = 0
          OnDblClick = Graf_PerfilDblClick
          object Series1: TLineSeries
            Marks.ArrowLength = 0
            Marks.Visible = False
            DataSource = Perfil
            SeriesColor = clBlack
            Title = 'Média'
            LinePen.Visible = False
            Pointer.Brush.Color = 33023
            Pointer.HorizSize = 3
            Pointer.InflateMargins = True
            Pointer.Style = psCircle
            Pointer.VertSize = 3
            Pointer.Visible = True
            XValues.DateTime = False
            XValues.Name = 'X'
            XValues.Order = loAscending
            XValues.ValueSource = 'Ponto'
            YValues.DateTime = False
            YValues.Name = 'Y'
            YValues.Order = loNone
            YValues.ValueSource = 'MédiaDeValor'
          end
          object Series2: TPointSeries
            Marks.ArrowLength = 0
            Marks.Visible = False
            DataSource = Perfil
            SeriesColor = clGreen
            Title = 'Máximo'
            ClickableLine = False
            Pointer.Brush.Color = clBlue
            Pointer.HorizSize = 3
            Pointer.InflateMargins = True
            Pointer.Pen.Visible = False
            Pointer.Style = psDownTriangle
            Pointer.VertSize = 3
            Pointer.Visible = True
            XValues.DateTime = False
            XValues.Name = 'X'
            XValues.Order = loAscending
            XValues.ValueSource = 'Ponto'
            YValues.DateTime = False
            YValues.Name = 'Y'
            YValues.Order = loNone
            YValues.ValueSource = 'MáxDeValor'
          end
          object Series3: TPointSeries
            Marks.ArrowLength = 0
            Marks.Visible = False
            DataSource = Perfil
            SeriesColor = clYellow
            Title = 'Mínimo'
            ClickableLine = False
            Pointer.Brush.Color = clBlue
            Pointer.InflateMargins = False
            Pointer.Pen.Visible = False
            Pointer.Style = psTriangle
            Pointer.Visible = True
            XValues.DateTime = False
            XValues.Name = 'X'
            XValues.Order = loAscending
            XValues.ValueSource = 'Ponto'
            YValues.DateTime = False
            YValues.Name = 'Y'
            YValues.Order = loNone
            YValues.ValueSource = 'MínDeValor'
          end
          object Series8: TPointSeries
            Marks.ArrowLength = 0
            Marks.BackColor = clWhite
            Marks.Brush.Color = clWhite
            Marks.Brush.Style = bsClear
            Marks.Color = clWhite
            Marks.Frame.Visible = False
            Marks.Visible = False
            DataSource = Perfil_Cidades
            SeriesColor = clGray
            ShowInLegend = False
            Title = 'Cidades'
            XLabelsSource = 'Nome da Cidade'
            ClickableLine = False
            Pointer.InflateMargins = True
            Pointer.Style = psRectangle
            Pointer.Visible = False
            XValues.DateTime = False
            XValues.Name = 'X'
            XValues.Order = loAscending
            XValues.ValueSource = 'Ponto Médio'
            YValues.DateTime = False
            YValues.Name = 'Y'
            YValues.Order = loNone
            YValues.ValueSource = 'MínDeValor'
          end
          object Series4: TLineSeries
            Marks.ArrowLength = 8
            Marks.Visible = False
            DataSource = Perfil
            SeriesColor = clFuchsia
            Title = 'Enquadramento'
            LinePen.Color = clFuchsia
            LinePen.Width = 2
            Pointer.InflateMargins = True
            Pointer.Style = psRectangle
            Pointer.Visible = False
            Stairs = True
            XValues.DateTime = False
            XValues.Name = 'X'
            XValues.Order = loAscending
            XValues.ValueSource = 'Ponto'
            YValues.DateTime = False
            YValues.Name = 'Y'
            YValues.Order = loNone
            YValues.ValueSource = 'Valor_max'
          end
        end
      end
    end
  end
  object Cx_Codigo: TDBEdit
    Left = 8
    Top = 16
    Width = 73
    Height = 21
    Color = clScrollBar
    DataField = 'Codigo'
    DataSource = Fonte_Dados_Ponto
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMenuText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
  end
  object DBEdit3: TDBEdit
    Left = 88
    Top = 16
    Width = 425
    Height = 21
    Color = clScrollBar
    DataField = 'Localizacao'
    DataSource = Fonte_Dados_Ponto
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMenuText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
  end
  object DBEdit4: TDBEdit
    Left = 8
    Top = 56
    Width = 73
    Height = 21
    Color = clScrollBar
    DataField = 'Operador'
    DataSource = Fonte_Dados_Ponto
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMenuText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
  end
  object DBEdit5: TDBEdit
    Left = 88
    Top = 56
    Width = 105
    Height = 21
    Color = clScrollBar
    DataField = 'Codigo Operador'
    DataSource = Fonte_Dados_Ponto
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMenuText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
  end
  object DBEdit6: TDBEdit
    Left = 216
    Top = 56
    Width = 49
    Height = 21
    Color = clScrollBar
    DataField = 'X'
    DataSource = Fonte_Dados_Ponto
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMenuText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
  end
  object DBEdit7: TDBEdit
    Left = 288
    Top = 56
    Width = 57
    Height = 21
    Color = clScrollBar
    DataField = 'Y'
    DataSource = Fonte_Dados_Ponto
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMenuText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
  end
  object DBEdit8: TDBEdit
    Left = 352
    Top = 56
    Width = 33
    Height = 21
    Color = clScrollBar
    DataField = 'Estado'
    DataSource = Fonte_Dados_Ponto
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMenuText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 7
  end
  object DBEdit9: TDBEdit
    Left = 392
    Top = 56
    Width = 121
    Height = 21
    Color = clScrollBar
    DataField = 'Enquadramento'
    DataSource = Fonte_Dados_Ponto
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMenuText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 8
  end
  object DBEdit10: TDBEdit
    Left = 8
    Top = 96
    Width = 209
    Height = 21
    Color = clScrollBar
    DataField = 'Nome'
    DataSource = Fonte_rio
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMenuText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 9
  end
  object BitBtn1: TBitBtn
    Left = 408
    Top = 96
    Width = 105
    Height = 25
    Caption = 'Consulta Banco'
    TabOrder = 10
    OnClick = BitBtn1Click
  end
  object Parametros: TComboBox
    Left = 224
    Top = 96
    Width = 169
    Height = 21
    ItemHeight = 13
    TabOrder = 11
    Text = 'Parametros'
  end
  object Database1: TDatabase
    AliasName = 'BD_Qualidade'
    DatabaseName = 'BD_Qualidade'
    LoginPrompt = False
    SessionName = 'Default'
    Left = 180
    Top = 248
  end
  object Dados_Ponto: TQuery
    DatabaseName = 'BD_Qualidade'
    SQL.Strings = (
      'SELECT *'
      'FROM [Estacoes Qualidade]'
      'WHERE ((([Estacoes Qualidade].Codigo)=:codigo));')
    Left = 212
    Top = 216
    ParamData = <
      item
        DataType = ftString
        Name = 'codigo'
        ParamType = ptUnknown
        Value = 'prbs040'
      end>
    object Dados_PontoCodigoArcView: TAutoIncField
      FieldName = 'Codigo ArcView'
    end
    object Dados_PontoCodigo: TStringField
      FieldName = 'Codigo'
      Size = 50
    end
    object Dados_PontoCodigoOperador: TStringField
      FieldName = 'Codigo Operador'
      Size = 50
    end
    object Dados_PontoOperador: TStringField
      FieldName = 'Operador'
      Size = 50
    end
    object Dados_PontoRio: TStringField
      FieldName = 'Rio'
      Size = 255
    end
    object Dados_PontoEstado: TStringField
      FieldName = 'Estado'
      Size = 50
    end
    object Dados_PontoNome: TStringField
      FieldName = 'Nome'
      Size = 50
    end
    object Dados_PontoLocalizacao: TStringField
      FieldName = 'Localizacao'
      Size = 255
    end
    object Dados_PontoX: TIntegerField
      FieldName = 'X'
    end
    object Dados_PontoY: TIntegerField
      FieldName = 'Y'
    end
    object Dados_PontoAltitudem: TFloatField
      FieldName = 'Altitude (m)'
    end
    object Dados_PontoOBS: TStringField
      FieldName = 'OBS'
      Size = 255
    end
    object Dados_PontoEnquadramento: TStringField
      FieldName = 'Enquadramento'
      Size = 50
    end
  end
  object Fonte_Dados_Ponto: TDataSource
    DataSet = Dados_Ponto
    Left = 244
    Top = 216
  end
  object ConsultaParametros: TQuery
    DatabaseName = 'BD_Qualidade'
    SQL.Strings = (
      'SELECT [Estacoes X Parametros].Parametro'
      'FROM [Estacoes X Parametros]'
      'WHERE ([Estacoes X Parametros]![codigo]=:codigo)')
    Left = 276
    Top = 216
    ParamData = <
      item
        DataType = ftString
        Name = 'codigo'
        ParamType = ptUnknown
        Value = 'prbs040'
      end>
    object ConsultaParametrosParametro: TStringField
      FieldName = 'Parametro'
      Size = 255
    end
  end
  object Fonte_parametros: TDataSource
    DataSet = ConsultaParametros
    Left = 308
    Top = 216
  end
  object Rio: TQuery
    DatabaseName = 'BD_Qualidade'
    SQL.Strings = (
      'SELECT Rios.Nome, Rios.Numero'
      
        'FROM [Postos, Rios e Trechos] INNER JOIN Rios ON [Postos, Rios e' +
        ' Trechos].Rio = Rios.Numero'
      'WHERE ((([Postos, Rios e Trechos].Codigo)=:codigo));')
    Left = 212
    Top = 248
    ParamData = <
      item
        DataType = ftString
        Name = 'codigo'
        ParamType = ptUnknown
        Value = 'prbs040'
      end>
    object RioNome: TStringField
      FieldName = 'Nome'
      Size = 255
    end
    object RioNumero: TIntegerField
      FieldName = 'Numero'
    end
  end
  object Fonte_rio: TDataSource
    DataSet = Rio
    Left = 244
    Top = 248
  end
  object DdeClientConv1: TDdeClientConv
    Left = 180
    Top = 216
  end
  object Perfil: TQuery
    DatabaseName = 'BD_Qualidade'
    SQL.Strings = (
      
        'SELECT Perfil.[Codigo ArcView], Perfil.Codigo, Perfil.Parametro,' +
        ' Perfil.MédiaDeValor, Perfil.DesvDeValor, Perfil.MínDeValor, Per' +
        'fil.MáxDeValor, Perfil.Trecho, Perfil.Rio, Perfil.Ponto, Perfil.' +
        'Valor_min, Perfil.Valor_max'
      'FROM Perfil'
      'WHERE (((Perfil.Parametro)=:parametro) AND ((Perfil.Rio)=:rio));')
    Left = 340
    Top = 216
    ParamData = <
      item
        DataType = ftString
        Name = 'parametro'
        ParamType = ptUnknown
        Value = 'dbo'
      end
      item
        DataType = ftInteger
        Name = 'rio'
        ParamType = ptUnknown
        Value = '2313'
      end>
    object PerfilCodigoArcView: TAutoIncField
      FieldName = 'Codigo ArcView'
    end
    object PerfilCodigo: TStringField
      FieldName = 'Codigo'
      Size = 50
    end
    object PerfilParametro: TStringField
      FieldName = 'Parametro'
      Size = 255
    end
    object PerfilMdiaDeValor: TFloatField
      FieldName = 'MédiaDeValor'
    end
    object PerfilDesvDeValor: TFloatField
      FieldName = 'DesvDeValor'
    end
    object PerfilMnDeValor: TFloatField
      FieldName = 'MínDeValor'
    end
    object PerfilMxDeValor: TFloatField
      FieldName = 'MáxDeValor'
    end
    object PerfilTrecho: TIntegerField
      FieldName = 'Trecho'
    end
    object PerfilRio: TIntegerField
      FieldName = 'Rio'
    end
    object PerfilPonto: TFloatField
      FieldName = 'Ponto'
    end
    object PerfilValor_min: TFloatField
      FieldName = 'Valor_min'
    end
    object PerfilValor_max: TFloatField
      FieldName = 'Valor_max'
    end
  end
  object Fonte_Perfil: TDataSource
    DataSet = Perfil
    Left = 372
    Top = 216
  end
  object SerieTemporal: TQuery
    DatabaseName = 'BD_Qualidade'
    SQL.Strings = (
      
        'SELECT [Cargas Qualidade].Data, [Cargas Qualidade].Hora, [Cargas' +
        ' Qualidade].Valor, [Cargas Qualidade].Unidade, [Cargas Qualidade' +
        '].Qualificador'
      'FROM [Cargas Qualidade]'
      
        'WHERE [Cargas Qualidade]![Codigo]=:codigo And [Cargas Qualidade]' +
        '![Parametro]=:parametro '
      'ORDER BY [Cargas Qualidade].Data;')
    Left = 212
    Top = 280
    ParamData = <
      item
        DataType = ftString
        Name = 'codigo'
        ParamType = ptUnknown
        Value = 'prbs430'
      end
      item
        DataType = ftString
        Name = 'parametro'
        ParamType = ptUnknown
        Value = 'coliforme fecal'
      end>
    object SerieTemporalData: TDateTimeField
      DisplayWidth = 12
      FieldName = 'Data'
    end
    object SerieTemporalHora: TDateTimeField
      DisplayWidth = 11
      FieldName = 'Hora'
      DisplayFormat = 't'
    end
    object SerieTemporalQualificador: TStringField
      DisplayWidth = 12
      FieldName = 'Qualificador'
      Size = 255
    end
    object SerieTemporalValor: TFloatField
      DisplayWidth = 25
      FieldName = 'Valor'
      DisplayFormat = '0.#####'
    end
    object SerieTemporalUnidade: TStringField
      DisplayWidth = 8
      FieldName = 'Unidade'
      Size = 255
    end
  end
  object Fonte_SerieTemporal: TDataSource
    DataSet = SerieTemporal
    Left = 244
    Top = 280
  end
  object SeriePadroesQualidade: TQuery
    DatabaseName = 'BD_Qualidade'
    SQL.Strings = (
      
        'SELECT [Violacoes de Classe].Codigo, [Violacoes de Classe].Data,' +
        ' [Violacoes de Classe].Parametro, [Violacoes de Classe].Valor_mi' +
        'n, [Violacoes de Classe].Valor_Max'
      'FROM [Violacoes de Classe]'
      
        'WHERE ((([Violacoes de Classe].Codigo)=:codigo) AND (([Violacoes' +
        ' de Classe].Parametro)=:parametro));')
    Left = 272
    Top = 280
    ParamData = <
      item
        DataType = ftString
        Name = 'codigo'
        ParamType = ptUnknown
        Value = 'prbs430'
      end
      item
        DataType = ftString
        Name = 'parametro'
        ParamType = ptUnknown
        Value = 'dbo'
      end>
    object SeriePadroesQualidadeCodigo: TStringField
      FieldName = 'Codigo'
      Size = 50
    end
    object SeriePadroesQualidadeData: TDateTimeField
      FieldName = 'Data'
    end
    object SeriePadroesQualidadeParametro: TStringField
      FieldName = 'Parametro'
      Size = 255
    end
    object SeriePadroesQualidadeValor_min: TFloatField
      FieldName = 'Valor_min'
    end
    object SeriePadroesQualidadeValor_Max: TFloatField
      FieldName = 'Valor_Max'
    end
  end
  object Fonte_SeriePadroesQualidade: TDataSource
    DataSet = SeriePadroesQualidade
    Left = 304
    Top = 280
  end
  object MedMinMax: TQuery
    DatabaseName = 'BD_Qualidade'
    SQL.Strings = (
      
        'SELECT MedMinMax.Codigo, MedMinMax.Parametro, MedMinMax.MédiaDeV' +
        'alor, MedMinMax.DesvDeValor, MedMinMax.MínDeValor, MedMinMax.Máx' +
        'DeValor'
      'FROM MedMinMax'
      
        'WHERE (((MedMinMax.Codigo)=:codigo) AND ((MedMinMax.Parametro)=:' +
        'parametro));')
    Left = 212
    Top = 312
    ParamData = <
      item
        DataType = ftString
        Name = 'codigo'
        ParamType = ptUnknown
      end
      item
        DataType = ftString
        Name = 'parametro'
        ParamType = ptUnknown
      end>
    object MedMinMaxCodigo: TStringField
      FieldName = 'Codigo'
      Origin = 'BD_QUALIDADE.MedMinMax.Codigo'
      Size = 50
    end
    object MedMinMaxParametro: TStringField
      FieldName = 'Parametro'
      Origin = 'BD_QUALIDADE.MedMinMax.Parametro'
      Size = 255
    end
    object MedMinMaxMdiaDeValor: TFloatField
      FieldName = 'MédiaDeValor'
      Origin = 'BD_QUALIDADE.MedMinMax.MédiaDeValor'
      DisplayFormat = '0.####'
    end
    object MedMinMaxDesvDeValor: TFloatField
      FieldName = 'DesvDeValor'
      Origin = 'BD_QUALIDADE.MedMinMax.DesvDeValor'
      DisplayFormat = '0.####'
    end
    object MedMinMaxMnDeValor: TFloatField
      FieldName = 'MínDeValor'
      Origin = 'BD_QUALIDADE.MedMinMax.MínDeValor'
      DisplayFormat = '0.####'
    end
    object MedMinMaxMxDeValor: TFloatField
      FieldName = 'MáxDeValor'
      Origin = 'BD_QUALIDADE.MedMinMax.MáxDeValor'
      DisplayFormat = '0.####'
    end
  end
  object Fonte_MedMaxMin: TDataSource
    DataSet = MedMinMax
    Left = 244
    Top = 312
  end
  object ViolacoesClasse_Percentuais: TQuery
    DatabaseName = 'BD_Qualidade'
    SQL.Strings = (
      
        'SELECT [Violacoes de Classe_Percentuais].NumMedicoes, [Violacoes' +
        ' de Classe_Percentuais].Inferior, [Violacoes de Classe_Percentua' +
        'is].Superior'
      'FROM [Violacoes de Classe_Percentuais]'
      
        'WHERE ((([Violacoes de Classe_Percentuais].Codigo)=:codigo) AND ' +
        '(([Violacoes de Classe_Percentuais].Parametro)=:parametro));')
    Left = 276
    Top = 312
    ParamData = <
      item
        DataType = ftString
        Name = 'codigo'
        ParamType = ptUnknown
      end
      item
        DataType = ftString
        Name = 'parametro'
        ParamType = ptUnknown
      end>
    object ViolacoesClasse_PercentuaisNumMedicoes: TIntegerField
      FieldName = 'NumMedicoes'
    end
    object ViolacoesClasse_PercentuaisInferior: TFloatField
      FieldName = 'Inferior'
    end
    object ViolacoesClasse_PercentuaisSuperior: TFloatField
      FieldName = 'Superior'
      DisplayFormat = '0.##'
    end
  end
  object Fonte_ViolacoesClasse_Percentuais: TDataSource
    DataSet = ViolacoesClasse_Percentuais
    Left = 308
    Top = 312
  end
  object LimClasse: TQuery
    DatabaseName = 'BD_Qualidade'
    SQL.Strings = (
      
        'SELECT [Padroes de Qualidade Tripa].Banco, [Padroes de Qualidade' +
        ' Tripa].Unidade_banco, [Padroes de Qualidade Tripa].Valor_min, [' +
        'Padroes de Qualidade Tripa].Valor_max'
      
        'FROM [Estacoes Qualidade] INNER JOIN [Padroes de Qualidade Tripa' +
        '] ON [Estacoes Qualidade].Enquadramento = [Padroes de Qualidade ' +
        'Tripa].Classe'
      
        'WHERE ((([Estacoes Qualidade].Codigo)=:codigo) AND (([Padroes de' +
        ' Qualidade Tripa].Banco)=:parametro));')
    Left = 276
    Top = 344
    ParamData = <
      item
        DataType = ftString
        Name = 'codigo'
        ParamType = ptUnknown
        Value = 'prbs420'
      end
      item
        DataType = ftString
        Name = 'parametro'
        ParamType = ptUnknown
        Value = 'dbo'
      end>
    object LimClasseBanco: TStringField
      FieldName = 'Banco'
      Size = 255
    end
    object LimClasseUnidade_banco: TStringField
      FieldName = 'Unidade_banco'
      Size = 255
    end
    object LimClasseValor_min: TFloatField
      FieldName = 'Valor_min'
      DisplayFormat = '0.#####'
    end
    object LimClasseValor_max: TFloatField
      FieldName = 'Valor_max'
      DisplayFormat = '0.#####'
    end
  end
  object Fonte_LimClasse: TDataSource
    DataSet = LimClasse
    Left = 308
    Top = 344
  end
  object DataBase: TTable
    DatabaseName = 'BD_Qualidade'
    TableName = 'Data base'
    Left = 212
    Top = 344
    object DataBaseInicio: TDateTimeField
      FieldName = 'Inicio'
    end
    object DataBaseFim: TDateTimeField
      FieldName = 'Fim'
    end
  end
  object Fonte_DataBase: TDataSource
    DataSet = DataBase
    Left = 244
    Top = 344
  end
  object Fonte_trechos: TDataSource
    DataSet = Trechos
    Left = 308
    Top = 376
  end
  object Trechos: TQuery
    DatabaseName = 'BD_Qualidade'
    SQL.Strings = (
      
        'SELECT [Trechos Escolhidos].Rotulo, [Trechos Escolhidos].Estacoe' +
        's'
      'FROM [Trechos Escolhidos]'
      
        'GROUP BY [Trechos Escolhidos].Rotulo, [Trechos Escolhidos].Estac' +
        'oes'
      'HAVING ((([Trechos Escolhidos].Estacoes)=:codigo));')
    Left = 276
    Top = 376
    ParamData = <
      item
        DataType = ftString
        Name = 'codigo'
        ParamType = ptUnknown
      end>
    object TrechosRotulo: TStringField
      FieldName = 'Rotulo'
      Size = 50
    end
    object TrechosEstacoes: TStringField
      FieldName = 'Estacoes'
      Size = 50
    end
  end
  object MedMinMax_trechos: TQuery
    DatabaseName = 'BD_Qualidade'
    SQL.Strings = (
      
        'SELECT [MedMinMax por trechos].Rotulo, [MedMinMax por trechos].P' +
        'arametro, [MedMinMax por trechos].MédiaDeMédiaDeValor, [MedMinMa' +
        'x por trechos].DesvDeMédiaDeValor, [MedMinMax por trechos].MínDe' +
        'MínDeValor, [MedMinMax por trechos].MáxDeMáxDeValor'
      'FROM [MedMinMax por trechos]'
      
        'WHERE ((([MedMinMax por trechos].Rotulo)=:trecho) AND (([MedMinM' +
        'ax por trechos].Parametro)=:parametro));')
    Left = 276
    Top = 248
    ParamData = <
      item
        DataType = ftString
        Name = 'trecho'
        ParamType = ptUnknown
      end
      item
        DataType = ftString
        Name = 'parametro'
        ParamType = ptUnknown
      end>
    object MedMinMax_trechosRotulo: TStringField
      FieldName = 'Rotulo'
      Size = 50
    end
    object MedMinMax_trechosParametro: TStringField
      FieldName = 'Parametro'
      Size = 255
    end
    object MedMinMax_trechosMdiaDeMdiaDeValor: TFloatField
      FieldName = 'MédiaDeMédiaDeValor'
      DisplayFormat = '0.####'
    end
    object MedMinMax_trechosDesvDeMdiaDeValor: TFloatField
      FieldName = 'DesvDeMédiaDeValor'
      DisplayFormat = '0.####'
    end
    object MedMinMax_trechosMnDeMnDeValor: TFloatField
      FieldName = 'MínDeMínDeValor'
      DisplayFormat = '0.####'
    end
    object MedMinMax_trechosMxDeMxDeValor: TFloatField
      FieldName = 'MáxDeMáxDeValor'
      DisplayFormat = '0.####'
    end
  end
  object Fonte_MedMinMax_trechos: TDataSource
    DataSet = MedMinMax_trechos
    Left = 308
    Top = 248
  end
  object Violacoes_Medias_trechos: TQuery
    DatabaseName = 'BD_Qualidade'
    SQL.Strings = (
      
        'SELECT [Violacoes Medias por trechos].NumMedicoes, [Violacoes Me' +
        'dias por trechos].Inferior, [Violacoes Medias por trechos].[Desv' +
        ' Inferior], [Violacoes Medias por trechos].Superior, [Violacoes ' +
        'Medias por trechos].[Desv Superior]'
      'FROM [Violacoes Medias por trechos]'
      
        'WHERE ((([Violacoes Medias por trechos].Rotulo) =:trecho) AND ((' +
        '[Violacoes Medias por trechos].Parametro)=:parametro));')
    Left = 212
    Top = 376
    ParamData = <
      item
        DataType = ftString
        Name = 'trecho'
        ParamType = ptUnknown
      end
      item
        DataType = ftString
        Name = 'parametro'
        ParamType = ptUnknown
      end>
    object Violacoes_Medias_trechosNumMedicoes: TFloatField
      FieldName = 'NumMedicoes'
    end
    object Violacoes_Medias_trechosInferior: TFloatField
      FieldName = 'Inferior'
      DisplayFormat = '0.####'
    end
    object Violacoes_Medias_trechosDesvInferior: TFloatField
      FieldName = 'Desv Inferior'
      DisplayFormat = '0.####'
    end
    object Violacoes_Medias_trechosSuperior: TFloatField
      FieldName = 'Superior'
      DisplayFormat = '0.##'
    end
    object Violacoes_Medias_trechosDesvSuperior: TFloatField
      FieldName = 'Desv Superior'
      DisplayFormat = '0.####'
    end
  end
  object Fonte_Viol_Classe_Percentuais_Trecho: TDataSource
    DataSet = Violacoes_Medias_trechos
    Left = 244
    Top = 376
  end
  object Perfil_BoxPlot: TQuery
    DatabaseName = 'BD_Qualidade'
    SQL.Strings = (
      
        'SELECT [Cargas Qualidade].Codigo, [Cargas Qualidade].Data, [Carg' +
        'as Qualidade].Hora, [Cargas Qualidade].Num_amostra, [Cargas Qual' +
        'idade].Parametro, [Cargas Qualidade].Valor, [Cargas Qualidade].U' +
        'nidade, [Cargas Qualidade].Qualificador, [Cargas Qualidade].Obse' +
        'rvação'
      'FROM [Cargas Qualidade]'
      
        'WHERE ((([Cargas Qualidade].Codigo)=:codigo) AND (([Cargas Quali' +
        'dade].Parametro)=:parametro))'
      'ORDER BY [Cargas Qualidade].Valor;')
    Left = 340
    Top = 248
    ParamData = <
      item
        DataType = ftString
        Name = 'codigo'
        ParamType = ptUnknown
        Value = 'prbs420'
      end
      item
        DataType = ftString
        Name = 'parametro'
        ParamType = ptUnknown
        Value = 'dbo'
      end>
  end
  object Fonte_Perfil_BoxPlot: TDataSource
    DataSet = Perfil_BoxPlot
    Left = 372
    Top = 248
  end
  object Perfil_Cidades: TQuery
    DatabaseName = 'BD_Qualidade'
    SQL.Strings = (
      
        'SELECT [Distritos das Cidades].[Nome da Cidade], [Cidade e Maior' +
        ' Rio Principal].[Ponto Médio], MedMinMax.MínDeValor'
      
        'FROM [População das Cidades] INNER JOIN ((MedMinMax INNER JOIN [' +
        'Postos, Rios e Trechos] ON MedMinMax.Codigo = [Postos, Rios e Tr' +
        'echos].Codigo) INNER JOIN ([Distritos das Cidades] INNER JOIN [C' +
        'idade e Maior Rio Principal] ON [Distritos das Cidades].Cidade =' +
        ' [Cidade e Maior Rio Principal].[Número da Cidade]) ON [Postos, ' +
        'Rios e Trechos].Rio = [Cidade e Maior Rio Principal].[Numero do ' +
        'Rio]) ON [População das Cidades].Cidade = [Cidade e Maior Rio Pr' +
        'incipal].[Número da Cidade]'
      
        'WHERE ((([População das Cidades].PopPj00)>20000) AND ((MedMinMax' +
        '.Codigo)=:codigo) AND ((MedMinMax.Parametro)=:parametro))'
      'ORDER BY [Cidade e Maior Rio Principal].[Ponto Médio];')
    Left = 340
    Top = 280
    ParamData = <
      item
        DataType = ftString
        Name = 'codigo'
        ParamType = ptUnknown
        Value = 'prbs420'
      end
      item
        DataType = ftString
        Name = 'parametro'
        ParamType = ptUnknown
        Value = 'dbo'
      end>
  end
  object Fonte_Perfil_Cidades: TDataSource
    DataSet = Perfil_Cidades
    Left = 372
    Top = 280
  end
end
