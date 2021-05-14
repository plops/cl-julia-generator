using LinearAlgebra
using ADCME
n=101
h=((1)/(((n)-(1))))
x=LinRange(0, 1, n)[2:((end)-(1))]
b=Variable((10.    ))
A=diagm(0=>((((2)/(((h) ^ (2)))))*(ones(((n)-(2))))), -1=>((((-1)/(((h) ^ (2)))))*(ones(((n)-(3))))), 1=>((((-1)/(((((h) ^ (2)))))))*(ones(((n)-(3))))))
B=((((b)*(A)))+(I))
f=@.(((4)*(((2)+(x)+(((-1)*(((x) ^ (2)))))))))
u=((B)\(f))
ue=u[div(((n)+(1)), 2)]
loss=((((ue)-((1.0    )))) ^ (2))
sess=Session()
init(sess)
BFGS!(sess, loss)
println("estimated b=", run(sess, b))