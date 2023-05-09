using Pkg
Pkg.add("Plots")
Pkg.add("LaTeXStrings")
using Plots
using LaTeXStrings

function f1(x)
    a = x + 1
    return log10(a)
end

function f2(x)
    a = x + 1
    b = x
    return (log10(a) * b) / (a-1)
end

x  = range(-1*10^-20, 1*10^-20, 100)
y1 = f1.(x)
y2 = f2.(x)

plot(x, y1, label=L"f_1(x)")
plot!(x, y2, label=L"f_2(x)")
plot!(xlab="x", ylab="y", ylims=[-0.0001, 0.0001])
#savefig("./Julia-Scripts/A2/output/U6.png")