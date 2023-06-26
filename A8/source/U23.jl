using Pkg
Pkg.add("LinearAlgebra")
using LinearAlgebra

# Simpson'sche Quadratur-Formel:
function simpson(f,a,b)
    if a > b
        buf = a
        a   = b
        b   = buf
    end
    return (b-a)/6 * (f(a) + 4*f((a+b)/2) + f(b))
end

# Test Functionen:
function f1(x)
    return 3*x^3 + 2*x^2 + x
end

function intf1(x)
    return 3/4*x^4 + 2/3*x^3 + 1/2*x^2
end
# ================================================
function f2(x)
    return exp(2*x)
end

function intf2(x)
    return 1/2*exp(2*x)    
end
# ================================================
function f3(x)
    return sin(4*x) + cos(4*x)
end

function intf3(x)
    return -1/4*cos(4*x) + 1/4*sin(4*x)
end
# ================================================
function f4(x)
    return 4 / (x+1)
end

function intf4(x)
    return 4*log(x+1)
end

# Integrale auswerten:
a = 0
b = 100

Q₁ = simpson(f1,a,b)
Q₂ = simpson(f2,a,b)
Q₃ = simpson(f3,a,b)
Q₄ = simpson(f4,a,b)

F₁ = intf1(b) - intf1(a)
F₂ = intf2(b) - intf2(a)
F₃ = intf3(b) - intf3(a)
F₄ = intf4(b) - intf4(a)

# Vergleich mit genauen Integration per Hand:
@show r₁ = abs(F₁-Q₁) / abs(F₁)
@show r₂ = abs(F₂-Q₂) / abs(F₂)
@show r₃ = abs(F₃-Q₃) / abs(F₃)
@show r₄ = abs(F₄-Q₄) / abs(F₄)