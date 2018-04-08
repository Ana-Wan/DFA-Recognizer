#lang racket
 (require racket/hash)

(define-struct key (state alphabet) #:transparent)


;; (scan-section n li) scans n lines and stores data in a list
(define (scan-section n li)
  (cond
    [(= n 0) li]
    [else
     (define line (read-line))
     (scan-section (- n 1) (cons line li))
     ]
    ))

; (read-transition line) helper function to read a transition
; reads a string until first whitespace, then outputs that string
(define  (read-transition line word)
  (cond [(empty? line) (list->string (reverse word))]
        [(not (equal? #\space (first line))) (read-transition (rest line) (cons (first line) word))]
        [else (list->string (reverse word))]
        ) 
  )

 

; (scan-transitions n li) scans the n transitions and stores it in a hash table
(define (scan-transitions n li)
  (cond [(= n 0) (hash-remove li '())]
        [else
         (define line (read-line))
         (define transition-list (input line empty))
         
         (define current (first transition-list))
         (define alpha (second transition-list))
         (define next (third transition-list))
         

         (scan-transitions (- n 1) (hash-union
                                    li
                                    (hash (key current alpha) next)))
         ]))



; puts each alphabet from scanned in list (as a string)
(define (input scanned li)
  (cond
    [(not (eof-object? scanned))
         (define alphabet (read-transition (string->list scanned) empty))
  
         (if (not (= (string-length alphabet) (string-length scanned)))
             (input (substring scanned (+ (string-length alphabet) 1)) (cons alphabet li))
             (reverse (cons alphabet li)))
        


         ])
  
  )


; scans the dfa
(define (scan-all)
  (define numAlpha (string->number (read-line))) ; number of alphabets
  (define alpha (scan-section numAlpha empty)) ; stores alphabets

  (define numStates (string->number (read-line))) ; number of states
  (define states (scan-section numStates empty)) ; stores all states

  (define startState (read-line)) ; initial state

  (define numAccepting (string->number (read-line))) ; number of accepting states
  (define accepting (scan-section numAccepting empty)) ; stores the accepting states

  (define numTransitions (string->number (read-line))) ; number of transitions
  (define transitions (scan-transitions numTransitions (hash empty empty))) ; stores all transitions as a hash table
  (hash-remove transitions '())

  (scan-file alpha startState accepting transitions) ; reads additional input

  )
;(states-scan n state accepting transitions) outputs true if a line is in the language
(define (states-scan state accepting line transitions)
  (cond [(= 0 (length line)) "false\n"]
        [(or  (not (hash-has-key? transitions (key state (first line))))
              (and (= 0 (length line))
              (not (member (hash-ref transitions (key state (first line))) accepting)))) "false\n"]
        [(and
          (= 1 (length line))
          (member (hash-ref transitions (key state (first line))) accepting)) "true\n"]
        [(hash-ref transitions (key state (first line)))
         (states-scan (hash-ref transitions (key state (first line))) accepting (rest line) transitions)])
  
  )
 
; (scan-file alpha states startState accepting transitions) outputs true if string is in the language
; else false

(define (scan-file alpha state accepting transitions)
  (define scanned (read-line))
  (cond
    [(eof-object? scanned) (void)]
    [(= 0 (string-length scanned))
     (display "false\n")
     (scan-file alpha state accepting transitions)
     ]
    [else
     (define line (remove* (list "" " ") (input scanned empty)))
     (cond
       [else
        (display (states-scan state accepting line transitions))
        (scan-file alpha state accepting transitions)
        ])]
    )
)






(scan-all)












