unit UsoSolo;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables, TeEngine, Series, ExtCtrls, TeeProcs, Chart, DBChart;

type
  TForm1 = class(TForm)
    Database1: TDatabase;
    UsoMontanteTrechoInteresse: TQuery;
    DataSource1: TDataSource;
    DBChart1: TDBChart;
    Series1: TPieSeries;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

end.
