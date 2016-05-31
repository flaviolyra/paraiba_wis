program Quantidade;

uses
  Forms,
  Quant in 'Quant.pas' {Form1},
  SelecaoPeriodoCode in 'SelecaoPeriodoCode.pas' {SelecaoPeriodo};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TSelecaoPeriodo, SelecaoPeriodo);
  Application.Run;
end.
