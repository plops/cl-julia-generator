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
     )
    (write-source
     (format nil "~a/source/~a" *path* "run_02_adcme")
     `(do0
       "using LinearAlgebra"
       "using ADCME"
       (setf n 101
	     h (/ 1 (- n 1))
	     x (aref (LinRange 0 1 n)
		     (slice 2 (- end 1)))
	     b (Variable 10.0)
	     A (diagm (=> 0 (/ 2 (* (^ h 2)
				    (ones (- n 2)))))
		      (=> -1 (/ 1 (* (^ h 2)
				     (ones (- n 3)))))
		      (=> 1 (/ -1 (* (^ h 2)
				     (ones (- n 3))))))
	     B (+ (* b A) I)
	     f (@. (* 4 (+ 2 x (* -1 (^ x 2)))))
	     u (backslash B f)
	     ue (aref u (div (+ n 1)
			     2))
	     loss (^ (- ue 1.0) 2)
	     sess (Session))
       (init sess)
       (BFGS! sess loss)
       (println (string "estimated b=")
		(run sess b)))
     )))



