entiers=[1:1:100]
somme=sum(entiers)

/*
function [y]=factorielle(x)
    if(x < 0), then
        y=-1,
    elseif(x <= 1),
        y=1,
    else,
        y=x*factorielle(x-1),
    end
endfunction
*/

function [y]=factorielle(n)
    y=prod([1:1:n])
endfunction
