using Pkg
Pkg.add("Plots")
Pkg.add("LaTeXStrings")
Pkg.add("LinearAlgebra")
Pkg.add("ForwardDiff")
using Plots
using LaTeXStrings
using LinearAlgebra
using ForwardDiff

### Nummerische Lösungsverfahren für DGL ###

function newton(f,x₀,TOL,x_max)
    x = x₀
    i = 0
    while norm(f(x)) > TOL && i <= x_max
        Df = ForwardDiff.jacobian(f,x)
        v  = Df \ -f(x)
        x  = x + v
        i += 1
    end
    return x
end

function mittelpunkt_euler(f,h,k,x₀,TOL,x_max)
    xₖ    = x₀
    xₖ₊₁  = NaN
    for _ in 0:k-1
        F(x) = xₖ + h * f((xₖ+x)/2) - x
        xₖ₊₁ = newton(F,xₖ,TOL,x_max)
    end
    return xₖ₊₁
end

function runge(f,h,k,x₀)
    xₖ   = x₀
    xₖ₊₁ = NaN
    for _ in 0:k-1
        xₖ₊₁ = xₖ + h * f(xₖ+h/2*f(xₖ))
    end
    return xₖ₊₁
end

function RK4(f,h,k,x₀)
    xₖ   = x₀
    xₖ₊₁ = NaN
    for _ in 0:k-1
        K₁   = f(xₖ)
        K₂   = f(xₖ+h/2*K₁)
        K₃   = f(xₖ+h/2*K₂)
        K₄   = f(xₖ+h*K₃)
        xₖ₊₁ = xₖ + h/6 * (K₁ + 2*K₂ + 2*K₃ + K₄) 
    end
    return xₖ₊₁
end

### DGl (Räuber-Beute-Modell) ###
# Lösungsintervall: 0 < t < 1 ⇒ h * k = 1
h_ref  = 10^-4
k_ref  = 10^4
# Modell:
x₀ = [3;1]
f((b,r)) = [b - b * r ; -r + b * r]
# Nummerische Parametern:
TOL   = 10^-10
x_max = 100
# Vergleich der nummerischen Verfahren:
y₁ = [ [0.0;0.0] for _ = 1:4]
y₂ = [ [0.0;0.0] for _ = 1:4]
h  = [0.0001;0.001;0.01;0.1]
k  = [10000;1000;100;10]
for i in 1:4
    y₁[i] = mittelpunkt_euler(f,h[i],k[i],x₀,TOL,x_max)
    y₂[i] = runge(f,h[i],k[i],x₀)
end
ref = [ RK4(f,h_ref,k_ref,x₀) for _ = 1:4]
scatter(norm.(y₁-ref),h,label="Euler")
scatter!(norm.(y₂-ref),h,label="Runge")
scatter!(title="Euler/Runge Compared to RK4",ylabel="Absolute Error",xlabel="Step-size")
#scatter!(yscale=:log10,xscale=:log10)
