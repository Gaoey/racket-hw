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

(define (hypotenuse a b)
  (sqrt (+ (sqr a) (sqr b))))

(define (area-shaded r)
  (- (area-of-circle (half r))
     (area-of-square (hypotenuse (half r) (half r)))
  ))

(define (mysquare r)(rectangle r r "solid" "white"))

(define (mycircle r)(circle r "solid" "red"))

(define (overlay-center a b) (overlay/align "center" "center" a b))

(define (square-with-circle r)
  (overlay-center (mycircle r)
                  (mysquare (double r))))

(define (rotate-square-with-circle angle r)
   (rotate angle (square-with-circle r)))

(define nested overlay-center)

(define (nested-square-with-circle angle outer-r inner-r)
  (nested
    (rotate-square-with-circle angle inner-r)
    (square-with-circle outer-r)))

(define (nested-square-with-circle-v2 outer-r comp)
  (nested comp (square-with-circle outer-r)))