unit SelecaoPeriodoCode;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, 
  Buttons, ExtCtrls;

type
  TSelecaoPeriodo = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    MesInicial: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    AnoInicial: TEdit;
    Label3: TLabel;
    MesFinal: TEdit;
    Label4: TLabel;
    AnoFinal: TEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SelecaoPeriodo: TSelecaoPeriodo;

implementation

{$R *.DFM}

end.
