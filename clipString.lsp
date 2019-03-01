;;**************************************************************************************************************;;
;;clipString													;;
;;THIS STRIPS A USER SPECIFIED STRING FROM THE BEGINNING OF A DWG FILE NAME									;;
;;Written CAB 7/2/18												;;
;;**************************************************************************************************************;;
(defun c:clipString ( / clip path masterlist x sublist str)
  ;Get the string to clip
  (setq clip (getstring "What would you like to remove? "))
  ;Get the user specified directory
  (setq path (vl-filename-directory (getfiled "Select a dwg in the directory" "" "dwg" 0)))
  ;Get all drawings in directory
  (setq masterlist (vl-directory-files path "*.dwg" 1))
  ;Remove current drawing from list
  (setq masterlist (vl-remove (getvar "dwgname") masterlist))
  ;Find all drawings with print2cad in name in list
  (setq x (length masterlist))
    (foreach item masterlist
      (if (= (substr item 1 9) clip)
	(setq sublist (cons item sublist))
	)
      )
  ;Rename our drawings
  (setq path (strcat path "\\"))
  (foreach item sublist
    (setq str item)
    (setq str (vl-string-left-trim clip str))
    (vl-file-rename (strcat path "/" item) (strcat path "/" str))
    )
  
  (princ)
  )
