;------------------------------------------------------------------------------
;
; GPTRACA - Le os perfis gerados por GP
;           e quebra a polilinha nas intersecoes
;           das isolinhas, colocando cada segmento
;           em um layer, correspondente a cota.
;
; Programador: Marcelo de Carvalho
; Data Inicio: 15/09/99 Atualizado em: 29/09/99
;
;
; lpoli original - ((p1) (p2) (p3)...(pn))
; lpoli apos calcpkrio - ((p1 pk) (p2 pk) (p3 pk)...(pn pk))
; lpoli apos cotario - ((p1 pk cota) (p2 pk cota) (p3 pk cota)...(pn pk cota))
;
;------------------------------------------------------------------------------
(defun c:gptraca ( / count count2 perfil rio lpoli pt1perfil
                     pt2perfil lptrecho nlptrecho ultp ultpt)

  (setq count 0)
  (princ "\nEditando rios...")
  (repeat (length lstperfil)
    (setq perfil (nth count lstperfil)
          rio (car perfil)
          count (1+ count)
    )
    (princ "\nRio: ")(princ rio)
    (setq lpoli (lepoli rio)
          lpoli (calcpkrio lpoli) ; calcula os pks dos pontos do rio
          lpoli (cotario lpoli perfil) ; calcula as cotas dos pontos do rio
          perfil (cadr perfil) ; elimina a identificacao do rio
          count2 0
          lptrecho nil
    )
    (repeat (1- (length perfil))
      ; cria lista de pontos com o trecho do rio
      ; interpola o trecho criando pontos com cota em intervalos de 1 metro
      (setq pt1perfil (nth count2 perfil) pt2perfil (nth (1+ count2) perfil)
            lptrecho (criatrecho lpoli pt1perfil pt2perfil (last lptrecho))
            nlptrecho (interptrecho lptrecho)
      )
      (if (= count2 0) (setq ultp (car nlptrecho)))
      (setq count2 (1+ count2)
            ultp (destrecho nlptrecho ultp)
      )
    )
  )
  (princ)
)
;------------------------------------------------------------------------------
;
; destrecho
;
;------------------------------------------------------------------------------
(defun destrecho (lptrecho ultp / count p0 z0 pt0 ptrecho p1 z1 pt1 flag)

  (setq count 0 p0 ultp
        z0 (nth 2 p0) pt0 (car p0)
        ptrecho (list (append pt0 (list z0)))
        count 1
  )
  (repeat (1- (length lptrecho))
    (setq p1 (nth count lptrecho)
          z0 (nth 2 p0) pt0 (car p0)
          z1 (nth 2 p1) pt1 (car p1) flag (last p1)
          count (1+ count)
    )
    (if (= flag "PONTO CRIADO")
      (progn
        (setq ptrecho (append ptrecho (list (append pt1 (list z1)))))
        (desenhap ptrecho)
        (setq ptrecho (list (append pt1 (list z1))))
      )
      (setq ptrecho (append ptrecho (list (append pt1 (list z1)))))
    )
    (setq p0 p1)
  )
  (if (>= (length ptrecho) 2) (desenhap ptrecho))
  p1
)
;------------------------------------------------------------------------------
;
; desenhap
; 
;------------------------------------------------------------------------------
(defun desenhap (ptrecho / cota layer p1 count)

  (setq p1 (car ptrecho)
        cota (rtos (fix (last p1)) 2 0)
        p1 (list (car p1) (cadr p1))
        layer (strcat "C" cota)
        count 1
  )
  (if (not (tblsearch "layer" layer))
    (command "layer" "m" layer "")
    (command "layer" "s" layer "")
  )
  (command "pline" p1)
  (repeat (1- (length ptrecho))
    (setq p2 (nth count ptrecho)
          p2 (list (car p2) (cadr p2))
          count (1+ count)
    )
    (command p2)
  )
  (command "")
)
;------------------------------------------------------------------------------
;
; interptrecho
;
;------------------------------------------------------------------------------
(defun interptrecho (lptrecho / count p0 p1 x0 x1 z0 z1 pt0 pt1
                                np x z pt ang fim)

  (setq count 0 fim nil)
  (while (not fim)
    (setq p0 (nth count lptrecho) p1 (nth (1+ count) lptrecho)
          x0 (nth 1 p0) z0 (nth 2 p0) pt0 (car p0)
          x1 (nth 1 p1) z1 (nth 2 p1) pt1 (car p1)
          z (+ (fix z0) 1.0)
          count (1+ count)
          ang (angle pt0 pt1)
    )
    (if (< z z1)
      (setq x (+ (/ (* (- z z0) (- x1 x0)) (- z1 z0)) x0)
            pt (polar pt0 ang (- x x0))
            pt (list (car pt) (cadr pt))
            np (list pt x z "PONTO CRIADO")
            count (1- count)
            lptrecho (inserep np lptrecho count)
      )
    )
    (if (not (nth (1+ count) lptrecho)) (setq fim T))
  )
  lptrecho
)
;------------------------------------------------------------------------------
;
; inserep
;
;------------------------------------------------------------------------------
(defun inserep (np lptrecho count / nlptrecho cnt)

  (setq nlptrecho nil cnt 0)
  (repeat (length lptrecho)
    (setq trecho (nth cnt lptrecho)
          nlptrecho (append nlptrecho (list trecho))
    )
    (if (= count cnt)
      (setq nlptrecho (append nlptrecho (list np)))
    )
    (setq cnt (1+ cnt))
  )
  nlptrecho
)
;------------------------------------------------------------------------------
;
; criatrecho
;
; entrada: lpoli (((p1poli) pk cota) ((p2poli) pk cota) ((p3poli) pk cota)...)
;          pt1perfil (cota pk)
;          pt2perfil (cota pk)
;
; saida: (((p1poli) pk cota) ((p2poli) pk cota)...) do trecho no perfil analisado
;
;------------------------------------------------------------------------------
(defun criatrecho (lpoli pt1perfil pt2perfil ultpt / 
                   pk1 pk2 pk count pt lptrecho indpt
		   indpt2 ang dist p p1 p2)

  (setq pk1 (cadr pt1perfil) pk2 (cadr pt2perfil) count 0 indpt 0 indpt2 0)
  (if ultpt
    (setq lptrecho (list ultpt))
    (setq lptrecho (list (car lpoli)))
  )
  (repeat (length lpoli)
    (setq pt (nth count lpoli) pk (nth 1 pt))
    (if (and (> pk pk1) (< pk pk2)) ; o ponto esta dentro do trecho do perfil
      (setq lptrecho (append lptrecho (list pt))
            indpt2 count
      )
    )
    (if (< pk pk2)
      (setq indpt count)
    )
    (setq count (1+ count))
  )
  (if (= (length lptrecho) 1) ; nao existem isolinhas nesse trecho do perfil
    (setq p1 (nth indpt lpoli) p2 (nth (1+ indpt) lpoli))
    (setq p1 (nth indpt2 lpoli) p2 (nth (1+ indpt2) lpoli))
  )
  (if (not p2) ; por algum motivo, em alguns casos ele avalia o ultimo ponto como estando
               ; no perfil - esse check elimina o ponto incluido erroneamente
    (setq indpt2 (1- indpt2)
          p1 (nth indpt2 lpoli) p2 (nth (1+ indpt2) lpoli)
          lptrecho (reverse (cdr (reverse lptrecho)))
    )
  )
  (setq ang (angle (car p1) (car p2))
        dist (- pk2 (nth 1 p1))
        p (polar (car p1) ang dist)
        lptrecho (append lptrecho (list (list p pk2 (car pt2perfil))))
  )
  lptrecho
)
;------------------------------------------------------------------------------
;
; cotario
;
; entrada: lpoli (((p1poli) pk) ((p2poli) pk)...)
;          perfil (rio ((cota pk) (cota pk) (cota pk)...(cota pk)))
;
; saida: (((p1poli) pk cota) ((p2poli) pk cota) ((p3poli) pk cota)...)
;
;------------------------------------------------------------------------------
(defun cotario (lpoli perfil / primpt ultpt nlpoli count pt pk cota)

  (setq primpt (append (car lpoli) (list (caaadr perfil)))
        ultpt (append (last lpoli) (list (car (last (cadr perfil)))))
        lpoli (cdr lpoli)
        lpoli (reverse (cdr (reverse lpoli)))
        nlpoli (list primpt)
        count 0
  )
  (repeat (length lpoli)
    (setq pt (nth count lpoli)
          pk (last pt)
          cota (interpcota perfil pk)
          nlpoli (append nlpoli (list (append pt (list cota))))
          count (1+ count)
    )
  )
  (setq nlpoli (reverse nlpoli)
        nlpoli (cons ultpt nlpoli)
  )
  (reverse nlpoli)
)
;------------------------------------------------------------------------------
;
; calcpkrio
;
; entrada: ((p1poli) (p2poli) (p3poli)...(pnpoli))
;
; saida: (((p1poli) pk) ((p2poli) pk)...)
;
;------------------------------------------------------------------------------
(defun calcpkrio (lpoli / nlpoli count pk p1 p2)

  (setq nlpoli nil count 0
        pk 0.0
  )
  (repeat (1- (length lpoli))
    (setq p1 (nth count lpoli)
          p2 (nth (1+ count) lpoli)
          count (1+ count)
          nlpoli (cons (list p1 pk) nlpoli)
          pk (+ pk (distance p1 p2))
    )
  )
  (setq nlpoli (cons (list p2 pk) nlpoli))
  (reverse nlpoli)
)
;------------------------------------------------------------------------------
;
; interpcota - interpola cota
;
;------------------------------------------------------------------------------
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
  z
)
;------------------------------------------------------------------------------
;
; lepoli
;
;------------------------------------------------------------------------------
(defun lepoli (rio / poli dir lpoli)

  (setq poli (cadr (assoc rio lrios))
        dir (last (assoc rio lrios))
        lpoli (leptpoli poli)
  )
  (if (= dir "1") (setq lpoli (reverse lpoli)))
  lpoli
)
;------------------------------------------------------------------------------
;
; leptpoli - cria lista com os pontos que definem uma polilinha
;            retorna lista com os pontos
;            ((p1) (p2) (p3)...)
;
;------------------------------------------------------------------------------
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

(princ "\nPara executar, digite GPTRACA")
(princ)
