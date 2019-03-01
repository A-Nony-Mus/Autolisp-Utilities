;;These are commands that modify a selection
;;replacecircle will replace a single selected object (selected after the command is initiated) with a circle of equivalent size and on the same layer
;;modmirror will mirror the selected objects across the y axis from the midpoint (essentially scale x by -1)
;;modrotate will rotate a selection by 180° from the centerpoint

;;**************************************************************************************************************;;
;;replaceCircle													;;
;;Replaces the circles that are really just a bunch of lines with an actual circle				;;
;;Written CAB 2/14/18												;;
;;**************************************************************************************************************;;
(defun c:replaceCircle ( / ent pt1 pt2 mid)
  ;Get the object we wish to replace
  (setq ent (car (entsel)))
  (setq ent (vlax-ename->vla-object ent))
  ;Get its bounding box
  (vla-getboundingbox ent 'll 'ur)
  ;Turn the BB points into useable data
  (setq pt1 (vlax-safearray->list ll))
  (setq pt2 (vlax-safearray->list ur))
  (setq ent (vlax-vla-object->ename ent))
  ;Get the midpoint of the object
  (setq mid (list (/ (+ (car pt1) (car pt2)) 2) (/ (+ (cadr pt1) (cadr pt2)) 2)))
  ;Draw a circle
  (entmake (list '(0 . "CIRCLE")
		 '(100 . "AcDbEntity")
		 '(100 . "AcDbCircle")
		 (assoc 8 (entget ent))
		 (cons 10 mid)
		 (cons 40 (/ (abs (- (car pt1) (car pt2))) 2))))
  ;Delete the original object
  (entdel ent)
  (CAB:recordCommand nil '("replaceCircle"))
  (princ)
  )
(princ)

;;**************************************************************************************************************;;
;;modmirror													;;
;;Finds the centerpoint of selected objects and mirrors them about the Y plane of that point			;;
;;Written CAB 3/13/18												;;
;;**************************************************************************************************************;;
(defun c:modmirror ( / ss x xlst ylst pt ptlst os)
  (setq ss (ssget))
  (ssget "i")
  (setq x (sslength ss))
  (setq os (getvar "osmode"))
  (setvar "osmode" 0)
  (while (> x 0)
    (setq ent (vlax-ename->vla-object (ssname ss (- x 1))))
    (vla-getboundingbox ent 'll 'ur)
    (setq ptlst (cons (vlax-safearray->list ll) ptlst))
    (setq ptlst (cons (vlax-safearray->list ur) ptlst))
    (print x)
    (setq x (- x 1))
    )
  (setq xlst (mapcar '(lambda (x) (car x)) ptlst) ylst (mapcar '(lambda (x) (cadr x)) ptlst))
  (setq pt (list (/ (+ (apply 'min xlst) (apply 'max xlst)) 2) (/ (+ (apply 'min ylst) (apply 'max ylst)) 2)))
  (command ".mirror" ss "" pt (list (car pt) (+ (cadr pt) 10)) "_YES")
  (setvar "osmode" os)
  (princ)
  )

;;**************************************************************************************************************;;
;;modrotate													;;
;;Finds the centerpoint of selected objects and rotates them 180 degrees					;;
;;Written CAB 10/1/18												;;
;;**************************************************************************************************************;;
(defun c:modrotate ( / ss x xlst ylst pt ptlst)
  (setq ss (ssget))
  (ssget "i")
  (setq x (sslength ss))
  (while (> x 0)
    (setq ent (vlax-ename->vla-object (ssname ss (- x 1))))
    (vla-getboundingbox ent 'll 'ur)
    (setq ptlst (cons (vlax-safearray->list ll) ptlst))
    (setq ptlst (cons (vlax-safearray->list ur) ptlst))
;;;    (print x)
    (setq x (- x 1))
    )
  (setq xlst (mapcar '(lambda (x) (car x)) ptlst) ylst (mapcar '(lambda (x) (cadr x)) ptlst))
  (setq pt (list (/ (+ (apply 'min xlst) (apply 'max xlst)) 2) (/ (+ (apply 'min ylst) (apply 'max ylst)) 2)))
  (command ".rotate" ss "" pt 180)
  (CAB:recordCommand nil '("modrotate"))
  (princ)
  )
