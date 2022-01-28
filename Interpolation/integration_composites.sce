n = 20

a = 0
b = 1


function y = Atester(x)
    y = 1./(1+x^2)
//    y = sqrt(x)
endfunction

function y = IntAtester(a, b)
    y = integrate("1/(1+x^2)", "x", a, b)
endfunction

function h = H(a, b, n)
    h = (b-a)/n
endfunction

function xk = Xk(k, n, a, b)
    xk = a + k * H(a, b, n)
endfunction

function I = RectangleGauche(f, a, b, n)
    sum = 0
    
    for k = 0:n-1,
        sum = sum + f(Xk(k))
    end

    
    I = H(a, b, n) * sum
endfunction

function I = RectangleDroite(f, a, b, n)
    sum = 0
    
    for k = 0:n-1,
        sum = sum + f(Xk(k+1))
    end

    
    I = H(a, b, n) * sum
endfunction

function I = PointMilieu(f, a, b, n)
    sum = 0
    
    for k = 0:n-1,
        sum = sum + f( (Xk(k+1) + Xk(k)) / 2 )
    end

    
    I = H(a, b, n) * sum
endfunction

function I = Trapezes(f, a, b, n)
/*
    sum = 0
    
    for k = 0:n-1,
        sum = sum + ( f(Xk(k)) + f(Xk(k+1)) ) / 2
    end
    
    I = H(a, b, n) * sum
*/
    sum = 0
    
    for k = 1:n-1,
        sum = sum + f(Xk(k))
    end
    
    I = H(a, b, n) / 2 * ( f(Xk(0)) + f(Xk(n)) + 2 * sum )
endfunction

function I = Simpson(f, a, b, n)
/*
    sum = 0
    
    for k = 0:n-1,
        sum = sum + ( f(Xk(k)) + 4*f( (Xk(k)+Xk(k+1)) / 2 ) + f(Xk(k+1)) )
    end
    
    I = H(a, b, n) * sum / 6
*/
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

printf("Rectangle Gauche :\t%f\n", RectangleGauche(Atester, a, b, n))
printf("Rectangle Droite :\t%f\n", RectangleDroite(Atester, a, b, n))
printf("Point Milieu :\t\t%f\n", PointMilieu(Atester, a, b, n))
printf("Trapèzes :\t\t%f\n", Trapezes(Atester, a, b, n))
printf("Simpson :\t\t%f\n", Simpson(Atester, a, b, n))
printf("Intégrale originale :\t%f\n", IntAtester(a, b))
