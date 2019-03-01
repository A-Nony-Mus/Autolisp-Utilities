;;**************************************************************************************************************;;
;;objGroup													;;
;;CREATES GROUPS BASED ON USER SELECTION (MASS GROUPING FUNCTION)						;;
;;Written CAB 9/12/18												;;
;;**************************************************************************************************************;;
(defun c:objGroup ( / ss x ent pt)
  (setq ss (ssget))
  (setq x (sslength ss))
  (while (> x 0)
    (setq ent (entget (ssname ss (1- x))))
    (if (and (not (assoc 102 ent))
	     (not (= (cdr (assoc 0 ent)) "LINE")))
      (progn
	(vla-getboundingbox (vlax-ename->vla-object (ssname ss (1- x))) 'll 'ur)
	(command ".-group" "create" "*" "" (ssget "_C" (vlax-safearray->list ll) (vlax-safearray->list ur)) "")
	)
      )
    (setq x (1- x))
    )
  )

;;**************************************************************************************************************;;
;;scgrp														;;
;;scales all groups in a given selection set									;;
;;Written CAB 12/11/18												;;
;;**************************************************************************************************************;;
(defun c:scgrp ( / ss grp x factor done ent name y pt xlst ylst)
  (setq ss (ssget))
  (setq factor (getreal "Enter scale factor: "))
  (setq x (sslength ss))
  (while (> x 0)
    (setq ent (entget (ssname ss (1- x))))
    (setq grp (ssadd))
    (if (assoc 330 ent)
      (progn
	(setq ent (entget (cdr (assoc 330 ent))))
	(foreach item ent
	  (if (= (car item) 340)
	    (progn
	      (setq name (cdr (assoc -1 (entget (cdr item)))))
	      (if (not (member name done))
		(progn
		  (setq done (cons name done))
		  (ssadd name grp)
		  )))))
	(setq y (sslength grp)
	      xlst nil
	      ylst nil)
	(while (> y 0)
	  (vla-getboundingbox (vlax-ename->vla-object (ssname grp (1- y))) 'll 'ur)
	  (setq xlst (cons (car (vlax-safearray->list ll)) xlst)
		xlst (cons (car (vlax-safearray->list ur)) xlst)
		ylst (cons (cadr (vlax-safearray->list ll)) ylst)
		ylst (cons (cadr (vlax-safearray->list ur)) ylst)
		y (1- y))
	  )
	(if (and grp xlst ylst)
	  (progn
	    (setq pt (vlax-3d-point (/ (+ (car (vl-sort xlst '<)) (car (vl-sort xlst '>))) 2) (/ (+ (car (vl-sort ylst '<)) (car (vl-sort ylst '>))) 2) 0))
	    (print pt)
	    (setq y (sslength grp))
	    (while (> y 0)
	      (vla-scaleentity (vlax-ename->vla-object (ssname grp (1- y))) pt factor)
	      (setq y (1- y))
	      )
	    ))))
    (setq x (1- x))
    ))
