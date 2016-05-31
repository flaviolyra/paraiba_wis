;---------------------------------------------------------------------------------
;
;  GP -   Cruza hidrografia com altimetria para gerar perfis longitudinais de rios
;	  de acordo com as cotas das isolinhas
;
;         O programa le um arquivo gerado pelo comando UNGEN do Arcinfo, e
;         e dois arquivos .txt, que correspondem aos trechos e a topologia dos rios.
;
;         Atraves de rotina recursiva, o programa percorre cada rio, gerando uma
;	  lista com a cota e a distancia a partir da foz, de cada cruzamento do rio
;	  com uma isolinha.
;
;         O programa também verifica se isolinhas intermediarias estao faltando ou
;	  sobrando entre as isolinhas mestras. Caso estejam faltando isolinhas,
;         o programa cria isolinhas e coloca a informacao na lista de perfis
;	  (lstperfil) e na lista de pontos falsos (lstptsfalsos). Caso estejam
;	  sobrando isolinhas, o programa coloca a informacao na lista de pontos
;	  a mais (lstptsamais).
;	  As isolinhas a mais ou os locais onde as isolinhas estão faltando e foram
;	  inseridas artificialmente podem ser mostradas no desenho AutoCAD,
;	  se desejado.
;
;	  Ao final do processo é gravado um arquivo txt com os perfis, na forma:
;
;		Rio;Cota;PK
;		r1;z1;l1
;		r1;z2;l2
;		...
;		r2;z1;l1
;		...
;
;	  onde os r são os identificadores dos rios os z as cotas
;	  e os l as distâncias ao longo do rio, a partir da foz.
;
;         O programa utiliza as seguintes listas:
;
;         lrios ((rio poli dir) (rio poli dir)...) - GLOBAL
;
;         onde:
;         rio - identificador do rio (string)
;         poli - polilinha correspondente no AutoCAD (entidade AutoCAD)
;         dir - direcao (-1 de jusante a montante) (número)
;
;         ltopo ((rio (aflu pkfoz ordem)) ...) - GLOBAL
;
;         onde:
;
;         rio - identificador do rio (string)
;         aflu - identificador do rio onde desagua (string)
;         pkfoz - distancia da foz do rio a foz do afluente (número)
;
;         lstperfil ((rio (cota pk) (cota pk)...)...) - GLOBAL
;
;         onde:
;
;         rio - identificador do rio (string)
;         cota - cota da intersecao (número)
;         pk - distancia da foz a intersecao (número)
;
;         lstptsfalsos ((rio (cota pk) (cota pk)...)...) - GLOBAL
;         onde:
;
;         rio - identificador do rio (string)
;         cota - cota da intersecao (número)
;         pk - distancia da foz a intersecao (número)
;
;         lstptsamais ((rio (pk curva) (pk curva)...)...) - GLOBAL
;         onde:
;
;         rio - identificador do rio (string)
;         pk - distancia da foz a intersecao (número)
;         curva - polilinha do traço de curva de nível (entidade AutoCAD)
; 
;  Programadores: Marcelo de Carvalho - Flavio Lyra
;  Data Inicio: 01/09/99 Atualizado em: 03/05/01
;
;---------------------------------------------------------------------------------
(defun c:gp ( / nomearq nomearq2 nomearq3 nomearqp arq arq2 arq3 arqp
                  ltrrio lpoli ltrecho cota count)

  (slvctx)
  (setq ltopo nil lrios nil lstperfil nil
        lstptsfalsos nil lstptsamais nil
        nomearq (getfiled "Tabela de trechos" "." "txt" 2)
        nomearq2 (getfiled "Arquivo de polilinhas" "." "lin" 2)
        nomearq3 (getfiled "Topologia dos rios" "." "txt" 2)
        cota (getreal "\nCota da foz: ")
	intmedia (getreal "\nIntervalo entre curvas de nível: ")
	interv 5
	intmest (* intmedia interv)
  )
  (if (and nomearq nomearq2 nomearq3)
    (progn
      (princ "\nLendo arquivos...")
      (setq arq (open nomearq "r")
            arq2 (open nomearq2 "r")
            arq3 (open nomearq3 "r")
	    ; le arquivo de trechos, coloca em ltrrio
            ltrrio (letrch arq)
	    ; agrega pelo campo 1 (rio)
            ltrrio (arq_indexalista ltrrio 1)
	    ; le em uma lista o arquivo com as polilinhas
            lpoli (lesml arq2)
	    ; le arquivo de topologia
            ltopo (letopo arq3)
	    ; agrega pelo campo 1 (rio onde desagua)
            ltopo (arq_indexalista ltopo 1)
      )
      (close arq)
      (close arq2)
      (close arq3)
      ; desenha as polilinhas, criando em ltrecho lista ligando entidade a trecho
      (princ "\nDesenhando trechos dos rios...")
      (setq ltrecho (destrecho lpoli))
      ; faz um zoom no que foi desenhado
      (command "zoom" "e") 
      ; faz um pedit join dos trechos dos rios, gera lrios ligando rio a entidade
      (princ "\nJuntando trechos dos rios...")
      (setq lrios (juntatrecho ltrecho ltrrio))
      (princ "\nGerando o perfil dos rios...")
      (geraperfil cota (caadar ltopo))
    )
    (progn
      (alert "Um ou mais arquivos inválidos!")
      (exit)
    )
  )
  (if (or lstptsamais lstptsfalsos)
    (progn
      (initget 1 "s S n N")
      (princ "\nHá erros de curvas de nível.\n")
      (setq resp (getkword "Deseja que os erros sejam mostrados? (s/n): "))
      (if (= (strcase resp) "S")
	(progn
	  (if lstptsfalsos
	    (progn
	      (princ "\nDesenhando pontos falsos...")
	      (desptsfalsos)
	    )
	  )
	  (if lstptsamais
	    (progn
	      (princ "\nMarcando curvas a mais...")
	      (marcaptsamais)
	    )
	  )
	)
      )
    )
  )
  (princ "\nImprimindo perfis...")
  (setq nomearqp (getfiled "Arquivo de perfis" "." "txt" 1))
  (if nomearqp
    (progn
      (setq arqp (open nomearqp "w")
            count 0
      )
      (princ "Rio;Cota;PK\n" arqp)
      (repeat (length lstperfil)
	(setq perfil (nth count lstperfil)
	      rio (car perfil)
	      perfil (cadr perfil)
	      count (1+ count)
	)
	(while perfil
	  (setq pt (car perfil)
		cota (rtos (car pt) 2 2) pk (rtos (cadr pt) 2 2)
		perfil (cdr perfil)
	  )
	  (princ rio arqp)
	  (princ ";" arqp)
	  (princ cota arqp)
	  (princ ";" arqp)
	  (princ pk arqp)
	  (princ "\n" arqp)
	)
      )
      (close arqp)
    )
  )
  (rcpctx)
  (princ)
)
;---------------------------------------------------------------------------------
;
; letrch - le o arquivo de trechos e coloca em uma lista na forma
;	   ((trecho rio direc) (trecho rio direc) ...)
;	   onde rio e string e trecho e direc sao numeros.
;	   despreza a primeira linha do arquivo
;
;---------------------------------------------------------------------------------
(defun letrch (arq / lsttrch lintrch linha)

  (setq lsttrch nil)
  (if arq
    (progn
      (read-line arq)
      (while (setq linha (read-line arq))
        (setq linha (str_sepelems linha)
	      lintrch (list (read (car linha)) (cadr linha) (read (caddr linha)))
	      lsttrch (append lsttrch (list lintrch))
        )
      )
    )
  )
)
;---------------------------------------------------------------------------------
;
; lesml - le um arquivo arq gerado pelo UNGEN
;         do ARCINFO, no seguinte formato:
;
;       ind
;       x y
;       x y
;       ...
;       x y
;       END
;	ind
;	x y
;	...
;	END
;	...
;	END
;
;
;          retorna lista com seguinte formato
;
;       ((ind ((x y) (x y) (x y) ... (x y))
;        (ind ((x y) (x y) (x y) ... (x y)) ...))
;
;---------------------------------------------------------------------------------
(defun lesml (arq / larq lantarq indpoli ptspoli lpoli)

  (setq ptspoli nil lantarq ""
        larq (str_sepelems (read-line arq))
  )
  (while larq
    (cond
      ;
      ; no. polilinha (somente um elemento numero)
      ;
      ((and (distof (car larq) 2) (not (cdr larq)))
        (setq indpoli (read (car larq))
              ptspoli nil
              lantarq (car larq)
        )
      )
      ;
      ; pt. polilinha (dois elementos)
      ;
      ((cdr larq)
        (setq ptspoli (append ptspoli (list
                                        (list
                                          (distof (car larq) 2)
                                          (distof (cadr larq) 2)
                                        )
                                      )
                      )
              lantarq (car larq)
        )
      )
      ;
      ; fim da polilinha (um elemento texto)
      ;
      (T
        (if (/= lantarq (car larq))
          ;
          ; se repetir a linha "END" eh fim do arquivo
          ; nao acrescenta novamente o ultimo elemento
          ;
          (setq lpoli (append lpoli (list (list indpoli ptspoli)))
                lantarq (car larq)
          )
        )
      )
    )
    (setq larq (str_sepelems (read-line arq)))
  )
  lpoli
)
;---------------------------------------------------------------------------------
;
; letopo - le o arquivo de topologia e coloca em uma lista na forma
;	   ((rio riodesag ponto) (rio riodesag ponto) ...)
;	   onde rio e riodesag são strings e ponto é um numero.
;	   despreza a primeira linha do arquivo
;
;---------------------------------------------------------------------------------
(defun letopo (arq / lsttopo lintopo linha)

  (setq lsttopo nil)
  (if arq
    (progn
      (read-line arq)
      (while (setq linha (read-line arq))
        (setq linha (str_sepelems linha)
	      lintopo (list (car linha) (cadr linha) (read (cadddr linha)))
	      lsttopo (append lsttopo (list lintopo))
        )
      )
    )
  )
)
;--------------------------------------------------------------------------------
;
; arq_indexalista - indexa lista pelo elemento elem
;                   elem e um numero inteiro que indica
;                   a posicao do elemento chave nas sublistas
;                   da lista a ser indexada, comecando por 0
;
;		    pega uma lista original na forma
;		    ((x0 x1...xi...xn) (x0 x1...xi...xn)...)
;		    e agrega pelo campo na posição i dada por indice,
;		    gerando uma nova lista na forma
;		    ( (xi (x0..xi-1 xi+1..xn)...) (xi (x0..xi-1 xi+1..xn)..)..)
;---------------------------------------------------------------------------------
(defun arq_indexalista (lista indice / nlista nsublista chave slista)

  ; criaindice - gera a partir de lista uma nova lista onde o item cuja posiçao
  ; é dada por indice é colocado na cabeça, outros itens reteem a ordem original.

  (defun criaindice (lista indice / chave nlista sublista count)
    (setq chave (nth indice lista)
          nlista (list chave)
          sublista nil
          count 0
    )
    (repeat (length lista)
      (if (/= indice count)
        (setq sublista (append sublista (list (nth count lista))))
      )
      (setq count (1+ count))
    )
    (append nlista (list sublista))
  )

  (setq nlista nil)
  (while lista
    (setq sublista (car lista)
          chave (nth indice sublista)
          sublista (criaindice sublista indice)     
          lista (cdr lista)
    )
    (if (setq nsublista (assoc chave nlista))
      (setq slista (cdr sublista)
            sublista nsublista
            nsublista (append nsublista slista)
            nlista (subst nsublista sublista nlista)
      )
      (setq nlista (append nlista (list sublista)))
    )
  )
  nlista
)
;---------------------------------------------------------------------------------
;
; destrecho - desenha no AutoCAD os trechos de polilinhas
;             cujos indicadores e listas de pontos são dados por lpoli
;	      e retorna lista com o identificador da polilinha a entidade AutoCAD
;	      correspondente
;
;---------------------------------------------------------------------------------
(defun destrecho (lpoli / ltrecho indpoli ptspoli p1 p2)

  (setq ltrecho nil)
  (while lpoli
    (setq poli (car lpoli)
          indpoli (car poli)
          ptspoli (cadr poli)
          p1 (car ptspoli)
          ptspoli (cdr ptspoli)
          lpoli (cdr lpoli)
    )
    (command "pline" p1)
    (while ptspoli
      (setq p2 (car ptspoli)
            ptspoli (cdr ptspoli)
      )
      (command p2)
    )
    (command "")
    (setq ltrecho (cons (list indpoli (entlast)) ltrecho))
  )
  ltrecho
)
;---------------------------------------------------------------------------------
;
; juntatrecho - junta polilinhas de trechos de rios de modo a formar rios.
;               em ltrecho esta a lista que associa os números dos trechos às
;		entidades AutoCAD que representam os trechos.
;		em ltrrio está a lista que associa a cada rio a lista de
;		identificadores dos trechos que o compõem com sua direção.
;               retorna lista no seguinte formato:
;               ((indrio nomepoli dir) ...)
;               onde indrio eh o numero do rio
;               na tabela, nomepoli eh a entidade
;               no AutoCAD e dir é a direção do
;               rio: positivo de montante a jusante
;
;
;---------------------------------------------------------------------------------
(defun juntatrecho (ltrecho ltrrio / rio indrio trechos selset trecho
                                   indtrecho idpoli dirtrecho lr)

  (setq lr nil)
  (while ltrrio
    (setq rio (car ltrrio)
          indrio (car rio)
          trechos (cdr rio)
          ltrrio (cdr ltrrio)
          selset (ssadd)
    )
    (while trechos
      (setq trecho (car trechos)
            indtrecho (car trecho)
            dirtrecho (cadr trecho)
            trechos (cdr trechos)
            idpoli (cadr (assoc indtrecho ltrecho))
      )
      (ssadd idpoli selset)
    )
    (command "pedit" idpoli "j" selset "" "")
    (setq lr (cons (list indrio idpoli dirtrecho) lr))
  )
  lr
)
;---------------------------------------------------------------------------------
;
; geraperfil - gera os perfis de todos os rios a montante de rio,
;              cuja cota inicial é cota
;	       Os perfis sao gerados na lista global lstperfil
;	       Os eventuais erros de cotas intermediárias a mais ou a menos
;	       estarao nas listas globais lstptsamais e lstptsfalsos
;
;---------------------------------------------------------------------------------
(defun geraperfil (cota rio / perfil afluentes rioaflupt rioaflu ptaflu cotaflu)

    (setq perfil (achaperfil cota rio)
          lstperfil (append lstperfil (list perfil))
          afluentes (cdr (assoc rio ltopo))
    )
    (while afluentes
	(setq rioaflupt (car afluentes)
	      rioaflu (car rioaflupt)
	      ptaflu (cadr rioaflupt)
	      afluentes (cdr afluentes)
	      cotaflu (interpcota perfil ptaflu)
	)
	(geraperfil cotaflu rioaflu)
    )
)

;---------------------------------------------------------------------------------
;
; achaperfil - determina o perfil do rio cuja entidade AutoCAD esta em rio
;	       e cuja cota inicial é cota, devolvendo o perfil como uma lista
;	       na forma (rio (cota pk) (cota pk)...)
;
;---------------------------------------------------------------------------------
(defun achaperfil (cota rio / lprio indinterm selset count
                              curva layercurva intersecao
                              pk perfil pt cota pkant pk1
                              ptsfalsos ptsamais fim dist
                              cotant ultx ulty ultcota)

  (setq lprio (lepoli rio) perfil (list (list cota 0.0))
        ptsfalsos nil ptsamais nil cotant cota
        indinterm (rem (fix (/ cota intmedia)) interv)
        cota (* (1+ (fix (/ cota intmedia))) intmedia)
        selset (criaset rio lprio)
        count 0 pkant 0.0 fim nil
  )
  (command "chprop" poli "" "c" "3" "")
  (if (> (sslength selset) 0)
    (progn
      ; Existem curvas cruzando o rio
      (while (not fim)
        (setq curva (ssname selset count)
              layercurva (cdr (assoc 8 (entget curva)))
              intersecao (intersec lprio (leptpoli curva))
              pk (car intersecao)
              pt (cadr intersecao)
              count (1+ count)
        )
        (cond
          ((and (/= indinterm 4) (= layercurva "CURVA-INTERMEDIA"))
            (setq perfil (append perfil (list (list cota pk)))
                  cotant cota
                  cota (+ cota intmedia)
                  indinterm (1+ indinterm)
                  pkant pk
            )
          )
          ((and (/= indinterm 4) (= layercurva "CURVA-MESTRA"))
            (setq intfalsas (- 4 indinterm)
                  deltapk (/ (- pk pkant) (1+ intfalsas))
                  pk1 (+ pkant deltapk)
            )
            (repeat (fix intfalsas)
              (setq ptsfalsos (append ptsfalsos (list (list cota pk1)))
                    perfil (append perfil (list (list cota pk1)))
                    pk1 (+ pk1 deltapk)
                    cotant cota
                    cota (+ cota intmedia)
              )
            )
            (setq perfil (append perfil (list (list cota pk)))
                  cotant cota
                  cota (+ cota intmedia)
                  indinterm 0
                  pkant pk
            )
          )
          ((and (= indinterm 4) (= layercurva "CURVA-MESTRA"))
            (setq perfil (append perfil (list (list cota pk)))
                  cotant cota
                  cota (+ cota intmedia)
                  indinterm 0
                  pkant pk
            )
          )
          ((and (= indinterm 4) (= layercurva "CURVA-INTERMEDIA"))
            (if (> count (1- (sslength selset))) (setq fim T))
            (while (and (not fim) (= layercurva "CURVA-INTERMEDIA"))
              (setq ptsamais (append ptsamais (list (list pk curva)))
                    curva (ssname selset count)
                    layercurva (cdr (assoc 8 (entget curva)))
                    intersecao (intersec lprio (leptpoli curva))
                    pk (car intersecao)
                    pt (cadr intersecao)
                    count (1+ count)
              )
              (if (> count (1- (sslength selset))) (setq fim T))
            )
            (setq perfil (append perfil (list (list cota pk)))
                  cotant cota
                  cota (+ cota intmedia)
                  indinterm 0
                  pkant pk
            )
          )
        )
        (if (> count (1- (sslength selset))) (setq fim T))
      )
      (if ptsfalsos
	(setq ptsfalsos (cons rio ptsfalsos)
	      lstptsfalsos (append lstptsfalsos (list ptsfalsos))
	)
      )
      (if ptsamais
	(setq ptsamais (cons rio ptsamais)
	      lstptsamais (append lstptsamais (list ptsamais))
	)
      )
      (setq dist (+ pk (distance pt (last lprio)))
            ultcota (calcultcota lprio perfil)
      )
      (if (> ultcota (+ cotant (/ intmedia 2.0)))
        (setq ultcota (+ cotant (/ intmedia 2.0)))
      )
    )
    ; Nao existem curvas cruzando o rio
    (setq cota (car (last perfil)) pk 0.0 dist (pkultpt lprio)
          ultcota (+ cota (/ intmedia 2.0))
    )
  )
  (setq perfil (append perfil (list (list ultcota dist)))
        perfil (cons rio (list perfil))
        ultx (+ (car (last lprio)) 20.0)
        ulty (+ (cadr (last lprio)) 20.0)
  )
(command "text" (list ultx ulty) "0" (rtos ultcota 2 0))
  perfil
)
;---------------------------------------------------------------------------------
;
; criaset - cria set de selecao com as isolinhas que cruzam o rio cujo
;	    identificador é rio e lista de pontos é lpoli
;
;---------------------------------------------------------------------------------
(defun criaset (rio lpoli / lfence pselset selset count laflu 
                       lpoli aflu poliaflu)
        
  (setq poli (cadr (assoc rio lrios))
        selset (ssadd)
  )
  (repeat (1- (length lpoli))
    (setq lfence (list (car lpoli) (cadr lpoli))
          lpoli (cdr lpoli)
          pselset (ssget "f" lfence '((-4 . "<AND")
                                          (0 . "LWPOLYLINE")
                                              (-4 . "<OR")
                                                  (8 . "CURVA-MESTRA")
                                                  (8 . "CURVA-INTERMEDIA")
                                              (-4 . "OR>")
                                      (-4 . "AND>")
                                     )
                  )
          count 0
    )
    (if pselset
      (repeat (sslength pselset)
        (setq selset (ssadd (ssname pselset count) selset)
              count (1+ count)
        )
      )
    )
  )
  (ssdel poli selset)
  selset
)
;---------------------------------------------------------------------------------
;
; calcultcota - em um rio cujo traçado é definido pela lista de pontos lprio,
;		a partir de jusante, na forma ((x y) (x y) ...),
;		e do perfil até então levantado,
;		na forma ( rio ((cota pk) (cota pk)...)),
;		devolve a cota do ponto de montante, extrapolando o perfil
;		ou, se a diferença de cota para a última calculada exceder um
;		intervalo de cotas, colocando no meio do intervalo de cotas
;
;---------------------------------------------------------------------------------
(defun calcultcota (lprio perfil / x1 z x ind z0 x0 ct)

  (setq x1 (pkultpt lprio)
        z (car (last perfil))
	x (cadr (last perfil))
        ind (1- (length perfil))
        z0 (car (nth (1- ind) perfil))
	x0 (cadr (nth (1- ind) perfil))
  )
  (+ (/ (* (- x1 x0) (- z z0)) (- x x0)) z0)
)
;---------------------------------------------------------------------------------
;
; pkultpt - dada uma polilinha como uma lista de ponto (lprio),
;	    devolve o comprimento da mesma
;
;---------------------------------------------------------------------------------
(defun pkultpt (lprio / dist p1 p2)

  (setq dist 0.0 p1 (car lprio) lprio (cdr lprio))
  (repeat (length lprio)
    (setq p2 (car lprio) lprio (cdr lprio)
          dist (+ dist (distance p1 p2))
          p1 p2
    )
  )
  dist
)
;---------------------------------------------------------------------------------
;
; intersec - busca ponto de intersecao entre
;            uma polilinha cuja lista de pontos é dada por lpoli
;	     e um segmento cuja lista de pontos é dada por seg
;            retorna lista com a distancia acumulada ao longo da polilinha
;	     dada por lpoli e o ponto de intersecao do segmento
;
;---------------------------------------------------------------------------------
(defun intersec (lpoli seg / segp1 segp2 p1 p2 pint dist)

  (setq segp1 (car seg)
        segp2 (last seg)
        pint nil dist 0.0
  )
  (while (not pint)
    (setq p1 (car lpoli)
          p2 (cadr lpoli)
          lpoli (cdr lpoli)
          pint (inters p1 p2 segp1 segp2)
    )
    (if (not pint) (setq dist (+ dist (distance p1 p2))))
  )
  (list (+ dist (distance p1 pint)) pint)
)
;---------------------------------------------------------------------------------
;
; interpcota - interpola cota da foz do afluente
;
;---------------------------------------------------------------------------------
(defun interpcota (perfil ptaflu / rio x z pf z0 x0 z1 x1)

  (setq rio (car perfil)
        x ptaflu
        perfil (cadr perfil)
        z 0.0 
  )
  (repeat (1- (length perfil))
    (setq pf (car perfil)
          z0 (car pf) x0 (cadr pf)
          perfil (cdr perfil)
          pf (car perfil)
          z1 (car pf) x1 (cadr pf)
    )
    (if (and (> x x0) (< x x1))
      (setq z (+ (/ (* (- x x0) (- z1 z0)) (- x1 x0)) z0))
    )
  )
  (if (= z 0.0) (setq z z1))
  z
)
;----------------------------------------------------------------------------
;
; desptsfalsos - desenha os pontos falsos criados na geração do perfil
;		 armazenados na lista lsptsfalsos na forma
;		 ((rio ((x y) (x y) ...)(rio ((x y) (x y) ...)...)
;		 onde rio é o string que identifica o rio e x e y são as
;		 coordenadas onde os pontos falsos foram inseridos
;
;----------------------------------------------------------------------------
(defun desptsfalsos ( / count ptsfalsos rio lpoli ptsfalsos
                        ptfalso pk ptang pt ang)

  (setq count 0)
  (repeat (length lstptsfalsos)
    (setq ptsfalsos (nth count lstptsfalsos)
          rio (car ptsfalsos)
          lpoli (lepoli rio)
          ptsfalsos (cdr ptsfalsos)
          count (1+ count)
    )
    (while ptsfalsos
      (setq ptfalso (car ptsfalsos)
            ptsfalsos (cdr ptsfalsos)
            pk (cadr ptfalso)
            ptang (calcptang lpoli pk)
            pt (car ptang)
            ang (cadr ptang)
      )
      (command "insert" "*curva" pt "1" (angtos ang 0 0))
    )
  )
)
;----------------------------------------------------------------------------
;
; marcaptsamais - muda layer de curvas intermediárias a mais p/ "sobra-curva"
;
;----------------------------------------------------------------------------
(defun marcaptsamais ( / count ptsamais ptamais poli rio)

  (setq count 0)
  (repeat (length lstptsamais)
    (setq ptsamais (nth count lstptsamais)
          rio (car ptsamais)
          ptsamais (cdr ptsamais)
          count (1+ count)
    )
    (princ "\nRio :")(princ rio)
    (while ptsamais
      (setq ptamais (car ptsamais)
            poli (cadr ptamais)
            ptsamais (cdr ptsamais)
      )
      (command "chprop" poli "" "la" "sobra-curva" "")
    )
  )
)
;----------------------------------------------------------------------------
;
; calcptang - recebe uma polilinha sob a forma de uma lista de pontos (lpoli)
;	      e uma distância ao longo da linha (pk).
;	      devolve uma lista (pt ang) onde pt é a posição de ponto sobre a
;	      polilinha que dista pk de seu início e ang é o ângulo do
;	      segmento da polilinha sobre o qual ele se encontra. 
;
;----------------------------------------------------------------------------
(defun calcptang (lpoli pk / p1 p2 ang dist distant)

  (setq p1 (car lpoli)
        p2 (cadr lpoli)
        ang (angle p1 p2)
        dist (distance p1 p2)
        distant 0.0
        lpoli (cdr lpoli)
  )
  (while (< dist pk)
    (setq p1 (car lpoli) p2 (cadr lpoli) lpoli (cdr lpoli)
          distant dist
          dist (+ dist (distance p1 p2))
          ang (angle p1 p2)
    )
  )
  (list (polar p1 ang (- pk distant)) ang)
)
;------------------------------------------------------------------------------
;
; lepoli - cria uma lista de pontos de jusante para montante, lendo no
;	   desenho AutoCAD o rio cujo identificador é dado por rio
;
;------------------------------------------------------------------------------
(defun lepoli (rio / poli dir lpoli)

  (setq poli (cadr (assoc rio lrios))
        dir (last (assoc rio lrios))
        lpoli (leptpoli poli)
  )
  (if (= dir 1) (setq lpoli (reverse lpoli)))
  lpoli
)
;---------------------------------------------------------------------------------
;
; leptpoli - dado um número de entidade AutoCAD referente a uma polilinha (poli)
;	     retorna uma lista com os pontos que a definem, na forma
;            ((x y) (x y) (x y)...)
;
;---------------------------------------------------------------------------------
(defun leptpoli (poli / dpoli pts pt)

  (setq dpoli (entget poli)
        pts nil
  )
  (while dpoli
    (setq pt (car dpoli)
          dpoli (cdr dpoli)
    )
    ; se for ponto da polilinha entra na lista
    (if (= (car pt) 10)
      (setq pts (append pts (list (cdr pt))))
    )
  )
  pts
)
;---------------------------------------------------------------------------------
;
; str_sepelems - separa string em substrings (separador = brancos)
;		 retorna lista de substrings
;
;---------------------------------------------------------------------------------
(defun str_sepelems ( string / setsep lisstr carac setsep sstr
                               plic indss indstr i n)

  (if string
    (progn
      (setq lisstr nil
            n (strlen string)
            setsep '(" " "," ";")
            i 1
            sstr ""
            indss nil
            indstr nil
      )
      (while (<= i n)
        (setq carac (substr string i 1))
        (setq plic (= carac "\""))
;
;       fim de substring
;
        (if indss
          (if (or plic (and (not indstr) (member carac setsep)))
              (progn
                (if (or indstr (not plic))
                  (setq indss nil indstr nil)
                  (setq indss T indstr T)
                )
                (setq lisstr (append lisstr (list sstr)))
                (setq sstr "")
              )
              (setq sstr (strcat sstr carac))
          )
          (if (or plic (member carac setsep))
            (if plic (setq indss T indstr T))
            (progn
              (setq indss T)
              (setq sstr (strcat sstr carac))
            )
          )
        )
        (setq i (1+ i))
      )
      (if indss (setq lisstr (append lisstr (list sstr))))
      (if indstr nil lisstr)
    )
    nil
  )
)
;-------------------------------------------------
;  
; slvctx - salva contexto AutoCAD
;
;-------------------------------------------------
    (defun slvctx ( )
        (setq oldbm (getvar "blipmode"))
        (setq oldce (getvar "cmdecho"))
        (setq oldplgen (getvar "plinegen"))
        (setq oldtxtst (getvar "textstyle"))
        (setvar "blipmode" 0)
        (setvar "cmdecho" 0)
        (setvar "plinegen" 1)
        (prin1)
    )
;-------------------------------------------------
;
; rcpctx - recupera contexto AutoCAD
;
;-------------------------------------------------
    (defun rcpctx ( )
        (setvar "blipmode" oldbm)
        (setvar "cmdecho" oldce)
        (setvar "plinegen" oldplgen)
        (setvar "textstyle" oldtxtst)
        (prin1)
    )
(princ "\nPara executar, digite GP\n")
(princ)