using Pkg
Pkg.add("LinearAlgebra")
using LinearAlgebra

function nachiteration(n,A,b,TOL)
    iter   = 0
    x      = A \ b
    r      = b - A*x
    
    while norm(r) > TOL
        @show iter += 1
        z =  A \ r
        x += z
        r =  b - A*x
    end

    return x, norm(r)
end

n   = 3
A   = rand(n,n)
b   = rand(n)
TOL = 10 ^ -16

nachiteration(n,A,b,TOL)