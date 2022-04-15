function x = Dichotomie(f, a, b, epsilon)
    m = (a+b)/2
    
    if abs(b-a) <= epsilon then
        x = m
    elseif (f(a)*f(m)) < 0 then
        x = Dichotomie(f, a, m, epsilon)
    else
        x = Dichotomie(f, m, b, epsilon)
    end
endfunction

h0 = 90
tau = 0.3
g = 9.806
function y = h(t)
    y = h0 - g*tau.*t + g*tau*tau*(1-exp(t./tau))
endfunction

epsilon = 0.0001
a = 1
b = 2

printf("h(x) = 0 dans [%d;%d]\tepsilon = %6.4f #### x = %f\n", a, b, epsilon, Dichotomie(h, a, b, epsilon))

t = 0:0.1:10
// Pour une raison obscure, je n'arrive pas à afficher cette courbe...
// C'est la raison pour laquelle j'ai mis une capture Geogebra à la place.
//plot2d(t,h(t))
