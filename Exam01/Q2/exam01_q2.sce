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

annee = [1965, 1970, 1980, 1985, 1990, 1991]
production = [17769, 24001, 25961, 34336, 29036, 33417]

nouvelles_abscisses = [1961:1:1995]
polynome = Newton(annee, production, nouvelles_abscisses)

affine = interpln([annee; production], nouvelles_abscisses)

spline = interp(nouvelles_abscisses, annee, production, splin(annee, production, "natural"), "natural")

scf(0)
xlabel('Année')
ylabel("Production (10^5 kg)")
title("Production de citrons corses")
plot(annee, production, 'r*')
plot(nouvelles_abscisses, polynome)
plot(nouvelles_abscisses, affine, 'g')
plot(nouvelles_abscisses, spline, 'm')

legend("Points mesurés", "Interpolation Newton", "Interpolation affine", "Interpolation spline", "in_upper_left")

affichage = affine
disp("Interpolation en 1962 : ", affichage(2))
disp("Interpolation en 1977 : ", affichage(17))
disp("Interpolation en 1992 : ", affichage(32))
