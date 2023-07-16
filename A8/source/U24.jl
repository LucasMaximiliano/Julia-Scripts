using Pkg
Pkg.add("Plots")
Pkg.add("LaTeXStrings")
Pkg.add("LinearAlgebra")
using Plots
using LaTeXStrings
using LinearAlgebra

# Quadratur mit Simpson-Verfahren:
function simpson(f,a,b)
    if a > b
        buf = a
        a   = b
        b   = buf
    end
    return (b-a)/6 * (f(a) + 4*f((a+b)/2) + f(b))
end

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
    return abs(g-f)/abs(f)
end

function abs_fehler(f,g)
    return abs(g-f)
end

# Parametern:
a = 0
b = 1
n = 2 .^(1:10) .+ 1

#   Tests:
##  Alternierende Box-Regel:
### Relativer Fehler
R₀ = rel_fehler.( int_pol_0(b)-int_pol_0(a) , alt_box.(pol_0,a,b,n) )
R₁ = rel_fehler.( int_pol_1(b)-int_pol_1(a) , alt_box.(pol_1,a,b,n) )
R₂ = rel_fehler.( int_pol_2(b)-int_pol_2(a) , alt_box.(pol_2,a,b,n) )
R₃ = rel_fehler.( int_pol_3(b)-int_pol_3(a) , alt_box.(pol_3,a,b,n) )
R₄ = rel_fehler.( int_pol_4(b)-int_pol_4(a) , alt_box.(pol_4,a,b,n) )

p1 = plot(n,R₀,label="Grad 0",xlabel="Anzahl von Teilintervalle",ylabel="Relativer Fehler",xscale=:log10,yscale=:log10,yaxis=(:log10, [0.1, :auto]))
plot!(n,R₁,label="Grad 1")
plot!(n,R₂,label="Grad 2")
plot!(n,R₃,label="Grad 3")
plot!(n,R₄,label="Grad 4")

## Absoluter Fehler:
A₀ = abs_fehler.( int_pol_0(b)-int_pol_0(a) , alt_box.(pol_0,a,b,n) )
A₁ = abs_fehler.( int_pol_1(b)-int_pol_1(a) , alt_box.(pol_1,a,b,n) )
A₂ = abs_fehler.( int_pol_2(b)-int_pol_2(a) , alt_box.(pol_2,a,b,n) )
A₃ = abs_fehler.( int_pol_3(b)-int_pol_3(a) , alt_box.(pol_3,a,b,n) )
A₄ = abs_fehler.( int_pol_4(b)-int_pol_4(a) , alt_box.(pol_4,a,b,n) )

p2 = plot(n,A₀,label="Grad 0",xlabel="Anzahl von Teilintervalle",ylabel="Absoluter Fehler",xscale=:log10,yscale=:log10,yaxis=(:log10, [0.1, :auto]))
plot!(n,A₁,label="Grad 1")
plot!(n,A₂,label="Grad 2")
plot!(n,A₃,label="Grad 3")
plot!(n,A₄,label="Grad 4")

plot(p1,p2,plot_title="Quadratur mit Alternierenden Box-Regel")
savefig("./Julia-Scripts/A8/output/U24_alt_box.png")

## Simpson-Regel:
R    = zeros(5)
R[1] = rel_fehler( int_pol_0(b)-int_pol_0(a) , simpson(pol_0,a,b) )
R[2] = rel_fehler( int_pol_1(b)-int_pol_1(a) , simpson(pol_1,a,b) )
R[3] = rel_fehler( int_pol_2(b)-int_pol_2(a) , simpson(pol_2,a,b) )
R[4] = rel_fehler( int_pol_3(b)-int_pol_3(a) , simpson(pol_3,a,b) )
R[5] = rel_fehler( int_pol_4(b)-int_pol_4(a) , simpson(pol_4,a,b) )

p3 = plot(0:4,R,label=false,xlabel="Grad vom Polynom",ylabel="Relativer Fehler",yscale=:log10,yaxis=(:log10, [0.1, :auto]))

## Absoluter Fehler:
A    = zeros(5)
A[1] = abs_fehler( int_pol_0(b)-int_pol_0(a) , simpson(pol_0,a,b) )
A[2] = abs_fehler( int_pol_1(b)-int_pol_1(a) , simpson(pol_1,a,b) )
A[3] = abs_fehler( int_pol_2(b)-int_pol_2(a) , simpson(pol_2,a,b) )
A[4] = abs_fehler( int_pol_3(b)-int_pol_3(a) , simpson(pol_3,a,b) )
A[5] = abs_fehler( int_pol_4(b)-int_pol_4(a) , simpson(pol_4,a,b) )

p4 = plot(0:4,A,label=false,xlabel="Grad vom Polynom",ylabel="Absoluter Fehler",yscale=:log10,yaxis=(:log10, [0.1, :auto]))

plot(p3,p4,plot_title="Quadratur mit Simpson-Regel")
savefig("./Julia-Scripts/A8/output/U24_simpson.png")