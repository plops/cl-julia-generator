;(ql:quickload "optima")
;(ql:quickload "alexandria")
(defpackage :cl-julia-generator
  (:use :cl
	;:optima
	:alexandria)
  (:export
   #:tuple
   #:indent
   #:do
   #:do0
   #:def
   #:slice
   #:dot
   #:**
   #:imports
   #:write-source
   ))
