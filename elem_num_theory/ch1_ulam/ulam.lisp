; ULAM NUMBERS
; EXAMPLE: (ltake (ulam 1 2) 500) => 500 ulam numbers

; The data structure for the backlog is a simple cons pair
(defmacro ulam-ent (n u) `(cons ,n ,u))
(defmacro ulam-num (ent) `(car ,ent))
(defmacro ulam-rpt (ent) `(cdr ,ent))

; Merge new candidate NUMS into the backlog ENTS
(defun ulam-merge (nums ents)
  (let ((result nil))
    (do ()
        ((null ents) (dolist (n nums) (push (ulam-ent n nil) result)) 
                     (nreverse result))
        (let ((a (car nums))
              (b (ulam-num (car ents))))
          (cond ((= a b)
                  (push (ulam-ent a t) result)
                  (pop nums) 
                  (pop ents))
                ((< a b)
                  (push (ulam-ent a nil) result)
                  (pop nums))
                ((> a b)
                  (push (car ents) result)
                  (pop ents)))))))

; Get the first backlog number that's not a repeat, and
; return it CONS'ed to the rest of the backlog.  This should
; probably be a multple value return instead...
(defun ulam-first (ents) 
  (do ((e (pop ents) (pop ents)))
      ((not (ulam-rpt e)) (cons (ulam-num e) ents))))
    
; Generate fresh backlog entries from the list of ulam numbers
; so far.
(defun ulam-backl (sofar)
  (let ((result nil)
        (recent (car sofar)))
    (dolist (v (cdr sofar) result) (push (+ v recent) result))))
      
; LCONS, LCDR and LTAKE are a couple helper functions since I'm 
; not using a lazy-list library... 
(defmacro lcons (hd tl) `(cons ,hd (lambda () ,tl)))
(defun lcdr (s) (funcall (cdr s)))
(defun ltake (ll n)
  (let ((result (list (car ll))))
    (dotimes (idx (- n 1) (nreverse result)) 
       (setq ll (lcdr ll))
       (push (car ll) result))))

; Generate the next lazy-cons in the ulam stream.
(defun ulam-next (sofar backlog)
  (let* ((batch (ulam-backl sofar))
         (merged (ulam-merge batch backlog))
         (result (ulam-first merged))
         (nval   (pop result)))
    (lcons nval (ulam-next (cons nval sofar) result))))

; Generate a lazy ulam-a,b sequence
(defun ulam (a b) (lcons a (lcons b (ulam-next (list b a) nil))))

