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
    xk = (a + k * H(a, b, n))
endfunction

function I = RectangleGauche(f, a, b)
    n = length(f)
    sum1 = 0
    
    for k = 1:n,
        sum1 = sum1 + f(k)
    end

    
    I = H(a, b, n) * sum1
endfunction

proportion = [0.0, 0.1, 0.2, 0.5, 0.8, 0.9, 1]
puissance = [30, 29, 24, 19, 18, 15, 0]

nouvelles_abscisses = [0:0.05:1]
polynome = Newton(proportion, puissance, nouvelles_abscisses)

affine = interpln([proportion ; puissance], nouvelles_abscisses)

spline = interp(nouvelles_abscisses, proportion, puissance, splin(proportion, puissance, "natural"), "natural" )

scf(0)
xlabel('Proportion de l ''année')
ylabel("Puissance consommée")
title("Puissance consommée Hydro Québec")
plot(proportion, puissance, 'r*')
plot(nouvelles_abscisses, polynome)
plot(nouvelles_abscisses, affine, 'g')
plot(nouvelles_abscisses, spline, 'm')

legend("Points mesurés", "Interpolation Newton", "Interpolation affine", "Interpolation spline")

disp("Interpolation en 0.05 : ", spline(2))
disp("Interpolation en 0.3 : ", spline(7))
disp("Interpolation en 0.4 : ", spline(9))
disp("")

puissance_annee = RectangleGauche(spline, 0, 1)
disp("Énergie consommée sur l''année : ", puissance_annee)
