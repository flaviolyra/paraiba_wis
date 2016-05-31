;-------------------------------------------------------------------------
;
;      Subrotina LEVAL - decompoe uma linha em seus componentes,
;                        separados por ponto e virgula
;
;-------------------------------------------------------------------------
(defun leval (linha / complin lista ini i carac)
  (if linha
    (progn
      (setq complin (strlen linha)
            lista nil
            ini 1
            i 1
            carac (substr linha i 1)
      )
      (repeat complin
        (if (= carac ";")
          (setq subst (substr linha ini (- i ini))
                lista (append lista (list subst))
                ini (1+ i)
          )
        )
        (setq i (1+ i)
              carac (substr linha i 1)
        )
      )
      (if (<= ini complin)
        (setq subst (substr linha ini)
              lista (append lista (list subst))
        )
      )
      lista
    )
    nil
  )
)
;-------------------------------------------------------------------------
;
;       Subrotina LETRCH - Le  o arquivo de trechos (arcos),
;               proveniente do Arc/INFO, composto dos campos:
;                       no de origem (no)
;                       no de destino (nd)
;                       comprimento (c)
;                       identificador (id)
;                       nome do rio (nomr)
;                       numero associado ao nome (numr)
;               e transforma numa lista (lstrios - global) na forma:
;               ( ( (nomr1 numr1) ( ( (no11 nd11) c11 id11)
;                                   ( (no12 nd12) c12 id12)
;                                       ...
;                                 )
;                 )
;                 ( (nomr2 numr2) ( ( (no21 nd21) c21 id21)
;                                   ( (no22 nd22) c22 id22)
;                                       ...
;                                 )
;                 )
;                       ...
;               )
;
;-------------------------------------------------------------------------
(defun letrech ( nomearq / arq linha lstval node nopara comp ident nome
                numero nomerio nos trecho listtrch novnome novnum i )
  (setq arq (open nomearq "r")
        linha (read-line arq)
        lstval (leval linha)
        node (atoi (nth 0 lstval))
        nopara (atoi (nth 1 lstval))
        comp (atof (nth 2 lstval))
        ident (atoi (nth 3 lstval))
        nome (nth 4 lstval)
        numero (atoi (nth 5 lstval))
        nomerio (list nome numero)
        nos (list node nopara)
        trecho (list ident comp nos)
        listtrch (list trecho)
        linha (read-line arq)
        lstval (leval linha)
        node (atoi (nth 0 lstval))
        nopara (atoi (nth 1 lstval))
        comp (atof (nth 2 lstval))
        ident (atoi (nth 3 lstval))
        novnome (nth 4 lstval)
        novnum (atoi (nth 5 lstval))
        nos (list node nopara)
        trecho (list ident comp nos)
        lstrios nil
        i 1
  )
  (while (and linha lstval)
    (princ i)(princ "\r")
    (setq i (1+ i))
    (if (and (= nome novnome) (= numero novnum))
      (setq listtrch (append listtrch (list trecho)))
      (setq rio (list nomerio listtrch)
            lstrios (append lstrios (list rio))
            nome novnome
            numero novnum
            nomerio (list nome numero)
            listtrch (list trecho)
      )
    )
    (setq linha (read-line arq)
          lstval (leval linha)
    )
    (if lstval
      (setq node (atoi (nth 0 lstval))
            nopara (atoi (nth 1 lstval))
            comp (atof (nth 2 lstval))
            ident (atoi (nth 3 lstval))
            novnome (nth 4 lstval)
            novnum (atoi (nth 5 lstval))
            nos (list node nopara)
            trecho (list ident comp nos)
      )
    )
  )
  (setq rio (list nomerio listtrch)
        lstrios (append lstrios (list rio))
  )
  (close arq)
)
;-------------------------------------------------------------------------
;
;       Subrotina PROCURA - Dado um no (no) e uma lista de trechos
;               de rios (lsttrch) encontra um trecho que encaixe
;               no no dado. Devolve a identificacao do trecho (com
;               sinal positivo caso o no que encaixe seja o no de,
;               ou negativo caso seja o no para, ou nulo caso nao
;               se ache nenhum), o outro no do trecho encaixado, o
;               comprimento do trecho encaixado e
;               a lista de trechos remanescentes.
;
;-------------------------------------------------------------------------
(defun procura ( no lsttrch / nvlstrch idf nof trecho lsttrch id nos
                              node nopara comp)
  (setq nvlstrch nil
        idf nil
        nof nil
        comp nil
  )
  (while lsttrch
    (setq trecho (car lsttrch)
          lsttrch (cdr lsttrch)
          id (car trecho)
          nos (caddr trecho)
          node (car nos)
          nopara (cadr nos)
    )
    (cond
      ((and (not idf) (= node no))
         (setq idf id
               nof nopara
               comp (cadr trecho)
         ))
      ((and (not idf) (= nopara no))
          (setq idf (- 0 id)
                nof node
                comp (cadr trecho)
          ))
      ( T
          (setq nvlstrch (append nvlstrch (list trecho))))
    )
  )
  (list idf nof comp nvlstrch)
)
;-------------------------------------------------------------------------
;
;       Subrotina PROCRIO - Processa um rio
;               A partir de um rio (elemento de lstrios)
;               devolve o rio processado (ver forma abaixo) e
;               os eventuais trechos que nao encaixem
;
;-------------------------------------------------------------------------
(defun procrio ( rio / nomerio lsttrech trecho id0 nos lstno lstid
                        node nopara no id resp comp lstcomp)
  (setq nomerio (car rio)
        lsttrech (cadr rio)
        trecho (car lsttrech)
        lsttrech (cdr lsttrech)
        id0 (car trecho)
        comp (cadr trecho)
        nos (caddr trecho)
        lstno nos
        lstid (list id0)
        lstcomp (list comp)
        node (car nos)
        nopara (cadr nos)
        no nopara
        id id0
  )
  ;     procura para a frente
  (while (and lsttrech id)
    (setq resp (procura no lsttrech)
          id (car resp)
          no (cadr resp)
          comp (caddr resp)
          lsttrech (cadddr resp)
    )
    (if id
      (setq lstno (append lstno (list no))
            lstid (append lstid (list id))
            lstcomp (append lstcomp (list comp))
      )
    )
  )
  ;     procura para tras
  (setq no node
        id id0
  )
  (while (and lsttrech id)
    (setq resp (procura no lsttrech)
          id (car resp)
          no (cadr resp)
          comp (caddr resp)
          lsttrech (cadddr resp)
    )
    (if id
      (setq id (- 0 id)
            lstno (cons no lstno)
            lstid (cons id lstid)
            lstcomp (cons comp lstcomp)
      )
    )
  )
  (list (list nomerio lstno lstid lstcomp) lsttrech)
)
;-------------------------------------------------------------------------
;
;       Subrotina GERARIOS - A partir da lista lstrios
;               gera uma lista com os trechos de rios ordenados, cada
;               um sob a forma de uma lista de nos n, uma lista de
;               identificadores de segmentos id (positivos, quando a
;               direcao for a mesma do rio, e negativos em caso
;               contrario) e uma lista de comprimentos de trechos c, precedidos
;               pela identificacao do rio, composta de nome nom e numero num:
;               ( (nom num) (n1 n2 ...) (id1 id2 ....) (c1 c2 ....) )
;               Se houver mais de um grupo conectado de trechos por
;               rio, o nome e numero do rio, separados por ";",
;               sao escritos no arquivo riodupl.txt.
;
;-------------------------------------------------------------------------
(defun gerarios ( nomarq / n i rio resp rioproc resto nomerio nome numero
                           arq lstid priseg ultseg)
  (setq n (length lstrios)
        i 0
        arq (open nomarq "w")
        lstriopr nil
  )
  (repeat n
    (setq rio (nth i lstrios)
          i (1+ i)
          resp (procrio rio)
          rioproc (car resp)
          resto (cadr resp)
          nomerio (car rio)
          nome (car nomerio)
          numero (cadr nomerio)
    )
    (princ i)
    (princ "\r")
    (if resto
      (progn
        (if (not errdupl)
          (princ "Rios Duplicados: nome;numero;primeiro arco;ultimo arco\n" arq)
        )
        (setq errdupl T
              lstid (caddr rioproc)
              priseg (car lstid)
              ultseg (car (reverse lstid))
        )
        (princ nome arq)
        (princ ";" arq)
        (princ numero arq)
        (princ ";" arq)
        (princ priseg arq)
        (princ ";" arq)
        (princ ultseg arq)
        (princ "\n" arq)
      )
    )
    (setq lstriopr (append lstriopr (list rioproc)))
  )
  (princ "\n")
  (close arq)
)
;-------------------------------------------------------------------------
;
;       Subrotina IMPRIO - Gera o arquivo nomarq, contendo:
;               numero do rio
;               nome do rio
;               numero auxiliar do rio
;               comprimento do rio
;
;               separados por ";"
;
;-------------------------------------------------------------------------
(defun imprio ( nomarq / arq n i rio nomrio numero comp lstcomp)
  (setq arq (open nomarq "w")
        n (length lstriopr)
        i 0
  )
  (princ "Numero;Nome;NumNome;Comprimento\n" arq)
  (repeat n
    (setq rio (nth i lstriopr)
          i (1+ i)
          nomrio (car rio)
          lstcomp (cadddr rio)
          nome (car nomrio)
          numero (cadr nomrio)
          comp 0.0
    )
    (while lstcomp
      (setq comp (+ comp (car lstcomp))
            lstcomp (cdr lstcomp)
      )
    )
    (princ i arq)(princ ";" arq)
    (princ nome arq)(princ ";" arq)
    (princ numero arq)(princ ";" arq)
    (princ (rtos comp 2 2) arq)(princ "\n" arq)
  )
  (close arq)
)
;-------------------------------------------------------------------------
;
;       Subrotina IMPTRCH - Gera o arquivo nomarq, contendo:
;               numero do trecho (id do Arc/INFO)
;               numero do rio
;               direcao (+1 se de montante para jusante, -1 se oposto)
;               comprimento do trecho
;               comprimento acumulado no rio do ponto a jusante
;
;               separados por ";"
;
;-------------------------------------------------------------------------
(defun imptrch ( nomarq / arq n i rio lstid id ida comp lstcomp dir comp dirt)
  (setq arq (open nomarq "w")
        n (length lstriopr)
        i 0
  )
  (princ "Numero;Numero do Rio;Direcao;Comprimento;Comprimento Acumulado\n" arq)
  (repeat n
    (setq rio (nth i lstriopr)
          lstid (caddr rio)
          lstcomp (cadddr rio)
          dir (cadr (assoc i lstdir))
          i (1+ i)
          compa 0.0
    )
    (if (< dir 0)
      (setq lstid (reverse lstid)
            lstcomp (reverse lstcomp)
      )
    )
    (while lstid
      (setq id (car lstid)
            lstid (cdr lstid)
            ida (abs id)
            comp (car lstcomp)
            lstcomp (cdr lstcomp)
      )
      (if (< id 0)
        (setq dirt dir)
        (setq dirt (- 0 dir))
      )
      (princ ida arq)(princ ";" arq)
      (princ i arq)(princ ";" arq)
      (princ dirt arq)(princ ";" arq)
      (princ (rtos comp 2 2) arq)(princ ";" arq)
      (princ (rtos compa 2 2) arq)(princ "\n" arq)
      (setq compa (+ compa comp))
    )
  )
  (close arq)
)
;-------------------------------------------------------------------------
;
;       Subrotina GERAFLU - Imprime o indice do rio (indr + 1), o indice
;               do rio onde desagua (inddesag + 1), o trecho (idtr)
;		o ponto de desague,
;               a ordem do rio na bacia
;               e a direcao do rio dir (+1 se o no cabeca da lista
;               for o de jusante, -1 ser for o de montante)
;               no arquivo arq e gera sua lista de afluentes
;
;-------------------------------------------------------------------------
(defun geraflu ( indr inddesag idtr ponto ordem dir arq / riopr numrios lstnos
                                                     lstcomp comp ptaflu
                                                     slnd slnp no lstid idtrech)
  (setq riopr (nth indr lstriopr)
        numrios (length lstriopr)
        lstnos (cadr riopr)
	lstid (caddr riopr)
        lstcomp (cadddr riopr)
        i 0
  )
  (if (< dir 0)
    (setq lstnos (reverse lstnos)
	  lstid (reverse lstid)
          lstcomp (reverse lstcomp)
    )
  )
  ;
  ; imprime o indice do rio, onde desagua e em que trecho e ponto e a ordem do rio
  ;
  (princ (1+ indr) arq)
  (princ ";" arq)
  (princ (1+ inddesag) arq)
  (princ ";" arq)
  (princ (abs idtr) arq)
  (princ ";" arq)
  (princ (rtos ponto 2 2) arq)
  (princ ";" arq)
  (princ ordem arq)
  (princ "\n" arq)
  ;
  ; coloca a direcao do rio na lista de direcoes lstdir
  ;
  (setq lstdir (cons (list indr dir) lstdir))
  ;
  ; busca no a no os afluentes do rio
  ;
  (setq lstnos (cdr lstnos)
        ptaflu 0.0
  )
  (while lstnos
    (setq no (car lstnos)
          lstnos (cdr lstnos)
	  idtrech (car lstid)
	  lstid (cdr lstid)
          comp (car lstcomp)
          lstcomp (cdr lstcomp)
          ptaflu (+ ptaflu comp)
          slnd (member no lsnode)
          slnp (member no lsnopara)
    )
    ;
    ; busca entre os nos de
    ;
    (while slnd
      (setq ind (- numrios (length slnd))
            slnd (cdr slnd)
            slnd (member no slnd)
      )
      (if (/= ind indr) (geraflu ind indr idtrech ptaflu (1+ ordem) 1 arq))
    )
    ;
    ; busca entre os nos para
    ;
    (while slnp
      (setq ind (- numrios (length slnp))
            slnp (cdr slnp)
            slnp (member no slnp)
      )
      (if (/= ind indr) (geraflu ind indr idtrech ptaflu (1+ ordem) -1 arq))
    )
  )
)
;-------------------------------------------------------------------------
;
;       Subrotina GERATOPO - Gera o arquivo nomarq, contendo a topologia
;               da rede hidrografica a montante do no nofoz,
;               a partir da lista lstriopr, contendo cada rio como
;               uma sequencia ordenada de nos e de segmentos.
;               Inicializa a lista de direcoes lstdir a ser incrementada
;               pela rotina geraflu, gera as listas de nos de (lsnode)
;               e para (lsnopara) a serem usadas por geraflu.
;		Se sobrarem rios nao conectados, imprime seu nome e numero
;		no arquivo nmarqerr e indica pela variável errtopo.
;
;-------------------------------------------------------------------------
(defun geratopo ( nofoz nomarq nmarqerr / n i lstnos node nopara arq slde slpara
                                 indr dir nome numero)
  ;     gera as lista de no de origem e no final de cada rio
  (setq n (length lstriopr)
        lsnode nil
        lsnopara nil
        lstdir nil
        i 0
  )
  (repeat n
    (setq rio (nth i lstriopr)
          i (1+ i)
          lstnos (cadr rio)
          node (car lstnos)
          nopara (car (reverse lstnos))
          lsnode (cons node lsnode)
          lsnopara (cons nopara lsnopara)
    )
  )
  (setq lsnode (reverse lsnode)
        lsnopara (reverse lsnopara)
        arq (open nomarq "w")
        slde (member nofoz lsnode)
        slpara (member nofoz lsnopara)
  )
  ;    procura se o no da foz esta na lista de nos de origem ou de final
  (princ "Rio;Rio onde desagua;Trecho onde desagua;Ponto;Ordem\n" arq)
  (cond
    ;    se esta na de nos de origem chama geraflu com o rio principal, na direcao positiva
    ( slde
      (setq indr (- n (length slde))
            dir 1
      )
      (geraflu indr -1 0 0.0 1 dir arq)
    )
    ;    se esta na de nos de final chama geraflu com o rio principal, na direcao negativa
    ( slpara
      (setq indr (- n (length slpara))
            dir -1
      )
      (geraflu indr -1 0 0.0 1 dir arq)
    )
    ;    se nao esta em nenhuma delas informa erro
    ( t
      (print "Nao encontrado o rio principal")
    )
  )
  (close arq)
  ;    procura erros de topologia e indica pela variavel errtopo
  (open nmarqerr "w")
  (setq i 0
        arq (open nmarqerr "w")
  )
  (repeat n
    (if (not (assoc i lstdir))
      (progn
        (if (not errtopo)
          (princ "Rios nao conectados: Nome do Rio;Numero do Rio\n" arq)
        )
        (setq errtopo T
              rio (nth i lstriopr)
              nome (caar rio)
              numero (cadar rio)
        )
        (princ nome arq)
        (princ ";" arq)
        (princ numero arq)
        (princ "\n" arq)
      )
    )
    (setq i (1+ i))
  )
  (close arq)
)
;-------------------------------------------------------------------------
;
;       Subrotina TOPOLOGI - Monta os arquivos RIOS.TXT, TRECHOS.TXT
;               e TOPOLOGI.TXT, que descrevem a topologia da rede
;               hidrografica, a montante do no 1467,
;               a partir do arquivo RIOS_CLA.TXT.
;		As variaveis errdupl e errtopo indicam erros de
;		rios duplicados e rios nao ligados à rede. O arquivo
;               ERROS.TXT dá detalhes dos rios duplicados ou nao ligados.
;
;-------------------------------------------------------------------------
(defun topologi ( / arq linha )
  (setq errdupl nil
        errtopo nil
  )
  (print "Lendo o arquivo AAT.DBF proveniente do Arc/INFO...")
  (princ "\n")
  (letrech "rios_cla.txt")
  (print "Montando os rios...")
  (princ "\n")
  (gerarios "erros.txt")
  (print "Imprimindo RIOS.TXT...")
  (imprio "rios.txt")
  (if errdupl
    (progn
      (print "Foram encontrados rios duplicados.")
      (print "Ver arquivo erros.txt.")
    )
    (progn
      (print "Gerando TOPOLOGI.TXT...")
      (geratopo 1522 "topologi.txt" "erros.txt")
      (if errtopo
        (progn
          (print "Foram encontrados rios nao ligados a rede.")
          (print "Ver arquivo erros.txt.")
        )
        (progn
          (print "Imprimindo TRECHOS.TXT...")
          (imptrch "trechos.txt")
        )
      )
    )
  )
  (princ)
)

