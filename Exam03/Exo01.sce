clear all
close

function y = Derivee(x, f, k)
    y = (f(k+1)-f(k)) / (x(k+1)-x(k))
endfunction

function h = H(a, b, n)
    h = (b-a)./n
endfunction

function I = Simpson(f, a, b, n)
    sum1 = 0
    for i = 1:length(f)
        sum1 = sum1 + f(i)
    end
    sum2 = 0
    for i = 1:length(f)
        sum2 = sum2 + f((2*i+1)/2)
    end
    
    I = H(a,b,n)/6 * (f(1) + f(n-1) + 2*sum1 + 4*sum2)
endfunction

x = [0,10,20,30,40,50,60,70,80,90,100]
Hx = [100,84.7135,76.2285,49.5312,33.5646,20.9830,12.9488,10,12.0038,18.2018,27.3379]
Hpx = []

for i = 1:(length(x)-1)
    Hpx(i) = Derivee(x, Hx, i)
end

L = Simpson(sqrt(1+Hpx.*Hpx),0,100,100)
printf("L = %f\n", L)
