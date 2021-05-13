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
	     (Pkg.add (string "PyPlot"))
	     
	     ))))
    (write-source (format nil "~a/source/~a" *path* *code-file*) code)
    (write-source
     (format nil "~a/source/~a" *path* "run_01_poisson")
     `(do0
       "using AdFem"
       "using PyPlot"

       (setf mesh (Mesh (joinpath PDATA (string "twoholes_large.stl")))
	     xy (gauss_nodes mmesh)
	     k (space "@."
		      (+ (* (sin (aref xy ":" 1))
			    (+ 1 (^ (aref xy ":" 2) 2)))))
	     f (* 1e5 (space "@." (+ (aref xy ":" 1)
				     (aref xy ":" 2))))
	     K (compute_fem_laplace_matrix k mmesh)
	     F (compute_fem_source_term1 f mmesh)
	     bdnode (bcnode mmesh)
	     (ntuple K F) (impose_Dirichlet_boundary_conditions K F bdnode
								(zeros (length bdnode)))
	     sol "K\\F"))
     )))



