unit Quant2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type

  TForm2 = class(TForm)
    MesInicial: TEdit;
    AnoInicial: TEdit;
    MesFinal: TEdit;
    AnoFinal: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.DFM}
uses quant;

procedure TForm2.Button1Click(Sender: TObject);
begin
  Tform2.Close;
  Tform1.SelecionaPeriodoDesejado.Params [2].Value:= AnoInicial;
  Tform1.SelecionaPeriodoDesejado.Params [3].Value:= AnoFinal;
  Tform1.SelecionaPeriodoDesejado.Params [4].Value:= MesInicial;
  Tform1.SelecionaPeriodoDesejado.Params [5].Value:= MesFinal;
  Tform1.SelecionaPeriodoDesejado.Open;

end;



end.
