;;**************************************************************************************************************;;
;;neat                                                                                                                                                                                                                    ;;
;;Simple implementation of the NEAT algorithm                                                                                                                                  ;;
;;Written A-Nony-Mus 4/23/19                                                                                                                                                                                    ;;
;;**************************************************************************************************************;;
(defun c:neat ( / phrase chars mutation maxpop gen x i str strlst char phrase_lst fitness avg_fitness breeding_pool fittest_str greatest_fitness)
  ;Initialize the settings of our genetic algorithm
  ;Feel free to play with the maxpop and mutation values
  (setq phrase (getstring "Please enter the desired phrase: ")
                chars (list "A""B""C""D""E""F""G""H""I""J""K""L""M""N""O""P""Q""R""S""T""U""V""W""X""Y""Z""a""b""c""d""e""f""g""h""i""j""k""l""m""n""o""p""q""r""s""t""u""v""w""x""y""z"" "">""?""!")
                mutation 0.1
                maxpop 100
                gen 1
                x maxpop
                phrase_lst (vl-string->list phrase)
                fitness 0
                greatest_fitness 0)
 
  ;Randomly generate our first population
  (while (> x 1)
    (setq str nil
                  i (strlen phrase))
    (while (> i 0)
      (setq str (cons (ascii (nth (lm:randrange 0 (1- (length chars))) chars)) str)
                    i (1- i))
      )
    (setq strlst (cons (vl-list->string str) strlst)
                  x (1- x))
    )
 
  ;Continuously breed until we have found the desired phrase
  (while (< greatest_fitness (length phrase_lst))
    (setq avg_fitness 0
          breeding_pool nil)
    ;Calculate the fitness of each member of the population
    ;Simply the number of characters in the correct position
    (foreach str strlst
      (setq str (vl-string->list str)
                    i (strlen phrase))
      (while (> i 0)
                (if (= (nth (1- i) str) (nth (1- i) phrase_lst))
                  (setq fitness (1+ fitness)))
                (setq i (1- i))
                )
      (setq avg_fitness (+ avg_fitness fitness))
      ;If we have a more fit member, that is now the most fit member
      (if (> fitness greatest_fitness)
                (setq greatest_fitness fitness fittest_str (vl-list->string str)))
      ;Generate a breeding pool, members with a higher fitness have a higher chance of breeding
      (while (> fitness 0)
                (setq breeding_pool (cons (vl-list->string str) breeding_pool)
                      fitness (1- fitness))
                )
      )
    ;Add our fittest member into the breeding pool
    (setq fitness avg_fitness)
    (while (> fitness 0)
      (setq breeding_pool (cons fittest_str breeding_pool)
                    fitness (1- fitness))
      )
    ;Give us the current progress of the program
    (print (strcat "Average Fitness: " (rtos (* 100 (/ (/ (* 1.0 avg_fitness) maxpop) (length phrase_lst))) 2 2) "%, Generation: " (rtos gen 2 0) ", Best Fitness: " (rtos greatest_fitness 2 0) ", Best String: " fittest_str))
 
    (setq x maxpop
                  strlst nil
                  gen (1+ gen))
    ;Breed the next generation
    (while (> x 0)
      ;Pick 2 members of the current population and breed them
      (setq str (strcat (substr (nth (lm:randrange 0 (1- (length breeding_pool))) breeding_pool) 1 (/ (length phrase_lst) 2))
                                                (substr (nth (lm:randrange 0 (1- (length breeding_pool))) breeding_pool) (1+ (/ (length phrase_lst) 2)) (length phrase_lst)))
                    str (vl-string->list str))
      ;Mutate the child
      ;Each "gene" of the child has an x percent chance of randomly mutation where x=mutation (defined earlier) * 100
      (foreach char str
                (if (<= (lm:randrange 1 100) (* 100 mutation))
                  (setq char (ascii (nth (lm:randrange 0 (1- (length chars))) chars)))
                  )
                (setq new_str (cons char new_str))
                )
      (setq strlst (cons (vl-list->string (reverse new_str)) strlst)
                    x (1- x)
                    new_str nil))
    ;This was in an attempt to stop the memory leak that seriously slows this program down after about 200 generations
    ;It didn't work
    (gc)
    )
  (princ)
  )
