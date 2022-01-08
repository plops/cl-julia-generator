(eval-when (:compile-toplevel :execute :load-toplevel)
  (ql:quickload "cl-julia-generator")
  (ql:quickload "alexandria")
  ;(ql:quickload "uuid")
  )
(in-package :cl-julia-generator)
(progn
  (defparameter *path* "/home/martin/stage/cl-julia-generator/example/02_pluto_notebook")
  ;(defparameter *code-file* "run_00_adfem")
  ;(defparameter *source* (format nil "~a/source/~a" *path* *code-file*))

  (defparameter *day-names*
    '("Monday" "Tuesday" "Wednesday"
      "Thursday" "Friday" "Saturday"
      "Sunday"))
  
  (write-source
   (format nil "~a/source/~a" *path* "run_00")
   `(do0
     "### A Pluto.jl notebook ###"
     "# v0.17.5"
     "
" 
     "using Markdown"
     "using InteractiveUtils"
     "
"
     ,(cells
      `((setf a 2)
	(setf b (+ a 7)))))))



