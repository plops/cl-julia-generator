(asdf:defsystem cl-julia-generator
    :version "0"
    :description "Emit Julia code"
    :maintainer " <kielhorn.martin@gmail.com>"
    :author " <kielhorn.martin@gmail.com>"
    :licence "GPL"
    :depends-on ("alexandria" ;"jonathan"
		 "uuid")
    :serial t
    :components ((:file "package")
		 (:file "jl")
		; #+sbcl (:file "pipe")
		 ) )
