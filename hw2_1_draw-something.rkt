#lang racket

(require 2htdp/image)

;; (wow-emoji 100)
(define (wow-emoji r)
  (define face (circle r "solid" "gold"))
  (define eye (circle (/ r 8) "solid" "black"))
  (define eyes
    (beside/align "center"
                  eye
                  (rectangle (/ r 2.5) 0 "solid" "transparent")
                  eye))
  (define mouth-big (ellipse (/ r 1.2) (/ r 2) "solid" "black"))
  (define face-with-eyes (overlay/offset eyes
                                         0 (/ r 2.2)
                                         face))
  (define face-with-mouth (overlay/offset mouth-big
                                      0 (- (/ r 3))
                                      face-with-eyes))
  face-with-mouth
  )
(wow-emoji 100)