(eval-when (:compile-toplevel :execute :load-toplevel)
  (ql:quickload "cl-julia-generator")
  (ql:quickload "alexandria")
  (ql:quickload "uuid"))
(in-package :cl-julia-generator)

(defun cell (&key uuid code)
  `(do0
    (comments ,(format nil "╔═╡ ~a" uuid))
    ,code
    "
"
    ))
#+nil
(cell :uuid1 (string-downcase (format nil "~a" (uuid:make-v1-uuid)))
      :code
      `(setf a 3))


(defun cells (codes)
  "emit sequential cells and their dependency graph link"
  (let ((data (loop for code in codes
		    collect
		    ;; uuid v1 doesn't work (probably too fast execution to generate unique ids)
		    (let ((uuid (string-downcase (format nil "~a" (uuid:make-v4-uuid)))))
		      `(:uuid ,uuid
			:content ,(cell :uuid uuid
					:code code))))))
    `(do0
      ,@(mapcar #'(lambda (x) (getf x :content))
		data)
      (do0
       (comments "╔═╡ Cell order:"
		 ,@(mapcar #'(lambda (x)
			       (format nil "╠═~a" (getf x :uuid)))
			   data))))))

#+nil
(cells
      `((setf a 2)
	(setf b (+ a 7))))

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



