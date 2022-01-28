g_n = 10

g_a = 0
g_b = 1


function y = dArctan(x)
    y = 1./(1+x^2)
endfunction

function y = Atester(x)
    y = sqrt(x)
endfunction

function y = IntAtester(a, b)
    y = intg(a, b, Atester)
endfunction

function h = H(a, b, n)
    h = (b-a)./n
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

printf("\n")
printf("Avec %d intervalles entre %d et %d :\n\n", g_n, g_a, g_b)

printf("h\t= %f\n", H(g_a, g_b, g_n))
printf("h^2\t= %f\n", H(g_a, g_b, g_n)^2)
printf("h^4\t= %f\n", H(g_a, g_b, g_n)^4)

printf("\n")

printf("Rectangle Gauche :\t%f\n", RectangleGauche(Atester, g_a, g_b, g_n))
printf("Rectangle Droite :\t%f\n", RectangleDroite(Atester, g_a, g_b, g_n))
printf("Point Milieu :\t\t%f\n", PointMilieu(Atester, g_a, g_b, g_n))
printf("Trapèzes :\t\t%f\n", Trapezes(Atester, g_a, g_b, g_n))
printf("Simpson :\t\t%f\n", Simpson(Atester, g_a, g_b, g_n))
printf("Intégrale originale :\t%f\n", IntAtester(g_a, g_b))


function VerifErreur(func, a, b, power)
    Narray = [10 50 100 500 1000 5000]
    Harray = (b-a)./Narray
    Erreur = zeros(Harray)

    for i=1:length(Harray),
        Erreur(i) = abs( IntAtester(a, b) - func(Atester, a, b, Narray(i)) )
    end

    plot(Harray, Erreur./(Harray^power))
endfunction

subplot(2,2,1)
VerifErreur(RectangleGauche, g_a, g_b, 1)
//VerifErreur(RectangleDroite, g_a, g_b, 1)
subplot(2,2,2)
VerifErreur(PointMilieu, g_a, g_b, 2)
subplot(2,2,3)
VerifErreur(Trapezes, g_a, g_b, 2)
subplot(2,2,4)
VerifErreur(Simpson, g_a, g_b, 4)

