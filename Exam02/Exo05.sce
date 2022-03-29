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
    
    P = Y
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

temps = [0, 3, 4]
tension = [-8, 4, 0]

nouvelles_abscisses = [0:0.05:5]
polynome = Newton(temps, tension, nouvelles_abscisses)

affine = interpln([temps ; tension], nouvelles_abscisses)

spline = interp(nouvelles_abscisses, temps, tension, splin(temps, tension, "natural"), "natural" )

lagrange = Lagrange(temps, tension, nouvelles_abscisses)

scf(0)
xlabel('Temps (s)')
ylabel("Tension (V)")
title("Tension mesurée aux bornes d''un dipôle")
plot(temps, tension, 'r*')
plot(nouvelles_abscisses, polynome)
plot(nouvelles_abscisses, lagrange, 'g')

legend("Points mesurés", "Interpolation Newton", "Interpolation Lagrange")

[valeur, index] = max(polynome)
disp("Max Newton : U* = ", valeur, "t* = ", index)
[valeur, index] = max(lagrange)
disp("Max Lagrange : U* = ", valeur, "t* = ", index)
disp("")
