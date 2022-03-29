function x = Dichotomie(f, a, b, epsilon)
    global VResult

    m = (a+b)/2
    
    if abs(b-a) <= epsilon then
        x = m
    elseif (f(a)*f(m)) < 0 then
        x = Dichotomie(f, a, m, epsilon)
    else
        x = Dichotomie(f, m, b, epsilon)
    end
    
    VResult = [VResult, m]
endfunction

function S = XNewton(f, df, xk)
    S = xk - f(xk)/df(xk)
endfunction

function S = Newton(f, df, x0, epsilon)
    global VResult

    if abs(f(x0)) <= epsilon then
        S = x0
    else
        S = Newton(f, df, XNewton(f, df, x0), epsilon)
    end

    VResult = [VResult, x0]
endfunction

function y = f(x)
    y = exp(x) - 9
endfunction
function y = df(x)
    y = exp(x)
endfunction

epsilon = 0.0001

printf("### DICHOTOMIE\n")
global VResult

VResult = []
printf("f(x) = 0 dans [1;10]\tepsilon = %6.4f #### x = %f\n", epsilon, Dichotomie(f, 1, 3, epsilon))
VResult_dichf = VResult

printf("### NEWTON\n")
x0 = 5

VResult = []
printf("f(x) = 0 avec x0 = %3.1f\tepsilon = %6.4f\t#### x = %f\n", x0, epsilon, Newton(f, df, x0, epsilon))
VResult_newtf = VResult

figure()
title("f()")
subplot(2, 1, 1)
plot2d(1:length(VResult_dichf), abs(VResult_dichf), logflag="ln")
ylabel("Dichotomie")
subplot(2, 1, 2)
plot2d(1:length(VResult_newtf), abs(VResult_newtf), logflag="ln")
ylabel("Newton")
