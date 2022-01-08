(eval-when (:compile-toplevel :execute :load-toplevel)
  (ql:quickload "cl-julia-generator")
  (ql:quickload "alexandria")
  (ql:quickload "uuid"))
(in-package :cl-julia-generator)

(string-downcase (format nil "~a" (uuid:make-v4-uuid)))

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
	     (Pkg.add (string "ADCME"))
	     (Pkg.build (string "ADCME"))
	     (Pkg.add (string "AdFem"))
	     (Pkg.build (string "AdFem"))
	     (Pkg.add (string "PyPlot"))
	     (Pkg.build (string "PyPlot"))
	     
	     ))))
    (write-source (format nil "~a/source/~a" *path* *code-file*) code)
    (write-source
     (format nil "~a/source/~a" *path* "run_01_poisson")
     `(do0
       "### A Pluto.jl notebook ###"
       "# v0.17.5"
       ""
       "using Markdown"
       "using InteractiveUtils"
       ""
       " ╔═╡ 45ce7b9c-7066-11ec-29b0-13acfccc64a9"
       (setf mesh (Mesh (joinpath PDATA (string "twoholes_large.stl")))
	     xy (gauss_nodes mmesh)
	     k (@.
		(+ (* (sin (aref xy ":" 1))
		      (^ (aref xy ":" 2) 2))
		   1.0))
	     f (* 1e5 (@. (+ (aref xy ":" 1)
			     (aref xy ":" 2))))
	     K (compute_fem_laplace_matrix k mmesh)
	     F (compute_fem_source_term1 f mmesh)
	     bdnode (bcnode mmesh)
	     (ntuple K F) (impose_Dirichlet_boundary_conditions K F bdnode
								(zeros (length bdnode)))
	     sol (backslash K F))
       (do0
	(setf nn_k)))
     )
   ))



