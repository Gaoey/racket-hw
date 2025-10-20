#lang racket

(require 2htdp/image)

(define (area-of-circle r)
  (* pi (sqr r)))

(define area-of-square sqr)

(define (area-of-donut r1 r2)
  (abs ( - (area-of-circle r1)
           (area-of-circle r2)
           )))

(define (half n)
  (/ n 2))
(define (double n)
  (* n 2))

(define (hypoteneuse a b)
  (sqrt (+ (sqr a) (sqr b))))

(define (area-shaded r)
  (- (area-of-circle (half r))
     (area-of-square (hypoteneuse (half r) (half r)))
  ))

(define (mysquare r)(rectangle r r "solid" "white"))

(define (mycircle r)(circle r "solid" "red"))

(define (overlay-center a b) (overlay/align "center" "center" a b))

(define (square-with-circle r)
  (overlay-center (mycircle r)
                  (mysquare (double r))))

(define (circle-with-square r)
  (overlay-center (mysquare (hypoteneuse r r))
                  (mycircle r)))

(define nested overlay-center)

; soc = square of circle
(struct soc (total radius scale) #:transparent)

;Ex. (draw-nested-circle-of-square 2 20 0.7 45)
(define (draw-nested-circle-of-square total r scale angle)
  (cond
    [(= total 0) (circle-with-square  r)]
    [else
      (nested
       (rotate angle (draw-nested-circle-of-square (- total 1)
                                                   (* r scale)
                                                   scale
                                                   angle))
       (circle-with-square r))]))

;hw2_2_1 = (draw-nested-circle-of-square-with-bg 2 20 0.7 45)
(define (draw-nested-circle-of-square-with-bg  total r scale angle)
   (overlay-center (draw-nested-circle-of-square total r scale angle)
                  (mysquare (double r))))

;hw2_2_1 using struct = (draw-soc (soc 2 20 0.7) 45)
(define (draw-soc s angle)
  (define total (soc-total s))
  (define radius (soc-radius s))
  (define scale (soc-scale s))
  (draw-nested-circle-of-square-with-bg total radius scale angle))

(define (curr-radius r scale i)
  (* r (expt scale i)))

(define (curr-area-shaded r scale i)
   (define radius (curr-radius r scale i))
   (area-shaded radius))
  
(define (area-shaded-in-each i r scale)
  (cond
    [(= i 0) (curr-area-shaded r scale 0)]
    [else
       (+ (curr-area-shaded r scale i)
          (area-shaded-in-each (- i 1) r scale))]))

;hw2_2_2 using struct = (area-shaded-soc (soc 2 20 0.7))
(define (area-shaded-soc s)
  (define total (soc-total s))
  (define radius (soc-radius s))
  (define scale (soc-scale s))
  (area-shaded-in-each total radius scale)
 )