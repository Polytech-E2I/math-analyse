
delta = (2*%pi)/200
t = 0:delta:2*%pi

s2 = sin(t) - (1/2)*sin(2*t)
//plot(t, s2)

s3 = sin(t) - (1/2)*sin(2*t) + (1/3)*sin(3*t)
//plot(t, s3)

function [y]=somme(n,t)
    retour=0
    for i=1:n
        retour = retour + 1/i * sin(i.*t)
    end
    
    y = retour
endfunction

plot(t, somme(10, t))
plot(t, somme(20, t))
plot(t, somme(50, t))
plot(t, somme(200, t))


function [y]=dentsdescie2(x)
    if(x < 0), then
        y = -(1/2) * x + (floor(x/(2*%pi)) * (%pi/2))
    else,
        y = -(1/2) * x + (ceil(x/(2*%pi)) * (%pi/2))
    end
endfunction

function [y]=dentsdescie(x)
    y = -(1/2) * x + (%pi/2)
endfunction

plot(t, dentsdescie(t), 'r')
