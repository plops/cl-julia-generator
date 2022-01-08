(eval-when (:compile-toplevel :execute :load-toplevel)
  (ql:quickload "cl-julia-generator")
  (ql:quickload "alexandria")
  (ql:quickload "uuid"))
(in-package :cl-julia-generator)

(string-downcase (format nil "~a" (uuid:make-v4-uuid)))
(string-downcase (format nil "~a" (uuid:make-v1-uuid)))

(progn
  (defparameter *path* "/home/martin/stage/cl-julia-generator/example/02_pluto_notebook")
  ;(defparameter *code-file* "run_00_adfem")
  (defparameter *source* (format nil "~a/source/~a" *path* *code-file*))

  (defparameter *day-names*
    '("Monday" "Tuesday" "Wednesday"
      "Thursday" "Friday" "Saturday"
      "Sunday"))
  
  (write-source
   (format nil "~a/source/~a" *path* "run_00")
   `(do0
     "### A Pluto.jl notebook ###"
     "# v0.17.5"
     "" 
     "using Markdown"
     "using InteractiveUtils"
     ""
     (do0 " ╔═╡ 45ce7b9c-7066-11ec-29b0-13acfccc64a9"
	  (setf a 2))
     (do0 " ╔═╡ 99f6fe7c-37dd-49a9-b0ba-af87eb3f7bab"
	  (setf b (+ a 3)))
     )
   )
  )



