;;**************************************************************************************************************;;
;;mPlot													;;
;;This function will plot every page setup defined in the drawing					;;
;;Written CAB 10/1/18												;;
;;**************************************************************************************************************;;
(defun c:mPlot ( / temp file )
  ;Make sure this folder exists before running this command
  (setq file "YOUR FOLDER HERE")
  (print (setq temp (dictsearch (namedobjdict) "ACAD_PLOTSETTINGS")))
  (foreach n temp (if (= (car n) 3)
		    (progn
		      (print (cdr n))
		      (command "-plot" "n" "Model" (cdr n) "DWG To PDF.PC3" (strcat "H:\\temp\\" (cdr n)) "n" "y")
		      )
		    )
    )
  )
