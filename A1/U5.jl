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
res = zeros(300,5)
for i in a
    part = f.(x,i)
    res[:,i] = part
end 

# Plotten:
for i in a
    plot!(x, res[:,i], label="a = $i")
end
plot!(xlab="x", ylab="f_a(x)")
#savefig("./Julia-Scripts/A1/output/U5.png")