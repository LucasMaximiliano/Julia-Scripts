using Pkg
Pkg.add("Plots")
Pkg.add("LaTeXStrings")
Pkg.add("LinearAlgebra")
using Plots
using LaTeXStrings
using LinearAlgebra

# Stützstelle:
n = 3 # Grad vom Polynom
x = rand(n+1)
y = rand(n+1)

# Naïve Lösung (Monombasis):
function monom(x,n)
    return x^n
end

function naiev(x,y,n)
    M = monom.(x,permutedims(1:n+1))
    λ = M \ y
    κ = norm(M) * norm(inv(M))
    return λ, κ
end

naiev(x,y,n)