function thomas(A,d)
    n = length(d)
    #   Koeffizienten & rechte Seite anpassen:
    ##  a[i] = A[i,i-1]
    ##  b[i] = A[i,i]
    ##  c[i] = A[i,i+1]
    ### Nicht rekursive Fälle:
    A[1,2] = A[1,2] / A[1,1]
    d[1]    = d[1] / A[1,1]
    ### Rekursive Fälle:
    for i in 2:n-1
        A[i,i+1] = A[i,i+1] / (A[i,i] - A[i-1,i]*A[i,i-1])
        d[i] = (d[i] - d[i-1]*A[i,i-1]) / (A[i,i] - A[i-1,i]*A[i,i-1])
    end
    d[n] = (d[n] - d[n-1]*A[n,n-1]) / (A[n,n] - A[n-1,n]*A[n,n-1])
    # Rückwärtssubstitution:
    x = zeros(n)
    x[n] = d[n]
    for i in n-1:-1:1
        x[i] = d[i] - A[i,i+1]*x[i+1]
    end
    return x
end

A = [1.0 4.0 0.0 0.0;
     3.0 4.0 1.0 0.0;
     0.0 2.0 3.0 4.0;
     0.0 0.0 1.0 3.0]
d = [9.0 14.0 29.0 15.0]
x = thomas(A,d)