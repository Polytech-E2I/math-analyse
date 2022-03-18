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

function y = f1(x)
    y = x*x - 2
endfunction
function y = df1(x)
    y = 2*x
endfunction

function y = f2(x)
    y = x - exp(1)*sin(x)
endfunction
function y = df2(x)
    y = 1 - exp(1)*cos(x)
endfunction

function y = f3(x)
    y = x*x
endfunction
function y = df3(x)
    y = 2*x
endfunction

epsilon = 0.0001

printf("### DICHOTOMIE\n")
global VResult
VResult = []
printf("f1(x) = 0 dans [1;2]\tepsilon = %6.4f #### x = %f\n", epsilon, Dichotomie(f1, 1, 2, 0.0001))
VResult_dichf1 = VResult
VResult = []
printf("f2(x) = 0 dans [1;10]\tepsilon = %6.4f #### x = %f\n", epsilon, Dichotomie(f2, 1, 10, 0.0001))
VResult_dichf2 = VResult
//printf("f3(x) = 0 dans [-1;1]\tepsilon = %6.4f #### x = %f\n", epsilon, Dichotomie(f3, -1, 1, 0.0001))

printf("### NEWTON\n")
x0 = 5
VResult = []
printf("f1(x) = 0 avec x0 = %3.1f\tepsilon = %6.4f\t#### x = %f\n", x0, epsilon, Newton(f1, df1, x0, epsilon))
VResult_newtf1 = VResult
VResult = []
printf("f2(x) = 0 avec x0 = %3.1f\tepsilon = %6.4f\t#### x = %f\n", x0, epsilon, Newton(f2, df2, x0, epsilon))
VResult_newtf2 = VResult
VResult = []
//printf("f3(x) = 0 avec x0 = %3.1f\tepsilon = %6.4f\t#### x = %f\n", x0, epsilon, Newton(f3, df3, x0, epsilon))

figure()
title("f1()")
subplot(2, 1, 1)
plot2d(1:length(VResult_dichf1), abs(VResult_dichf1), logflag="ln")
ylabel("Dichotomie")
subplot(2, 1, 2)
plot2d(1:length(VResult_newtf1), abs(VResult_newtf1), logflag="ln")
ylabel("Newton")

figure()
title("f2()")
subplot(2, 1, 1)
plot2d(1:length(VResult_dichf2), abs(VResult_dichf2), logflag="ln")
ylabel("Dichotomie")
subplot(2, 1, 2)
plot2d(1:length(VResult_newtf2), abs(VResult_newtf2), logflag="ln")
ylabel("Newton")
