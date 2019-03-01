;;These commands are for scaling a drawing according to a predefined scale (e.g. 1/4" = 1'-0")
;;Simply run the setscale command, type in the scale in fraction notation (e.g. 1/4), then run sdraw

(vl-load-com)

;;**************************************************************************************************************;;
;;setscale                                                                                                      ;;
;;Takes user input and turns it into a multiplier for scaling drawings                                          ;;
;;Written CAB 12/7/17                                                                                           ;;
;;**************************************************************************************************************;;
(defun c:setscale ( / fraction numerator denominator equate flag)
  ;Get user input
  (setq fraction (getstring "\nEnter fraction value: "))
  ;Store the numerator and the denominator
  (setq fraction (vl-string->list fraction))
  (foreach i fraction
    (if (= i (ascii "/")) (setq flag t)
    (progn
      (if flag
	(setq denominator (cons i denominator))
	(setq numerator (cons i numerator))
	)
      ))
      )
  (setq denominator (vl-list->string (reverse denominator)))
  (setq numerator (vl-list->string (reverse numerator)))
  ;Calculate what our scaling multiplier is and save that
  (setq equate (float (/ (* 12 (atoi denominator)) (atoi numerator))))
  (setenv "cscale" (rtos equate 2 2))
  (princ)
  )
(princ)


;;**************************************************************************************************************;;
;;sdraw                                                                                                         ;;
;;Scale the drawing according to the scale factor, then zoom out                                                ;;
;;Written CAB 12/7/17                                                                                           ;;
;;**************************************************************************************************************;;
(defun c:sdraw ( / )
  (sssetfirst nil (ssget "X"))
  (ssget "i")
  (command "scale" "0,0" (getenv "cscale"))
  (command "zoom" "a")
)
(princ)
