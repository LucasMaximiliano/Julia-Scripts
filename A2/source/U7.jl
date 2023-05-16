function H(n)
    res = zeros(n,n)
    for i in 1:n
        for j in 1:n
            res[i,j] = 1 / (i+j-1)
        end
    end
    return res
end

function Hinv(n)
    res = zeros(n,n)
    for i in 1:n
        for j in 1:n
            res[i,j] = (-1)^(i+j) * (i+j-1) * binomial(n+i-1, n-j) * binomial(n+j-1, n-i) * binomial(i+j-2, i-1)^2
        end
    end
    return res
end

n = [1, 2, 4, 8, 16, 32] #willkürlich gewählt! (um Overflow zu vermeiden, siehe big)

for dim in n
    b  = rand(Float64, dim)
    l1 = H(dim) \ b
    l2 = Hinv(dim) * b
    l3 = inv(H(dim)) * b
    print("n = $dim\n")
    print("l1 - l2 = ", maximum(l1-l2), "\n")
    print("l1 - l3 = ", maximum(l1-l3), "\n")
    print("l2 - l3 = ", maximum(l2-l3), "\n")
    print("----------------\n")
end

