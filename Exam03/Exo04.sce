clf
close
clear all

E = 5
tau = 0.1

function y = equdiff(t, x)
    y = (-1/tau)*x + (E/tau)
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

function y = uc(t)
    y = E*(1-exp(-t./tau))
endfunction


t0 = 0
y0 = 0
T = 5

t = 0:0.1:T
figure()
plot2d(t, uc(t))
title("Solution analytique")

[t1,y1] = EulerImplicite(equdiff, t0, y0, T, 10*T)
figure()
plot2d(t1,y1)
title("Résolution par Euler implicite")
