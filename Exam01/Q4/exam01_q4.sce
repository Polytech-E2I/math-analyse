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

function h = H(a, b, n)
    h = (b-a)./n
endfunction

function xk = Xk(k, a, b, n)
    xk = round(a + k * H(a, b, n))
endfunction

function I = Simpson(f, a, b, n)
    sum1 = 0
    for k = 2:n,
        sum1 = sum1 + f(Xk(k, a, b, n))
    end
    
    sum2 = 0
    for k = 1:n,
        sum2 = sum2 + f( (Xk(k, a, b, n) + Xk(k+1, a, b, n)) / 2 )
    end
    
    I = H(a, b, n) / 6 * ( f(Xk(1, a, b, n)) + f(Xk(n+1, a, b, n)) + 2 * sum1 + 4 * sum2 )
endfunction

temps = [0 6 12 18 24 30 36 42 48 54 60 66 72 78 84]
vitesse = [38 41 45.5 47.5 44.8 40.5 37 33 30 26 23.5 27 32 35 37.5]

nouvelles_abscisses = [0:1:84]
newton = Newton(temps, vitesse, nouvelles_abscisses)
affine = interpln([temps ; vitesse], nouvelles_abscisses)
spline = interp(nouvelles_abscisses, temps, vitesse, splin(temps, vitesse) )

xlabel("Temps (s)")
ylabel("Vitesse, (m/s)")
title("Vitesse de la voiture de course")
plot(temps, vitesse, 'r*')
plot(nouvelles_abscisses, newton)
plot(nouvelles_abscisses, affine, 'g')
plot(nouvelles_abscisses, spline, 'm')

legend("Vitesse mesurée", "Interpolation Newton", "Interpolation affine", "Interpolation par splines")

longueur = Simpson(spline, 0, 84, length(spline))
disp(longueur)
