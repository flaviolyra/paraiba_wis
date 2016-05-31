unit ClassRio;

interface

uses
  Forms, Dialogs, StdCtrls, SysUtils, Controls, Classes;

type
  aptrecho = ^trecho;
  trecho = record
    ntrech      : integer;
    node        : integer;
    nopara      : integer;
    comp        : real;
    compacum    : real;
    area        : real;
    areaacum    : real;
    ptmont      : aptrecho;
    ptafl       : aptrecho;
    dirmnjs     : boolean;
    rioprafl    : boolean;
    codigo      : string[15]
  end;
  vetint = array[1..5000] of integer;
  vetreal = array[1..5000] of real;
  vetbool = array[1..5000] of boolean;
  vetapont = array[1..5000] of aptrecho;
  TForm1 = class(TForm)
    Button1: TButton;
    Label1: TLabel;
    OpenDialog1: TOpenDialog;
    Edit1: TEdit;
    Label2: TLabel;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  f: text;
  i, j, maxtrch, nofoz, apafld, nafld, apaflp, naflp, apfoz: integer;
  lsafllv: integer;
  abacia: real;
  erro: boolean;
  ntrech, node, nopara, nocld, noclp, apd, app, codigafl: vetint;
  incorp: vetbool;
  apontafl: vetapont;
  comp, area, areaafl: vetreal;
  apbacia: aptrecho;

implementation

{$R *.DFM}

procedure bsbn(chv,lb,ub: integer; var a:vetint; var apr,nel: integer);
var
  li, ls: integer;
begin
{se for o primeiro elemento apr = lb; se for menor não encontrou}
apr := lb;
if a[apr] >= chv then
  if a[apr] = chv then nel := 1
  else nel := 0
else
  {se for o ultimo elemento apr = ub; se for maior não encontrou}
  begin
  apr := ub;
  if a[apr] <= chv then
    if a[apr] = chv then nel := 1
    else nel := 0
  else
    {senão, procura sucessivamente no meio do intervalo}
    begin
    li := lb;
    ls := ub;
    apr := (li + ls) div 2;
    if a[apr] = chv then nel := 1 else nel := 0;
    while (nel = 0) and ((ls - li) > 1) do
      begin
      if a[apr] > chv then ls := apr else li:= apr;
      apr:= (li + ls) div 2;
      if a[apr] = chv then nel := 1
      end
    end
  end;
{se encontrou, procura o primeiro e determina o número de elementos}
if nel = 1 then
  begin
  while (apr > lb) and (a[apr -1] = chv) do apr := apr - 1;
  while a[apr + nel] = chv do nel := nel + 1
  end
end; {fim da procedure bsbn}

procedure clsf(lb, ub:integer; var a: vetint; var b: vetint);
{classificação shellsort para vetor de inteiros a}
var n, h, i, j, ta, tb: integer;
begin
{calcula o maior incremento h}
n := ub - lb + 1;
h := 1;
while h < n do h := 3 * h + 1;
h := h div 3;
h := h div 3;
{com intervalo h decrescente, faz as trocas}
while h > 0 do
  begin
  for i := lb + h to ub do
    begin
    ta := a[i];
    tb := b[i];
    j := i;
    {achando valores maiores para tras, no intervalo h, passa para frente}
    while ((j - h) >= lb) and (a[j - h] > ta) do
      begin
      a[j] := a[j - h];
      b[j] := b[j - h];
      j := j - h
      end;
    {insere t no buraco gerado}
    a[j] := ta;
    b[j] := tb;
    end;
  h := h div 3
  end
end; {fim da procedure clsf}

function geraarv(ap: integer; dir: boolean; compa: real): aptrecho;
var
  apaf, no, naf: integer;
  aparv, aparvm, apante : aptrecho;
  cmpa: real;
begin
if dir then no := node[ap] else no := nopara[ap];
incorp[ap] := true;
new(aparv);
aparv^.ntrech := ntrech[ap];
aparv^.node := node[ap];
aparv^.nopara := nopara[ap];
aparv^.comp := comp[ap];
aparv^.compacum := compa;
aparv^.area := area[ap];
aparv^.ptmont := nil;
aparv^.ptafl := nil;
aparv^.dirmnjs := dir;
aparv^.rioprafl := false;
aparv^.codigo := '';
apante := nil;
cmpa := compa + comp[ap];
{busca os afluentes em no pelo nó de}
bsbn(no,1,maxtrch,nocld,apaf,naf);
while naf > 0 do
  begin
  if apd[apaf] <> ap then
    begin
    aparvm := geraarv(apd[apaf], false, cmpa);
    if apante = nil then
      aparv^.ptmont := aparvm
    else
      apante^.ptafl := aparvm;
    apante := aparvm
    end;
  apaf := apaf + 1;
  naf := naf - 1
  end;
{busca os afluentes em no pelo nó para}
bsbn(no,1,maxtrch,noclp,apaf,naf);
while naf > 0 do
  begin
  if app[apaf] <> ap then
    begin
    aparvm := geraarv(app[apaf], true, cmpa);
    if apante = nil then
      aparv^.ptmont := aparvm
    else
      apante^.ptafl := aparvm;
    apante := aparvm
    end;
  apaf := apaf + 1;
  naf := naf - 1
  end;
geraarv := aparv
end; {fim da procedure geraarv}

function aacum(apb : aptrecho): real;
{calcula e registra no trecho a área a montante do trecho apontado por apb}
var
  apa : aptrecho;
  aac : real;
begin
aac := apb^.area;
apa := apb^.ptmont;
while apa <> nil do
  begin
  aac := aac + aacum(apa);
  apa := apa^.ptafl
  end;
apb^.areaacum := aac;
aacum := aac
end; {fim da função aacum}

procedure imptrch(apb : aptrecho);
{imprime os trechos da bacia a montante do trecho apontado por apb}
var
  apa : aptrecho;
  dir : integer;
begin
if apb^.dirmnjs then dir := 1 else dir := -1;
writeln(f,apb^.ntrech,',',apb^.codigo,',',dir,',',apb^.comp,','
         ,apb^.compacum,',',apb^.area,',',apb^.areaacum);
apa := apb^.ptmont;
while apa <> nil do
  begin
  imptrch(apa);
  apa := apa^.ptafl
  end;
end; {fim da função imptrch}

procedure imprio(apb : aptrecho);
{imprime rios e seus comprimentos a montante do trecho apontado por apb}
var
  cod : string[15];
  apa, apant, apaf : aptrecho;
  comp : real;
begin
cod := apb^.codigo;
apant := apb;
apa := apb^.ptmont;
while apa <> nil do
  begin
  if cod = apa^.codigo then
    begin
    if apa^.ptafl <> nil then
      begin
      apaf := apa^.ptafl;
      imprio(apaf)
      end
    end
  else
    begin
    imprio(apa);
    apa := apa^.ptafl
    end;
  apant := apa;
  apa := apa^.ptmont
  end;
comp := apant^.comp + apant^.compacum;
writeln(f,apant^.codigo,',',comp);
end; {fim da função imprio}

procedure imptopo(apb : aptrecho; ordem : integer; compbase: real);
{imprime a topologia a montante do trecho apontado por apb,
 com distâncias da foz a partir de compbase}
var
  cod : string[15];
  apa, apant, ap : aptrecho;
  ponto : real;
  ord : integer;
begin
cod := apb^.codigo;
apant := apb;
apa := apb^.ptmont;
while apa <> nil do
  begin
  if cod <> apa^.codigo then
    begin
    ponto := apa^.compacum - compbase;
    ord := ordem + 1;
    writeln(f,apa^.codigo,',',apant^.codigo,',',apant^.ntrech,',',
            ponto,',',ord);
    imptopo(apa, ord, apa^.compacum);
    apa := apa^.ptafl
    end
  else
    if apa^.ptafl <> nil then
      begin
      ap := apa^.ptafl;
      ponto := ap^.compacum - compbase;
      ord := ordem + 1;
      writeln(f,ap^.codigo,',',apant^.codigo,',',apant^.ntrech,',',
              ponto,',',ord);
      imptopo(ap, ord, ap^.compacum);
      end;
  apant := apa;
  apa := apa^.ptmont
  end
end; {fim da função imptopo}


procedure vernumaf(apb : aptrecho);
{se houver mais de um afluente no mesmo ponto
 na bacia a montante de apb faz erro = true}
var
  apa : aptrecho;
  i : integer;
begin
apa := apb^.ptmont;
i := 0;
while ((apa <> nil) and (not erro)) do
  begin
  if i > 1 then
    erro := true
  else
    vernumaf(apa);
  apa := apa^.ptafl;
  i := i + 1
  end;
end; {fim da procedure vernumaf}

procedure impafdup(apb : aptrecho);
{imprime a identificação de cada afluente adicional
 na bacia a montante do trecho apontado por apb}
var
  apa : aptrecho;
  i : integer;
begin
apa := apb^.ptmont;
i := 0;
while apa <> nil do
  begin
  if i > 1 then  writeln(f,apa^.ntrech,',',apa^.node,',',apa^.nopara);
  impafdup(apa);
  apa := apa^.ptafl;
  i := i + 1
  end;
end; {fim da função impafdup}


procedure identpr(apb : aptrecho);
{identifica o rio principal a montante do trecho apontado por apb}
var
  apm, apaf, appr : aptrecho;
  aac : real;
begin
apb^.rioprafl := true;
apm := apb^.ptmont;
while apm <> nil do
  begin
  aac := 0;
  apaf := apm;
  appr := apm;
  while apaf <> nil do
    begin
    if apaf^.areaacum > aac then
      begin
      appr := apaf;
      aac := apaf^.areaacum
      end;
    apaf := apaf^.ptafl
    end;
  appr^.rioprafl := true;
  apm := appr^.ptmont
  end
end; {fim da procedure identpr}

procedure geralsaf(apa: aptrecho; var lsafli, lsaflf: integer);
var
  apaf, apm, appr: aptrecho;
begin
{identifica o rio principal a montante do trecho apontado por apa}
identpr(apa);
{transfere os apontadores e as áreas dos afluentes
 para os vetores areaafl e apontafl}
lsafli := lsafllv;
lsaflf := lsafllv;
apm := apa^.ptmont;
while apm <> nil do
  begin
  apaf := apm;
  appr := apm;
  while apaf <> nil do
    begin
    if apaf^.rioprafl then
      appr := apaf
    else
      begin
      areaafl[lsaflf] := apaf^.areaacum;
      apontafl[lsaflf] := apaf;
      lsaflf := lsaflf + 1
      end;
    apaf := apaf^.ptafl
    end;
  apm := appr^.ptmont
  end;
lsafllv := lsaflf;
lsaflf := lsaflf - 1
end;  {fim da procedure geralsaf}

procedure numrlsaf(li, lf: integer);
var
  i, cod: integer;
  area, area1, area2, area3, area4: real;
begin
area1 := 0;
area2 := 0;
area3 := 0;
area4 := 0;
{identifica as quatro maiores áreas de afluente
 (ordem decrescente) em area1, area2, area3, area4}
for i := li to lf do
  begin
  area := areaafl[i];
  if area > area1 then
    begin
    area4 := area3;
    area3 := area2;
    area2 := area1;
    area1 := area
    end
  else
    if area > area2 then
      begin
      area4 := area3;
      area3 := area2;
      area2 := area
      end
    else
      if area > area3 then
        begin
        area4 := area3;
        area3 := area
        end
      else
        if area > area4 then area4 := area
  end;
{codifica os afluentes a partir de jusante}
cod := 1;
for i := li to lf do
  begin
  if areaafl[i] < area4 then
    codigafl[i] := cod
  else
    begin
    codigafl[i] := cod + 1;
    cod := cod + 2
    end
  end
end;   {fim da procedure numrlsaf}

procedure pintarv(apa: aptrecho; str: string);
{pinta a árvore cuja raiz é apontada por apa, acrescentando
 ao campo codigo o string str}
var
  apaf: aptrecho;
begin
apa^.codigo := apa^.codigo + str;
apaf := apa^.ptmont;
while apaf <> nil do
  begin
  pintarv(apaf, str);
  apaf := apaf^.ptafl
  end
end;   {fim da procedure pintarv}

procedure codifica(ap: aptrecho); forward;

procedure codif1(li, lf: integer);
{segunda parte da classificação da bacia}
var
  i, nli, nlf, cod: integer;
  str: string[1];
  par: boolean;
  apa: aptrecho;
begin
{numera de 1 a 9 a lista de afluentes que vai de li a lf}
numrlsaf(li,lf);
{pinta a sub-árvore de cada afluente acrescentando o código}
for i:= li to lf do
  begin
  apa := apontafl[i];
  str := chr(codigafl[i]+48);
  pintarv(apa, str)
  end;
{codifica mais um nível a bacia}
i := li;
while i <= lf do
  begin
  cod := codigafl[i];
  par := (((cod div 2) * 2) = cod);
  if par then
    codifica(apontafl[i])
  else
    begin
    nli := i;
    while (i < lf) and (codigafl[i + 1] = cod) do
      i := i + 1;
    nlf := i;
    codif1(nli, nlf)
    end;
  i := i + 1
  end;
end; {fim da procedure codif1}

procedure codifica;
{codifica toda a bacia}
var
  li, lf: integer;
begin
{identifica o rio principal}
identpr(ap);
{gera a lista de afluentes com seus limites inferior e superior li e lf}
geralsaf(ap,li,lf);
{termina a classificação}
codif1(li,lf)
end; {fim da procedure codifica}

procedure TForm1.Button1Click(Sender: TObject);
var i, j: integer;
begin
Label1.Caption := 'Executando...';
nofoz := StrtoInt(Edit1.Text);
erro := false;

{Fase 1 - Leitura do arquivo de trechos e classificação dos vetores de nós}

OpenDialog1.Title := 'Arquivo de Entrada';
OpenDialog1.InitialDir := GetCurrentDir;
if OpenDialog1.Execute then
  begin
  {le o arquivo de trechos e aloca nos vetores ntrech, node, nopara e area}
  assignfile(f, OpenDialog1.Files.Strings[0]);
  reset (f);
  i := 1;
  while not eof(f) do
    begin
    readln(f, ntrech[i], node[i], nopara[i], comp[i], area[i]);
    incorp[i] := false;
    i := i + 1
    end;
  maxtrch := i - 1;
  closefile(f);
  {gera os vetores de nós classificados nocld, noclp e ponteiros apd e app}
  for j := 1 to maxtrch do
    begin
    nocld[j] := node[j];
    noclp[j] := nopara[j];
    apd[j] := j;
    app[j] := j
    end;
  {classifica o vetor de nos de}
  clsf(1, maxtrch, nocld, apd);
  {classifica o vetor de nos para}
  clsf(1, maxtrch, noclp, app);
  {busca o trecho de foz, a partir do nó da foz}
  bsbn(nofoz,1,maxtrch,nocld,apafld,nafld);
  bsbn(nofoz,1,maxtrch,noclp,apaflp,naflp)
  end
else
  begin
  erro := true;
  Label1.Caption := 'Erro - Impossível abrir diálogo de arquivo de entrada'
  end;

{Fase 2 - Construção da árvore da rede hidrográfica com
          cálculo de distância à foz e verificação de erros}

if (not erro) then
  if (nafld + naflp) = 0 then
    begin
    erro := true;
    Label1.Caption := 'Erro - Não encontrado o nó da foz'
    end
  else
    If (nafld + naflp) > 1 then
      begin
      erro := true;
      Label1.Caption := 'Erro - Mais de um trecho na foz'
      end
    else
      begin
      if nafld > 0 then
        {nó da foz é nó de - determina a área acumulada a partir do nó para}
        begin
        apfoz := apd[apafld];
        apbacia := geraarv(apfoz, false, 0)
        end
      else
        {nó da foz é nó para - determina a área acumulada a partir do nó de}
        begin
        apfoz := app[apaflp];
        apbacia := geraarv(apfoz, true, 0)
        end;
      {verifica se não sobraram trechos ao final do processo}
      for i:= 1 to maxtrch do
        if (not incorp[i]) then erro := true;
      if erro then
        begin
        Label1.Caption := 'Erro - Árvore está desconexa';
        OpenDialog1.Title := 'Arquivo de Trechos Desconexos';
        OpenDialog1.InitialDir := GetCurrentDir;
        OpenDialog1.DefaultExt := 'txt';
        if OpenDialog1.Execute then
          begin
          {imprime os trechos desconexos}
          assignfile(f, OpenDialog1.Files.Strings[0]);
          rewrite(f);
          for i:= 1 to maxtrch do
            if (not incorp[i]) then
              writeln(f, ntrech[i],',',node[i],',',nopara[i]);
          closefile(f)
          end
        end
      else
        begin
        {verifica a ocorrência afluentes duplicados no mesmo nó}
        vernumaf(apbacia);
        if erro then
          begin
          Label1.Caption := 'Erro - Árvore tem afluentes duplicados';
          OpenDialog1.Title := 'Arquivo de Afluentes Duplicados';
          OpenDialog1.InitialDir := GetCurrentDir;
          OpenDialog1.DefaultExt := 'txt';
          if OpenDialog1.Execute then
            begin
            {imprime os trechos onde há afluente duplicado}
            assignfile(f, OpenDialog1.Files.Strings[0]);
            rewrite(f);
            impafdup(apbacia);
            closefile(f)
            end
          end
        end
      end;

{Fase 3 - Cálculo das áreas acumuladas dos trechos}

if (not erro) then
  {calcula a área acumulada da bacia}
  abacia := aacum(apbacia);

{Fase 4 - Codificação Otto Pfaffstetter da bacia e impressão dos trechos}

if (not erro) then
  begin
  {codifica a bacia}
  lsafllv:= 1;
  pintarv(apbacia,'R');
  codifica(apbacia);
  OpenDialog1.Title := 'Arquivo de Trechos';
  OpenDialog1.InitialDir := GetCurrentDir;
  OpenDialog1.DefaultExt := 'txt';

 if OpenDialog1.Execute then
    begin
    {imprime os trechos com áreas e comprimentos acumulados e código}
    assignfile(f, OpenDialog1.Files.Strings[0]);
    rewrite(f);
    imptrch(apbacia);
    closefile(f)
    end
  else
    begin
    erro := true;
    Label1.Caption := 'Erro - Impossível abrir diálogo de arquivo de trechos'
    end;
  end;

{Fase 5 - Imprime a tabela de rios}

if (not erro) then
  begin
  OpenDialog1.Title := 'Arquivo de Rios';
  OpenDialog1.InitialDir := GetCurrentDir;
  OpenDialog1.DefaultExt := 'txt';

 if OpenDialog1.Execute then
   begin
    {imprime os rios}
    assignfile(f, OpenDialog1.Files.Strings[0]);
    rewrite(f);
    imprio(apbacia);
    closefile(f)
    end
  else
    begin
    erro := true;
    Label1.Caption := 'Erro - Impossível abrir diálogo de arquivo de rios'
    end;
  Label1.Caption := 'Terminada a Execução'
  end;

{Fase 6 - Imprime a tabela de topologia}

if (not erro) then
  begin
  OpenDialog1.Title := 'Arquivo de Topologia';
  OpenDialog1.InitialDir := GetCurrentDir;
  OpenDialog1.DefaultExt := 'txt';

 if OpenDialog1.Execute then
   begin
    {imprime os rios}
    assignfile(f, OpenDialog1.Files.Strings[0]);
    rewrite(f);
    imptopo(apbacia, 1, 0);
    closefile(f)
    end
  else
    begin
    erro := true;
    Label1.Caption := 'Erro - Impossível abrir diálogo de arquivo de topologia'
    end;
  Label1.Caption := 'Terminada a Execução'
  end


end;
end.
