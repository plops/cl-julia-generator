using AdFem
using PyPlot
mesh=Mesh(joinpath(PDATA, "twoholes_large.stl"))
xy=gauss_nodes(mmesh)
k=@. ((((sin(xy[:,1]))*(((1)+(((xy[:,2]) ^ (2))))))))
f=(((1.00e+5))*(@. ((xy[:,1])+(xy[:,2]))))
K=compute_fem_laplace_matrix(k, mmesh)
F=compute_fem_source_term1(f, mmesh)
bdnode=bcnode(mmesh)
K, F=impose_Dirichlet_boundary_conditions(K, F, bdnode, zeros(length(bdnode)))
sol=K\F