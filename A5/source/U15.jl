using Pkg
Pkg.add("Plots")
Pkg.add("LaTeXStrings")
Pkg.add("DelimitedFiles")
Pkg.add("LinearAlgebra")
using Plots
using LaTeXStrings
using DelimitedFiles
using LinearAlgebra

# Formatierung: T, R, DeltaEpsilon
data = readdlm("./Julia-Scripts/A5/data/thermistor.txt")

# Visualizierung:
##  !!! Daten entsprechen Modell gar nicht !!!
y = data[:,2]
x = data[:,1]
scatter(x,y,title="Gemessene Daten",label="Messpunkte")
scatter!(xlabel="T")
scatter!(ylabel="R")

# Ausgleichsrechnung:
function ausgleich()
    data = readdlm("./Julia-Scripts/A5/data/thermistor.txt")
    T = data[:,1]
    R = data[:,2]
    # Trafo:
    b = log.(R)
    A = [ones(size(data,1)) -1 ./ T]
    # QR-Zerlegung:
    F = qr(A)
    x = F \ b # Diese Zeile ist äquivalent zu x = R̃^{T}Q̃b
    # Rücktrafo:
    C = exp(x[1])
    E = x[2]
    return C, E
end

C, E = ausgleich()
# geschätztes Modell:
x = 650:850
y = C * exp.(-E./x)
plot!(x,y,label="geschätztes Modell")
#savefig("./Julia-Scripts/A5/output/U15.png")