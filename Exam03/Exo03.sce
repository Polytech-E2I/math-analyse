clf
close
clear all

function y = equdiff(t, x)
    y = -2*x
endfunction
function y = equdiff10(t, x)
    y = -10*x
endfunction
function y = equdiff150(t, x)
    y = -150*x
endfunction

function [t, y] = Euler(f, t0, y0, T, N) // f = equation représentative de l'equadiff
    h = T/N
    printf("h = %d\n",h)
    t = t0:h:t0+T
    y = zeros(t)
    y(1) = y0

    for n = 1:N
        printf("%d\n",n)
        if n == 1,
            y(2) = y0 + h*f(t0,y0)
        else
            y(n+1) = y(n) + h*f(t(n), y(n))
        end
    end
endfunction

function [t,y] = EulerImplicite(f, t0, y0, T, N)
    h = T/N
    t = t0:h:t0+T
    y = zeros(t)
    y(1) = y0

    for n = 1:N
        function out = g(in)
            out = y(n) + h*f(t(n+1), in) - in
        endfunction
        y(n+1) = fsolve(y(n), g)
    end
endfunction

t0 = 0
y0 = 1
T = 100


t = 0:0.1:10
figure()
plot2d(t, exp(-2.*t))
title("Solution analytique")

[t1,y1] = Euler(equdiff, t0, y0, T, T) // N = T
figure()
plot2d(t1,y1)
title("Solution numérique N = T, lambda=-2")

[t2,y2] = Euler(equdiff, t0, y0, T, 4*T) // N = 4T
figure()
plot2d(t2,y2)
title("Solution numérique N = 4T, lambda=-2")

[t3,y3] = Euler(equdiff, t0, y0, T, 10*T) // N = 10T
figure()
plot2d(t3,y3)
title("Solution numérique N = 10T, lambda=-2")

[t4,y4] = Euler(equdiff10, t0, y0, T, 4*T)
figure()
plot2d(t4,y4)
title("Solution numérique N = 4T, lambda=-10")

[t5,y5] = Euler(equdiff10, t0, y0, T, 20*T)
figure()
plot2d(t5,y5)
title("Solution numérique N = 20T, lambda=-10")

[t6,y6] = Euler(equdiff150, t0, y0, T, 4*T)
figure()
plot2d(t6,y6)
title("Solution numérique N = 4T, lambda=-150")

[t7,y7] = Euler(equdiff150, t0, y0, T, 20*T)
figure()
plot2d(t7,y7)
title("Solution numérique N = 20T, lambda=-150")

[t8,y8] = EulerImplicite(equdiff,t0,y0,T,4*T)
figure()
plot2d(t8,y8)
title("Euler implicite, lambda = -2")

[t9,y9] = EulerImplicite(equdiff10,t0,y0,T,4*T)
figure()
plot2d(t9,y9)
title("Euler implicite, lambda = -10")

[t10,y10] = EulerImplicite(equdiff150,t0,y0,T,4*T)
figure()
plot2d(t10,y10)
title("Euler implicite, lambda = -150")
