using Pkg
Pkg.add("Plots")
using Plots

x = range(start=1.0*10^(-20), stop=1.0*10^(-19), length=10)

# Erster Versuch:
y1 = ( 1 .- cos.(x) ) ./ x

# Zweiter Versuch:
y2 = 2 .* sin.(x ./ 2)

# Veranschaulichung:
plot(x, y1, label="mit Auslöschung")
plot!(x, y2, label="ohne Auslöschung")
plot!(xlab="x", ylab="1/x * (1 - cos(x))")
#savefig("./Julia-Scripts/A1/output/U3.png")