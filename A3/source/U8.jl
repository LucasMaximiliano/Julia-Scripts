using LinearAlgebra

function mysolve(A, b)
    L, R, p = lu(A)
    b       = b[p]
    y       = vorwsubst(L, b)
    x       = ruckwsubst(R, y)
    return x
end

function vorwsubst(A, b)
    m = length(b)
    x = zeros(m)
    for k = 1:m
        x[k] = (b[k] - A[k,1:k-1]'*x[1:k-1])/A[k,k]
    end
    return x
end

function ruckwsubst(A, b)
    m = length(b)
    x = zeros(m)
    for k = m:-1:1
        x[k] = (b[k] - A[k,k+1:m]'*x[k+1:m])/A[k,k]
    end
    return x
end


A  = [0 1; 1 1]
b  = [1; 1]
l1 = A \ b
l2 = mysolve(A,b)

print("Julia's built-in backslash-operator: ", l1, "\n")
print("My Solution: ", l2, "\n")