;;**************************************************************************************************************;;
;;mfillet													;;
;;Fillets all selected polylines according to a user selected value						;;
;;Written CAB 12/7/17												;;
;;**************************************************************************************************************;;
(defun c:mfillet ( / ss rad i ent)
  ;Get the user selection of polylines
  (setq ss (ssget '((0 . "LWPOLYLINE"))))
  ;Get the users desired radius
  (setq rad (getreal "Enter fillet radius: "))
  (setq i 0)
  (command "filletrad" rad)
  ;Go through each polyline and fillet it
  (while (< i (sslength ss))
    (setq ent (ssname ss i))
    (if (= (cdr (assoc 0 (entget ent))) "LWPOLYLINE")
      (command "_.fillet" "_polyline" ent)
    )
    (setq i (+ i 1))
  )
  ;Report how many polylines you filleted
  (print (strcat "Managed to fillet " (itoa i) " polylines"))
  (princ)
)
