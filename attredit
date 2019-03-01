;;**************************************************************************************************************;;
;;attredit													;;
;;Click on an attribute, enter value, repeat until enter is pressed						;;
;;Written CAB 12/7/17												;;
;;**************************************************************************************************************;;
(defun c:attredit ( / pt ss)
  (while (setq pt (getpoint "Select Attribute: "))
    (setq ss (ssget pt))
    (if ss
    (if (eq (cdr (assoc 0 (entget (ssname ss 0)))) "INSERT")
      (command ".attipedit" pt)
      )
      )
    )
  )
