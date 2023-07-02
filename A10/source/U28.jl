using Pkg
Pkg.add("LaTeXStrings")
Pkg.add("LinearAlgebra")
Pkg.add("ForwardDiff")
using LaTeXStrings
using LinearAlgebra
using ForwardDiff

function newton(f,x₀,TOL,x_max)
    x = x₀
    i = 0
    while norm(f(x)) > TOL && i <= x_max
        Df = ForwardDiff.jacobian(f,x)
        v  = Df \ -f(x)
        x  = x + v
    end
    return x
end

function explizit_euler(f,h,k,x₀)
    x = x₀
    for _ in 0:k-1
        x = x .+ h .* f(x)
    end
    return x
end

function implizit_euler(f,h,k,x₀,TOL,x_max)
    xₖ    = x₀
    xₖ₊₁  = NaN
    for _ in 0:k-1
        F(x) = xₖ + h * f(x) - x
        xₖ₊₁ = newton(F,xₖ,TOL,x_max)
    end
    return xₖ₊₁
end

function y_feld(x)
    return [x[2];-x[1]]
end

# Test:
k  = 300
h  = 0.000001
yₖ = explizit_euler(y_feld,h,k,[1;0])
print("Explizites Euler-Verfahren: ",norm(yₖ),"\n")

yₖ = implizit_euler(y_feld,h,k,[1;0],10^-10,100)
print("Implizites Euler-Verfahren: ",norm(yₖ),"\n")
