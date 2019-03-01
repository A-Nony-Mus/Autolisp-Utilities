;;This will set up a command reactor that will automatically record every time you use a command to an external file
;;It will save it to a csv that can be imported into excel to give you a breakdown of your most used commands

;;**************************************************************************************************************;;
;;N/A														;;
;;This is a reactor for recording all commands used								;;
;;Written CAB 3/15/18												;;
;;**************************************************************************************************************;;
(defun CAB:setCommandReactor ( / )
  (setq *commandReactor (vlr-command-reactor "command reactor" '((:VLR-commandEnded . CAB:recordCommand))))
  )
(CAB:setCommandReactor)

;;**************************************************************************************************************;;
;;CAB:recordCommand                                                                                             ;;
;;This saves the last command executed to a file                                                                ;;
;;Written CAB 3/15/18												;;
;;**************************************************************************************************************;;
(defun CAB:recordCommand (foo bar / file date dir)
  (setq dir "SET YOUR FILE DIRECTORY HERE")
  (if (or (= lispcurrent nil) (= foo nil))
    (progn
      (if (setq file (open (strcat dir (getvar "loginname") "-commands.csv") "r"))
        (progn
          (close file)
          (setq file (open (strcat dir (getvar "loginname") "-commands.csv") "a"))
        )
        (progn
          (setq file (open (strcat dir (getvar "loginname") "-commands.csv") "w"))
          (write-line "date,command" file)
        )
      )
      (setq date (rtos (getvar "cdate") 2 0))
      (setq date (strcat (substr date 5 2) "/" (substr date 7 2) "/" (substr date 1 4)))
      (write-line (strcat date "," (strcase (nth 0 bar))) file)
      (close file)
    )
  )
)
