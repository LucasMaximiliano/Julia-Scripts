using Pkg
Pkg.add("Plots")
using Plots

# Funktionenschar:
function f(x,a)
    if x < 0
        return 0
    elseif x >= 0 && x < 1
        return cos(a*x)
    elseif x >= 1 && x < 2
        return sin(x) + a
    else
        return 1
    end
end

# Stuetzstellen:
x = range(start=-1, stop=3, length=300)
# Parametern
a = 1:5

# Auswertung:
# permutedims(a) wandelt a in Zeilenvektor
# (ähnlich wie Transposition, aber nicht rekusiv
# implementiert). Somit kann broadcasting die
# dims richtig extrapolieren.
res = f.(x, permutedims(a))

# Plotten:
for i in a
    plot!(x, res[:,i], label="a = $i")
end
plot!(xlab="x", ylab="f_a(x)")
#savefig("./Julia-Scripts/A1/output/U5.png")