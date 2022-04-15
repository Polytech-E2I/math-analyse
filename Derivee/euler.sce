//clf
//close
//clear

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

function [t,y] = RK4(f, t0, y0, T, N)
    h = T/N
    t = t0:h:t0+T
    y = zeros(t)
    y(1) = y0

    for n = 1:N
        k1 = h*f(t(n), y(n))
        k2 = h*f(t(n) + h/2, y(n) + k1/2)
        k3 = h*f(t(n) + h/2, y(n) + k2/2)
        k4 = h*f(t(n) + h, y(n) + k3)

        y(n+1) = y(n) + (1/6)*(k1 + 2*k2 + 2*k3 + k4)
    end
endfunction

function [t,y] = RK2(f, t0, y0, T, N)
    h = T/N
    t = t0:h:t0+T
    y = zeros(t)
    y(1) = y0

    for n = 1:N
        k1 = h*f(t(n), y(n))
        k2 = h*f(t(n) + h, y(n) + k1)
        y(n+1) = y(n) + (1/2)*(k1 + k2)
    end
endfunction

function [t,y] = EulerMIEUX(f, t0, y0, T, N)
    h = T/N
    t = t0:h:t0+T
    y = zeros(t)
    y(1) = y0

    for n = 1:N
        moy = y(n) + (h/2)*f(t(n), y(n))
        y(n+1) = y(n) + h*f(t(n) + h/2, moy)
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

function Test_Euler()
    t0 = 0
    y0 = 1
    T = 1

    [t1,y1] = Euler(equ2, t0, y0, T, 10)
    [t2,y2] = Euler(equ2, t0, y0, T, 20)
    [t3,y3] = Euler(equ2, t0, y0, T, 40)

    figure()
    plot(t1,y1,"r", t2,y2,"g", t3,y3,"b", t1,f2(t1),"m")
    title("Comparaison de la méthode d''Euler en fonction de N")
    legend(["Numérique N = 10"; "Numérique N = 20"; "Numérique N = 40"; "Théorique"])
endfunction

global epsilon
epsilon = 10e-10

function y = f3(x)
    y = 1/5
endfunction
function y = f3eps(x)
    y = 1/5 + epsilon*exp(-150*x)
endfunction
function y = equ3(t, x)
    y = -150*x + 30
endfunction

function Test_EulerEps()
    global epsilon

    t0 = 0
    y0 = 1/5
    y0eps = y0 + epsilon
    T = 1

    [t1,y1] = Euler(equ3, t0, y0, T, 40)
    [t2,y2] = Euler(equ3, t0, y0eps, T, 10)
    [t3,y3] = Euler(equ3, t0, y0eps, T, 20)
    [t4,y4] = Euler(equ3, t0, y0eps, T, 40)

    figure()
    plot(t1,y1,"r", t1,f3(t1),"k", t2,y2,"g", t3,y3,"b", t4,y4,"y", t2,f3eps(t2),"m")
    title("Étude de la stabilité de la méthode d''Euler")
    legend(["Numérique N = 40"; "Théorique"; "Numérique (espilon) N = 10"; "Numérique (espilon) N = 20"; "Numérique (espilon) N = 40"; "Théorique (espilon)"])
endfunction

function Test_CompareMethodes()
    t0 = 0
    y0 = 1
    T = 1

    for N = 10:40:100
        [t1,y1] = Euler(equ2, t0, y0, T, N)
        [t2,y2] = RK4(equ2, t0, y0, T, N)
        [t3,y3] = RK2(equ2, t0, y0, T, N)
        [t4,y4] = EulerMIEUX(equ2, t0, y0, T, N)

        figure()
        plot(t1,y1,"r", t2,y2,"g*", t3,y3,"b*", t4,y4,"y", t2,f2(t2),"m")
        title(msprintf("Étude de la stabilité pour N = %d", N))
        legend(["Euler"; "RK4"; "RK2"; "Euler modifiée"; "Théorique"])
    end
endfunction

function Test_EulerEpsImplicite()
    global epsilon

    t0 = 0
    y0 = 1/5
    y0eps = y0 + epsilon
    T = 1

    [t1,y1] = EulerImplicite(equ3, t0, y0, T, 40)
    [t2,y2] = EulerImplicite(equ3, t0, y0eps, T, 10)
    [t3,y3] = EulerImplicite(equ3, t0, y0eps, T, 20)
    [t4,y4] = EulerImplicite(equ3, t0, y0eps, T, 40)

    figure()
    plot(t1,y1,"r*", t2,y2,"g", t3,y3,"b", t4,y4,"y", t2,f3eps(t2),"m")
    title("Étude de la stabilité de la méthode d''Euler implicite")
    legend(["Numérique N = 40"; "Numérique (espilon) N = 10"; "Numérique (espilon) N = 20"; "Numérique (espilon) N = 40"; "Théorique (espilon)"])
endfunction

Test_Euler()
Test_EulerEps()
Test_CompareMethodes()
Test_EulerEpsImplicite()


