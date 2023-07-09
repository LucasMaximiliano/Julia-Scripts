using Pkg
Pkg.add("Plots")
Pkg.add("LaTeXStrings")
Pkg.add("LinearAlgebra")
using Plots
using LaTeXStrings
using LinearAlgebra

# Quadratur mit alternierenden Box-Regel:
function alt_box(f,a,b,n)
    if a > b
        buf = a
        a   = b
        b   = buf
    end
    int_size = abs(b-a)/n
    # Startintervall:
    b = a + int_size
    integral = 0
    flag     = "rechts"
    for _ in 1:n
        if flag == "rechts"
            integral += (b-a) * f(b)
            # Intervall verschieben:
            a    = b
            b   += int_size
            flag = "links"
        else
            integral += (b-a) * f(a)
            # Intervall verschieben:
            a    = b
            b   += int_size
            flag = "rechts"
        end
    end
    return integral
end

# Test Functionen:
function pol_0(x)
    return 1
end

function int_pol_0(x)
    x
end
# =============================================
function pol_1(x)
    return x
end

function int_pol_1(x)
    return 1/2*x^2
end
# =============================================
function pol_2(x)
    return x^2
end

function int_pol_2(x)
    return 1/3*x^3
end
# =============================================
function pol_3(x)
    return x^3
end

function int_pol_3(x)
    return 1/4*x^4
end
# =============================================
function pol_4(x)
    return x^4
end

function int_pol_4(x)
    return 1/5*x^5
end

# Fehler auswerten
function rel_fehler(f,g)
    return abs(g-f)/f
end

# Parametern:
a = 0
b = 1
n = 2 .^(1:10) .+ 1

# Tests:
r₀ = rel_fehler.( int_pol_0(b)-int_pol_0(a) , alt_box.(pol_0,a,b,n) )
r₁ = rel_fehler.( int_pol_1(b)-int_pol_1(a) , alt_box.(pol_1,a,b,n) )
r₂ = rel_fehler.( int_pol_2(b)-int_pol_2(a) , alt_box.(pol_2,a,b,n) )
r₃ = rel_fehler.( int_pol_3(b)-int_pol_3(a) , alt_box.(pol_3,a,b,n) )
r₄ = rel_fehler.( int_pol_4(b)-int_pol_4(a) , alt_box.(pol_4,a,b,n) )

plot(n,r₀,title="Quadratur mit Alternierenden Box-Regel",label="Grad 0",xlabel="Anzahl von Teilintervalle",ylabel="Relativer Fehler",xscale=:log10,yscale=:log10,yaxis=(:log10, [0.1, :auto]))
plot!(n,r₁,label="Grad 1")
plot!(n,r₂,label="Grad 2")
plot!(n,r₃,label="Grad 3")
plot!(n,r₄,label="Grad 4")