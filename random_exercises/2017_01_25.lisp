;; Just playing around with common-lisp, trying to learn
;; a little about the stdlib.   -- rwt 2017-01-25

;; https://programmingpraxis.com/2017/01/20/exercise-2-4/

;; remove all instances of 'e' from 'str'
(defun squeeze (str e)
  (remove-if #'(lambda (ch) (eq ch e)) str))

;; remove all instances of chars in lst from 'str'
(defun squeeze-all (str lst)
  (remove-if #'(lambda (ch) (find ch lst)) str))


;; https://programmingpraxis.com/2017/01/17/exercise-1-9/

;; copy the input to output, outputting no more than one
;; space at a time.
(defun compress-spaces ()
  (labels ((skip-spaces (ch)
			(if (eq ch #\Space) #'skip-spaces (scan ch)))
	   (scan (ch)
		 (princ ch)
		 (if (eq ch #\Space) #'skip-spaces #'scan)))
	  (let ((cur-state #'scan))
	    (do ((ch (read-char *standard-input* nil) (read-char *standard-input* nil)))
		((not ch) nil)
		(setq cur-state (funcall cur-state ch))))))



;; given a word, give the telephone numbers needed to 'spell' it
(defun spell-on-phone (str)
  (flet ((chr-2-num (ch)
		    (case (char-upcase ch)
			  ((#\A #\B #\C)     #\2)
			  ((#\D #\E #\F)     #\3)
			  ((#\G #\H #\I)     #\4)
			  ((#\J #\K #\L)     #\5)
			  ((#\M #\N #\O)     #\6)
			  ((#\P #\Q #\R #\S) #\7)
			  ((#\T #\U #\V)     #\8)
			  ((#\W #\X #\Y #\Z) #\9))))
	(map 'string #'chr-2-num str)))
			 
	   
	   
