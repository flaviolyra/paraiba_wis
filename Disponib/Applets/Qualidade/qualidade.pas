unit qualidade;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, TeeProcs, TeEngine, Chart, DBChart, Mask, DBCtrls,
  ComCtrls, Buttons, Db, DBTables, Grids, DBGrids, DdeMan, Series,TeePrevi,
  DBEditCh,EditChar, TeeBoxPlot;




type
  TForm_Qualidade = class(TForm)
    Guia: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    GroupBox1: TGroupBox;
    Graf_Perfil: TDBChart;
    Cx_Codigo: TDBEdit;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    Label4: TLabel;
    Label5: TLabel;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    DBEdit7: TDBEdit;
    Label9: TLabel;
    DBEdit8: TDBEdit;
    Label10: TLabel;
    DBEdit9: TDBEdit;
    Label11: TLabel;
    DBEdit10: TDBEdit;
    Label12: TLabel;
    Label13: TLabel;
    BitBtn1: TBitBtn;
    Database1: TDatabase;
    Dados_Ponto: TQuery;
    Fonte_Dados_Ponto: TDataSource;
    ConsultaParametros: TQuery;
    Fonte_parametros: TDataSource;
    Rio: TQuery;
    Fonte_rio: TDataSource;
    DdeClientConv1: TDdeClientConv;
    Parametros: TComboBox;
    Perfil: TQuery;
    Fonte_Perfil: TDataSource;
    Dados_PontoCodigoArcView: TAutoIncField;
    Dados_PontoCodigo: TStringField;
    Dados_PontoCodigoOperador: TStringField;
    Dados_PontoOperador: TStringField;
    Dados_PontoRio: TStringField;
    Dados_PontoEstado: TStringField;
    Dados_PontoNome: TStringField;
    Dados_PontoLocalizacao: TStringField;
    Dados_PontoX: TIntegerField;
    Dados_PontoY: TIntegerField;
    Dados_PontoAltitudem: TFloatField;
    Dados_PontoOBS: TStringField;
    Dados_PontoEnquadramento: TStringField;
    RioNome: TStringField;
    RioNumero: TIntegerField;
    Series1: TLineSeries;
    Series2: TPointSeries;
    Series3: TPointSeries;
    PerfilCodigoArcView: TAutoIncField;
    PerfilCodigo: TStringField;
    PerfilParametro: TStringField;
    PerfilMdiaDeValor: TFloatField;
    PerfilDesvDeValor: TFloatField;
    PerfilMnDeValor: TFloatField;
    PerfilMxDeValor: TFloatField;
    PerfilTrecho: TIntegerField;
    PerfilRio: TIntegerField;
    PerfilPonto: TFloatField;
    PerfilValor_min: TFloatField;
    PerfilValor_max: TFloatField;
    SerieTemporal: TQuery;
    Fonte_SerieTemporal: TDataSource;
    GroupBox3: TGroupBox;
    Label16: TLabel;
    DBEdit11: TDBEdit;
    Label17: TLabel;
    DBEdit12: TDBEdit;
    PageControl1: TPageControl;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    GroupBox2: TGroupBox;
    Graf_SerieTemporal: TDBChart;
    Series5: TLineSeries;
    DBGrid1: TDBGrid;
    SerieTemporalData: TDateTimeField;
    SerieTemporalHora: TDateTimeField;
    SerieTemporalValor: TFloatField;
    SerieTemporalUnidade: TStringField;
    SerieTemporalQualificador: TStringField;
    SeriePadroesQualidade: TQuery;
    Fonte_SeriePadroesQualidade: TDataSource;
    Series6: TLineSeries;
    Series7: TLineSeries;
    titulo_grafico: TLabel;
    Trecho: TGroupBox;
    DefinirTrecho: TButton;
    Panel1: TPanel;
    Label14: TLabel;
    Panel2: TPanel;
    Label15: TLabel;
    Bevel1: TBevel;
    Label19: TLabel;
    Label20: TLabel;
    DBEdit14: TDBEdit;
    Panel3: TPanel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Bevel4: TBevel;
    Bevel5: TBevel;
    DBEdit16: TDBEdit;
    DBEdit17: TDBEdit;
    DBEdit18: TDBEdit;
    DBEdit19: TDBEdit;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Panel4: TPanel;
    Label25: TLabel;
    Bevel6: TBevel;
    Label27: TLabel;
    Label28: TLabel;
    DBEdit21: TDBEdit;
    Panel5: TPanel;
    Bevel7: TBevel;
    Bevel8: TBevel;
    Bevel9: TBevel;
    Bevel10: TBevel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    DBEdit23: TDBEdit;
    DBEdit24: TDBEdit;
    DBEdit25: TDBEdit;
    DBEdit26: TDBEdit;
    MedMinMax: TQuery;
    Fonte_MedMaxMin: TDataSource;
    MedMinMaxCodigo: TStringField;
    MedMinMaxParametro: TStringField;
    MedMinMaxMdiaDeValor: TFloatField;
    MedMinMaxDesvDeValor: TFloatField;
    MedMinMaxMnDeValor: TFloatField;
    MedMinMaxMxDeValor: TFloatField;
    DBEdit13: TDBEdit;
    DBEdit20: TDBEdit;
    DBEdit22: TDBEdit;
    Label26: TLabel;
    ViolacoesClasse_Percentuais: TQuery;
    Fonte_ViolacoesClasse_Percentuais: TDataSource;
    SeriePadroesQualidadeCodigo: TStringField;
    SeriePadroesQualidadeData: TDateTimeField;
    SeriePadroesQualidadeParametro: TStringField;
    SeriePadroesQualidadeValor_min: TFloatField;
    SeriePadroesQualidadeValor_Max: TFloatField;
    ConsultaParametrosParametro: TStringField;
    LimClasse: TQuery;
    Fonte_LimClasse: TDataSource;
    DBText1: TDBText;
    Label18: TLabel;
    LimClasseBanco: TStringField;
    LimClasseUnidade_banco: TStringField;
    LimClasseValor_min: TFloatField;
    LimClasseValor_max: TFloatField;
    DataBase: TTable;
    Fonte_DataBase: TDataSource;
    DataBaseInicio: TDateTimeField;
    DataBaseFim: TDateTimeField;
    Fonte_trechos: TDataSource;
    Trechos: TQuery;
    MedMinMax_trechos: TQuery;
    Fonte_MedMinMax_trechos: TDataSource;
    MedMinMax_trechosRotulo: TStringField;
    MedMinMax_trechosParametro: TStringField;
    MedMinMax_trechosMdiaDeMdiaDeValor: TFloatField;
    MedMinMax_trechosDesvDeMdiaDeValor: TFloatField;
    MedMinMax_trechosMnDeMnDeValor: TFloatField;
    MedMinMax_trechosMxDeMxDeValor: TFloatField;
    Lista_Trechos: TComboBox;
    Violacoes_Medias_trechos: TQuery;
    Fonte_Viol_Classe_Percentuais_Trecho: TDataSource;
    ViolacoesClasse_PercentuaisNumMedicoes: TIntegerField;
    ViolacoesClasse_PercentuaisInferior: TFloatField;
    ViolacoesClasse_PercentuaisSuperior: TFloatField;
    Violacoes_Medias_trechosNumMedicoes: TFloatField;
    Violacoes_Medias_trechosInferior: TFloatField;
    Violacoes_Medias_trechosDesvInferior: TFloatField;
    Violacoes_Medias_trechosSuperior: TFloatField;
    Violacoes_Medias_trechosDesvSuperior: TFloatField;
    Label1: TLabel;
    TrechosRotulo: TStringField;
    TrechosEstacoes: TStringField;
    Perfil_BoxPlot: TQuery;
    Fonte_Perfil_BoxPlot: TDataSource;
    Perfil_Cidades: TQuery;
    Fonte_Perfil_Cidades: TDataSource;
    Series8: TPointSeries;
    Series4: TLineSeries;
    procedure FormActivate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Graf_PerfilDblClick(Sender: TObject);
    procedure Graf_SerieTemporalDblClick(Sender: TObject);
   private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_Qualidade: TForm_Qualidade;
  Codigo:String;

implementation

{$R *.DFM}

procedure TForm_Qualidade.FormActivate(Sender: TObject);
var
  Cod:Pchar;
begin
  // estabelecimento de uma conversação DDE com o
  // ArcView sendo este o servidor e o Delphi, cliente
  // Nesta conversação o Delphi ativa no ArcView a Script
  // "RetEstQualidSel" que retorna a estação de qualidade
  // de água selecionada pelo usuário

     if DdeClientConv1.SetLink('ArcView','System') then
       Cod:=DDEClientConv1.RequestData('av.run("RetEstQualidSel",nil)');

     Codigo:=String(Cod);
     Codigo:=String(Pchar(Codigo));

     // Atribuição do codigo do ponto desejado às consultas que alimentam
     // os campos básicos do formulários que são aqueles localizados
     //no corpo do formulário mas fora das guias

     Dados_Ponto.Params[0].Value:=Codigo;
     Rio.Params[0].Value:=Codigo;
     ConsultaParametros.Params [0].Value:= Codigo;
     Trechos.Params [0].Value:= Codigo;

     // Execução das consultas que alimentam os campos básicos do formulários
     // que são aqueles todos que não dependem da seleção do parâmetro

     Rio.Open;
     Dados_Ponto.Open;
     ConsultaParametros.Open;
     DataBase.Open;
     Trechos.Open;
     //Perfil_BoxPlot.Open;
     

     //Preenchimento da ListBox com os parâmetros
     while not ConsultaParametros.EOF do
     begin
       Parametros.Items.Add(ConsultaParametros.Fields [0].AsString);
       ConsultaParametros.Next;
     end;

     //Preenchimento da ListBox com os trechos
        while not Trechos.EOF do
        begin
          Lista_trechos.Items.Add(Trechos.Fields [0].AsString);
          Trechos.Next;
        end;

     //Encerramento da conversação DDE
     DdeClientConv1.CloseLink;
end;


procedure TForm_Qualidade.BitBtn1Click(Sender: TObject);
begin
    //Fecha todas as tabelas e consultas abertas
       Perfil.Close;
       Perfil_Cidades.Close;
       SerieTemporal.close;
       SeriePadroesQualidade.close;
       MedMinMax.Close;
       ViolacoesClasse_Percentuais.Close;
       LimClasse.Close;
       DataBase.Close;
       Trechos.Close;
       MedMinMax_Trechos.Close;
       Violacoes_Medias_trechos.Close;


    //Geração do perfil de qualidade de água

        //Atribuição do parametro às consultas que geram o perfil
        Perfil.Params[0].Value:=Parametros.Items[Parametros.ItemIndex];
        Perfil_cidades.Params[1].Value:=Parametros.Items[Parametros.ItemIndex];

        //Atribuição do codigo do ponto selecionado
        // às consultas que geram o perfil
        Perfil_cidades.Params[0].Value:=Codigo;

        //Atribuição do rio às consultas que geram o perfil
        Perfil.Params[1].Value:=RioNumero.Value;

        //Abertura da consulta que gera o perfil
        Perfil.Open;
        Perfil_Cidades.Open;

    //Geração do grafico com a Serie Temporal de qualidade

        //Atribuição do codigo do ponto selecionado às consultas
        //que geram o grafico com a Serie Temporal de qualidade
        SerieTemporal.Params[0].Value:= Codigo;
        SeriePadroesQualidade.Params[0].Value:=Codigo;

        //Atribuição do parametro selecionado à consulta
        //que gera a serie temporal e que mostra o limite de classe
        SerieTemporal.Params[1].Value:=Parametros.Items[Parametros.ItemIndex];
        SeriePadroesQualidade.Params[1].Value:=Parametros.Items[Parametros.ItemIndex];

        //Atribuição do parametro selecionado so título do grafico
        Titulo_grafico.Caption:=Parametros.Items[Parametros.ItemIndex];

        //Abertura das consulta que geram o perfil
        SerieTemporal.Open;
        SeriePadroesQualidade.Open;

   //Geração das Estatísticas

        //Atribuição do codigo do ponto selecionado às consultas
        //que geram as Estatísticas
        MedMinMax.Params[0].Value:=Codigo;
        ViolacoesClasse_Percentuais.Params[0].Value:=Codigo;
        LimClasse.Params[0].Value:=Codigo;
        Trechos.Params[0].Value:=Codigo;

        //Atribuição do parametro selecionado às consultas
        //que geram as estatísticas
        MedMinMax.Params[1].Value:=Parametros.Items[Parametros.ItemIndex];
        ViolacoesClasse_Percentuais.Params[1].Value:=Parametros.Items[Parametros.ItemIndex];
        LimClasse.Params[1].Value:=Parametros.Items[Parametros.ItemIndex];
        MedMinMax_trechos.Params[1].Value:=Parametros.Items[Parametros.ItemIndex];
        Violacoes_Medias_trechos.Params[1].Value:=Parametros.Items[Parametros.ItemIndex];

        //Abertura das consultas que geram o perfil
        MedMinMax.Open;
        ViolacoesClasse_Percentuais.Open;
        LimClasse.Open;

        //Atribuição do trecho selecionado às respectivas consultas
        If Lista_trechos.ItemIndex=-1 THEN Lista_trechos.ItemIndex:=0;
        Violacoes_Medias_trechos.Params[0].Value:=Lista_trechos.Items[Lista_Trechos.ItemIndex];
        MedMinMax_trechos.Params[0].Value:=Lista_trechos.Items[Lista_Trechos.ItemIndex];

        //Abertura das consultas que geram as estatisticas para o trecho
        Violacoes_Medias_trechos.Open;
        MedMinMax_trechos.Open;
        Trechos.Open;

    //Consulta DataBase
      Database.Open;
end;


procedure TForm_Qualidade.Graf_PerfilDblClick(Sender: TObject);
begin
     EditChart(Self,Graf_Perfil);
end;

procedure TForm_Qualidade.Graf_SerieTemporalDblClick(Sender: TObject);
begin
     EditChart(Self,Graf_SerieTemporal);
end;

end.
