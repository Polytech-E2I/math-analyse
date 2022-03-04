function x = Dichotomie(f, a, b, epsilon)
    m = (a+b)/2
    
    if (b-a) <= epsilon then
        x = return m
    end
    
    if (f(a)*f(m)) < 0 then
        x = return Dichotomie(f, a, m, epsilon)
    else
        x = return Dichotomie(f, m, b, epsilon)
    end
endfunction

function y = f1(x)
    y = x*x - 2
endfunction

function y = f2(x)
    y = x - exp(1)*sin(x)
endfunction

function y = f3(x)
    y = x*x
endfunction

epsilon = 0.0001

printf("f1(x) = 0 dans [1;2]\tepsilon = %6.4f #### x = %f\n", epsilon, Dichotomie(f1, 1, 2, 0.0001))
printf("f2(x) = 0 dans [1;10]\tepsilon = %6.4f #### x = %f\n", epsilon, Dichotomie(f2, 1, 10, 0.0001))
printf("f3(x) = 0 dans [-1;1]\tepsilon = %6.4f #### x = %f\n", epsilon, Dichotomie(f3, -1, 1, 0.0001))
