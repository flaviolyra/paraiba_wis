;-------------------------------------------------------------------------
;
; laynov
;
;-------------------------------------------------------------------------
(defun laynov ( layer / nvlayer lslayer)
  (setq lslayer '( ("U06" "5")    ; Floresta Ombrofila
		   ("A26" "125")  ; Area Urbana Baixa Densidade
		   ("U41" "40")   ; Encosta Degradada
		   ("A31" "130")  ; Area Urbana Media Densidade
		   ("A36" "135")  ; Area Urbana Alta Densidade
		   ("P06" "150")  ; Grandes Construcoes
		   ("U71" "70")   ; Mangue Degradado
                   ("U96" "95")   ; Floresta Estacional
                   ("U81" "80")   ; Estepe Arborea
                   ("U11" "10")   ; Vegetacao Secundaria
                   ("U21" "20")   ; Restinga
                   ("U26" "25")   ; Mangue
                   ("U16" "15")   ; Varzea
                   ("U91" "90")   ; Campos de Altitude
                   ("U36" "35")   ; Campo/Pastagem
                   ("U56" "55")   ; Reflorestamento
                   ("U46" "45")   ; Area Agricola
                   ("U51" "50")   ; Solo Exposto
                   ("U31" "30")   ; Area Inundada
                   ("A06" "105")  ; Area Urbana 100
                   ("U66" "65")   ; Area Nao Sensoriada
                   ("U61" "60")   ; Afloramento Rochoso
                   ("U76" "75")   ; Praia
                   ("U86" "85")   ; Salinas
	           ("R06" "500")  ; Protecao Ambiental <--- Codigo Adicionado
                   ("H06" "205")) ; Rios e Lagos/Oceano
  )
  (setq nvlayer (cdr (assoc layer lslayer)))
  (if nvlayer (setq nvlayer (car nvlayer)))
  nvlayer
)
;-------------------------------------------------------------------------
;
; codlay
;
;-------------------------------------------------------------------------
(defun codlay ( layer / i n codigo fim carac )
  (setq i 1
        n (strlen layer)
        codigo ""
        fim nil
  )
  (while (not fim)
    (setq carac (substr layer i 1))
    (if (= carac "_")
      (setq fim T)
      (setq codigo (strcat codigo carac)
            i (1+ i)
            fim (> i n)
      )
    )
  )
  codigo
)
;-------------------------------------------------------------------------
;
; cluso
;
;-------------------------------------------------------------------------
(defun cluso ( nomarqe nomarqs / arqe arqs achou linha x y lispt
                                 n i pt pt1 pt2 selset nelem ielem nhach
                                 nentid nome layer nvlayer nt letra
                                 pz1 pz2 pc1 pc2 pc3 pc4)
  (setvar "cmdecho" 0)
  (setq arqe (open nomarqe "r")
        arqs (open nomarqs "w")
  )
  (if (not arqe)
    (progn
      (princ "\nErro na abertura do arquivo de entrada")
      (princ nomarqe)
      (princ "\n")
    )
  )
  (if (not arqs)
    (progn
      (princ "\nErro na abertura do arquivo de saida")
      (princ nomarqs)
      (princ "\n")
    )
  )
  (if (and arqe arqs)
    (progn
      (setq lispt nil)
      (while (/= (setq linha (read-line arqe)) "END")
        (setq linha (str_sepelems linha)
              x (distof (nth 1 linha) 2)
              y (distof (nth 2 linha) 2)
              lispt (cons (list x y) lispt)
        )
      )
      (close arqe)
      (setq n (length lispt)
            i 0
      )
      (repeat n
        (princ "\nPoligono ")
        (princ (1+ i))
        (princ "\n")
        (setq pt (nth i lispt)
              x (car pt)
              y (cadr pt)
        )
            (setq pz1 (list (- x 1000.0) (- y 1000.0))
                  pz2 (list (+ x 1000.0) (+ y 1000.0))
            )
            (command "zoom" pz1 pz2)
            (setq pc1 (list (- x 50.0) y)
                  pc2 (list (+ x 50.0) y)
                  pc3 (list x (- y 50.0))
                  pc4 (list x (+ y 50.0))
            )
            (grdraw pc1 pc2 1)
            (grdraw pc3 pc4 1)
            (setq nentid nil
                  nt 0
            )
            (while (and (not nentid) (< nt 3))
              (setq nentid (car (entsel "Selecione elemento de classificacao\n"))
                    nt (1+ nt)
              )
              (if nentid                  
                (progn
                  (setq entid (entget nentid)
				layer (codlay (cdr (assoc 8 entid)))
                        nvlayer (laynov layer)
                  )
                  (if (not nvlayer)
                    (setq nentid nil)
                  )
                )
              )
            )
            (if nentid
              (progn
                (princ nvlayer arqs)
		    (princ "," arqs)
		    (princ x arqs)
		    (princ "," arqs)
                (princ y arqs)
                (princ "\n" arqs)
              )
              (progn
		    (princ "65" arqs)
		    (princ "," arqs)
                (princ x arqs)
		    (princ "," arqs)
                (princ y arqs)
                (princ "\n" arqs)
              )
            )
        (setq i (1+ i))
      )
      (princ "END" arqs)
      (close arqs)
    )
  )
  (setvar "cmdecho" 1)
  (princ)
)
;-------------------------------------------------------------------------
;
; str_sepelems - separa string em substrings (separador = brancos)
;		 retorna lista de substrings
;
;-------------------------------------------------------------------------

(defun str_sepelems ( string / setsep lisstr carac setsep sstr
                               plic indss indstr i n)

  (if string
    (progn
      (setq lisstr nil
            n (strlen string)
            setsep '(" " ",")
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
