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
    y = x.*x.*x - 16
endfunction
function y = df(x)
    y = 3.*x.*x
endfunction

abscisses = 0:0.1:5
ordonnees = f(abscisses)
plot(abscisses, f(abscisses))
xlabel("x")
ylabel("f(x)")
title("$f(x) = x^3 - 16$")

epsilon = 0.0001

printf("### DICHOTOMIE\n")
global VResult
a = 2
b = 3

VResult = []
printf("f(x) = 0 dans [%d;%d]\tepsilon = %6.4f #### x = %f\n", a, b, epsilon, Dichotomie(f, a, b, epsilon))
VResult_dich = VResult

printf("### NEWTON\n")
x0 = 2

VResult = []
printf("f(x) = 0 avec x0 = %3.1f\tepsilon = %6.4f\t#### x = %f\n", x0, epsilon, Newton(f, df, x0, epsilon))
VResult_newt = VResult

figure()
title("f()")
subplot(2, 1, 1)
plot2d(1:length(VResult_dich), abs(VResult_dich), logflag="ln")
ylabel("Dichotomie")
subplot(2, 1, 2)
plot2d(1:length(VResult_newt), abs(VResult_newt), logflag="ln")
ylabel("Newton")
