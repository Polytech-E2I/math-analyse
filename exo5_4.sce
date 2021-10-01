A=ones(4,4)

function [y]=sumcol1(x)
    lignes = size(x)(1)
    colonnes = size(x)(2)
    
    temp=zeros(1,colonnes)
    
    for c=1:colonnes,
        for l=1:lignes,
            temp(c) = temp(c)+x(l,c)
        end        
    end
    
    y=temp
endfunction

function [y]=sumcol2(x)
    y=sum(x,'c')
endfunction
