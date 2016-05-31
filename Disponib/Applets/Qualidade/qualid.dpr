program qualid;

uses
  Forms,
  qualidade in 'qualidade.pas' {Form_Qualidade};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm_Qualidade, Form_Qualidade);
  Application.Run;
end.
