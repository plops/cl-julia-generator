(eval-when (:compile-toplevel :execute :load-toplevel)
  (ql:quickload "cl-julia-generator")
  (ql:quickload "alexandria"))
(in-package :cl-julia-generator)



(progn
  (defparameter *path* "/home/martin/stage/cl-julia-generator/example/01_adfem")
  (defparameter *code-file* "run_00_adfem")
  (defparameter *source* (format nil "~a/source/~a" *path* *code-file*))

  (defparameter *day-names*
    '("Monday" "Tuesday" "Wednesday"
      "Thursday" "Friday" "Saturday"
      "Sunday"))

     
  (let* (
	 
	 (code
	  `(do0
	    (do0
	     "using Pkg"
	     (Pkg.add (string "ADCME")
		      )
	     (Pkg.add (string "AdFem"))
	     
	     ))))
    (write-source (format nil "~a/source/~a" *path* *code-file*) code)))



