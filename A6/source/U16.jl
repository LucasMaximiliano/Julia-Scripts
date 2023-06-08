function bisection(f::Function,a,b,tol)
    if sign(f(a)) == sign(f(b))
        return NaN
    else
        x = (b+a)/2
        if abs(f(x)) <= tol
            return x
        elseif sign(f(a)) == sign(f(x))
            return bisection(f,x,b,tol)
        else
            return bisection(f,a,x,tol)
        end
    end
end

function test1(x)
    return 2x + 1 
end

function test2(x)
    return x^2 - 1    
end

function test3(x)
    return exp(x)
end

a   = -10
b   =  10
tol =  10^-6

# Gerade: 2x+1 → x₀ = -0.5    
x₀ = bisection(test1,a,b,tol)
@show r₁ = abs(x₀+0.5) <= tol
# Parabel: x²-1 → x₀ = -1 bzw. 1
## Code scheitert, weil nicht monoton (2 Nullstellen)
x₀ = bisection(test2,a,b,tol)
@show r₂ = (abs(x₀+1) <= tol) || (abs(x₀-1) <= tol)
# Exponential: eˣ → x₀ = -∞
x₀ = bisection(test3,a,b,tol)
@show r₃ = (NaN == x₀)