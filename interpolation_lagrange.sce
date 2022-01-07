function P = Lagrange(x, y, X)
    n = size(x)(2)
    Y = 0
    for i=1:n,
        L = 1
        for j=1:n,
            if j ~= i then
                L = L .* (X-x(j)) / (x(i) - x(j))
            end
        end      
        Y = Y + y(i) * L 
    end
endfunction

function P = Newton(x, y, X)
    n = size(x)(2) - 1
    
    for k=1:n+1,
        a(k) = y(k)
    end

    for s=1:n,
        for k=n+1:-1:s+1,
            a(k) = (a(k) - a(k - 1)) / (x(k) - x(k - s))
        end
    end
    
    P = a(n+1)
    for i=n+1:-1:2,
        P = P.*(X-x(i-1)) + a(i-1)
    end
endfunction
