;;These commands run a batch process on all dwgs within a given directory
;;Simply run the scripter command, point to a dwg in the directory you want, then enter the string of commands you want (encapsulated by quotation marks)
;;e.g. "-layer on BACKGROUND  qsave close"

;;**************************************************************************************************************;;
;;scripter													;;
;;Batch processes all drawings in a folder according to user input						;;
;;Written CAB 12/7/17												;;
;;**************************************************************************************************************;;
(defun c:scripter ( / script file path com masterlist i x line)
  ;Get user input on the folder to process
  (setq path (vl-filename-directory (getfiled "Select a dwg in the directory" "" "dwg" 0)))
  ;Get a list of all drawings in selected folder
  (setq masterlist (vl-directory-files path "*.dwg" 1))
  (setq masterlist (vl-remove (getvar "dwgname") masterlist))
  ;Get the user input of what commands to run, in the form of a string
  (setq com (getstring "What is your command? "))
  (setq com (strcat " " com))
  ;Write a script to execute
  (setq script (open (strcat path "/" "script.scr") "w"))
  (setq x (length masterlist))
  (foreach i masterlist
    ;On our last command, we change it slightly so that we delete the script file afterwards
    (if (and (= x 1) (vl-string-search "close" com))(setq com (vl-string-right-trim " close" com) com (strcat com "e")))
    (setq line (strcat "_.open " "\"" path "/" i "\"" com))
    (write-line line script)
    (setq x (- x 1)))
  (write-line (strcat "done " "\"" path "/" "script.scr" "\"") script)
  (close script)
  ;Execute our script
;;;  (print (strcat path "/" "script.scr"))
  (CAB:recordCommand nil '("scripter"))
  (command "_.script" (strcat path "/" "script.scr"))
  )
(princ)

;;**************************************************************************************************************;;
;;done														;;
;;Deletes user defined file, then closes the current file							;;
;;Written CAB 12/7/17												;;
;;**************************************************************************************************************;;
(defun c:done ( / file )
  (setq file (getstring "What file? "))
  (command "delay" 100)
  (vl-file-delete file)
  (command "close" "n")
  )
(princ)
