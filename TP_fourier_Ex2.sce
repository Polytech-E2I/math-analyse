clf

clear an_num
function An = an_num(T, f, x, n)
    retour = zeros(1,n)
    for i=0:n-1,
        retour(1,i+1) = (2/T) * inttrap(x, f .* cos(2*%pi*i*(1/T).*x))
    end
    An = retour
endfunction

clear bn_num
function Bn = bn_num(T, f, x, n)
    retour = zeros(1,n)
    for i=1:n-1,
        retour(1,i+1) = (2/T) * inttrap(x, f .* sin(2*%pi*i*(1/T).*x))
    end
    Bn = retour
endfunction

clear fourier
function [signalrecon] = fourier(T, f, x, t, N)
    an = an_num(T, f, x, N)
    bn = bn_num(T, f, x, N)
    
    somme = 0
    
    for i=1:N-1
        somme = somme + an(1,i+1).*cos(i*(2*%pi/T)*t) + bn(1,i+1).*sin(i*(2*%pi/T)*t)
    end
    
    signalrecon = an(1,1)/2 + somme
endfunction

/*
clear t
t = 0:2*%pi/200:2*%pi
clear decomp10
decomp10 = fourier(2*%pi, dentsdescie(t), t, t, 10)
clear decomp20
decomp20 = fourier(2*%pi, dentsdescie(t), t, t, 20)
clear decomp100
decomp100 = fourier(2*%pi, dentsdescie(t), t, t, 100)

plot(t, dentsdescie(t))
plot(t, decomp10, 'r')
plot(t, decomp20, 'g')
plot(t, decomp100, 'm')
*/

clear triangle
function [y]=triangle(x)
    retour = zeros(size(x))
    for i=1:size(x)(2)
        if x(1,i) >= -%pi & x(1,i) < 0 then
            retour(1,i) = x(1,i) + %pi
        elseif x(1,i) >= 0 & x(1,i) <= %pi then
            retour(1,i) = -x(1,i) + %pi
        else
            retour(1,i) = 0
        end
    end
    y = retour
endfunction

clear x
x = -%pi:2*%pi/1000:%pi
clear t
t = -%pi:2*%pi/200:%pi
clear repet
repet = 7
clear trepet
trepet = -repet*%pi:2*%pi/200:repet*%pi
trianglerepet = repmat(triangle(t),1,repet)

//decomp10 = fourier(2*%pi, triangle(x), x, t, 10)


clear decomp10
decomp10 = fourier(2*%pi, triangle(x), x, trepet, 10)
clear decomp20
decomp20 = fourier(2*%pi, triangle(x), x, trepet, 20)
clear decomp100
decomp100 = fourier(2*%pi, triangle(x), x, trepet, 100)


plot(trepet, trianglerepet)
plot(trepet, decomp10, 'r')
plot(trepet, decomp20, 'g')
plot(trepet, decomp100, 'm')

