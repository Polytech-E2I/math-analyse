function y = f2(x)
    y = exp(-x) + x
endfunction
function y = df2(x)
    y = -exp(-x) + 1
endfunction

function y = equ2(t, x)
    y = -x + t + 1
endfunction

function [t, y] = Euler(f, t0, y0, T, N) // f = equation représentative de l'equadiff
    h = T/N
    t = t0:h:t0+T
    y = zeros(t)
    y(1) = y0
    
    for n = 1:N
        if n == 1,
            y(2) = y0 + h*f(t0,y0)
        else
            y(n+1) = y(n) + h*f(t(n), y(n))
        end            
    end
endfunction

/*
[t1,y1] = Euler(equ2, 0, 1, 1, 10)
[t2,y2] = Euler(equ2, 0, 1, 1, 20)
[t3,y3] = Euler(equ2, 0, 1, 1, 40)

plot(t1,y1,"r", t2,y2,"g", t3,y3,"b", t1,f2(t1),"m")
title("Comparaison de la méthode d''Euler en fonction de N")
legend(["Numérique N = 10"; "Numérique N = 20"; "Numérique N = 40"; "Théorique"])
*/

epsilon = 10e-10

function y = f3(x)
    y = 1/5
endfunction
function y = f3eps(x)
    y = 1/5 + epsilon*exp(-150*x)
endfunction
function y = equ3(t, x)
    y = -x + 30
endfunction

[t1,y1] = Euler(equ3, 0, 1/5, 1, 40)
[t2,y2] = Euler(equ3, 0, 1/5 + epsilon, 1, 10)
[t3,y3] = Euler(equ3, 0, 1/5 + epsilon, 1, 20)
[t4,y4] = Euler(equ3, 0, 1/5 + epsilon, 1, 40)

plot(t1,y1,"r", t1,f3(t1),"k", t2,y2,"g", t3,y3,"b", t4,y4,"y", t2,f3eps(t2),"m")
title("Étude de la stabilité de la méthode d''Euler")
legend(["Numérique N = 40"; "Théorique"; "Numérique (espilon) N = 10"; "Numérique (espilon) N = 20"; "Numérique (espilon) N = 40"; "Théorique (espilon)"])
