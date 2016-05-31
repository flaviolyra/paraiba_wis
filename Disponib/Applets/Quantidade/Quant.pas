unit Quant;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, StdCtrls, Buttons, ExtCtrls, TeEngine, Series, DBCtrls,
  TeeProcs, Chart, DBChart, Grids, DBGrids, DdeMan,
  DBEditCh,EditChar;
type
  TForm1 = class(TForm)
    DBGrid1: TDBGrid;
    Graf_SerieTemporal: TDBChart;
    Series1: TLineSeries;
    Panel1: TPanel;
    Database1: TDatabase;
    DdeClientConv1: TDdeClientConv;
    SelecionaTripaEstacaoDesejada: TQuery;
    Panel2: TPanel;
    Alto: TSpeedButton;
    Esquerda: TSpeedButton;
    Baixo: TSpeedButton;
    Direita: TSpeedButton;
    ZoomIn: TBitBtn;
    ZoomOut: TBitBtn;
    Volta: TButton;
    Label1: TLabel;
    DBText1: TDBText;
    DataSource1: TDataSource;
    SelecionaTripaEstacaoDesejadadia: TDateTimeField;
    SelecionaTripaEstacaoDesejadavazao: TFloatField;
    SelecionaTripaEstacaoDesejadaNome: TStringField;
    procedure FormActivate(Sender: TObject);
    procedure VoltaClick(Sender: TObject);
    procedure ZoomOutClick(Sender: TObject);
    procedure ZoomInClick(Sender: TObject);
    procedure BaixoClick(Sender: TObject);
    procedure AltoClick(Sender: TObject);
    procedure DireitaClick(Sender: TObject);
    procedure EsquerdaClick(Sender: TObject);
    procedure Graf_SerieTemporalDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    Procedure HorizScroll(Const Percent:Double);
    Procedure VertScroll(Const Percent:Double);
    Procedure ScrollAxis(Axis:TChartAxis; Const Percent:Double);{ Public declarations }

  end;

var
  Form1: TForm1;

implementation


{$R *.DFM}

procedure TForm1.FormActivate(Sender: TObject);
var
   Est:String;
   Estacao:Pchar;
begin
  // estabelecimento de uma conversação DDE com o
  // ArcView sendo este o servidor e o Delphi, cliente.
  // Nesta conversação o Delphi ativa no ArcView a Script
  // "RetEstFluSel" que retorna a estação fluviométrica
  // selecionada pelo usuário. O codigo da estacao é então
  // salvo como parametro da consulta SQL "SelecionaTripa
  // EstacaoDesejada"

     if DdeClientConv1.SetLink('ArcView','System') then
       Estacao:=DDEClientConv1.RequestData('av.run("RetEstFluSel",nil)');

     Est:=String(Estacao);
     Est:=String(Pchar(Est));

     SelecionaTripaEstacaoDesejada.Params [0].Value:= Est;
     SelecionaTripaEstacaoDesejada.Open;
     DdeClientConv1.CloseLink;
end;

Procedure TForm1.ScrollAxis(Axis:TChartAxis; Const Percent:Double);
var Amount:Double;
begin
  With Axis do
  begin
    Amount:=-((Maximum-Minimum)/(100.0/Percent));
    SetMinMax(Minimum-Amount,Maximum-Amount);
  end;
end;

Procedure Tform1.HorizScroll(Const Percent:Double);
begin
  ScrollAxis(Graf_SerieTemporal.TopAxis,Percent);
  ScrollAxis(Graf_SerieTemporal.BottomAxis,Percent);
  Volta.Enabled:=True;
end;

Procedure Tform1.VertScroll(Const Percent:Double);
begin
  ScrollAxis(Graf_SerieTemporal.LeftAxis,Percent);
  ScrollAxis(Graf_SerieTemporal.RightAxis,Percent);
  Volta.Enabled:=True;
end;
procedure TForm1.VoltaClick(Sender: TObject);
begin
  Graf_SerieTemporal.UndoZoom;
  Volta.Enabled:=False;
end;

procedure TForm1.ZoomOutClick(Sender: TObject);
begin
  Graf_SerieTemporal.ZoomPercent(80);
  Volta.Enabled:=True;
end;

procedure TForm1.ZoomInClick(Sender: TObject);
begin
  Graf_SerieTemporal.ZoomPercent(120);
  Volta.Enabled:=True;
end;

procedure TForm1.BaixoClick(Sender: TObject);
begin
    VertScroll(-10);
end;

procedure TForm1.AltoClick(Sender: TObject);
begin
   VertScroll(10);
end;

procedure TForm1.DireitaClick(Sender: TObject);
begin
   HorizScroll(10);
end;

procedure TForm1.EsquerdaClick(Sender: TObject);
begin
   HorizScroll(-10);
end;
procedure TForm1.Graf_SerieTemporalDblClick(Sender: TObject);
begin
  EditChart(Self,Graf_SerieTemporal);
end;

end.
