function h = H(a, b, n)
    h = (b-a)./n
endfunction

function xk = Xk(k, n, a, b)
    xk = a + k * H(a, b, n)
endfunction

function I = Simpson(f, a, b, n)
    sum1 = 0
    for k = 1:n-1,
        sum1 = sum1 + f(Xk(k))
    end
    
    sum2 = 0
    for k = 0:n-1,
        sum2 = sum2 + f( (Xk(k) + Xk(k+1)) / 2 )
    end
    
    I = H(a, b, n) / 6 * ( f(Xk(0)) + f(Xk(n)) + 2 * sum1 + 4 * sum2 )
endfunction

function Y = loinormale(X)
    Y = (1/sqrt(2*%pi)) * exp(-X^2/2)
endfunction

//x = [-10:0.1:10]
//plot(x, loinormale(x))

disp(Simpson(loinormale, -1, 1, 100))
disp(Simpson(loinormale, -2, 2, 100))
disp(Simpson(loinormale, -3, 3, 100))
