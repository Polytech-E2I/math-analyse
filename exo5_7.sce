A=[
    -1  1  1 -2;
     1 -1 -2  1;
     1 -2 -1  1;
    -2  1  1 -1
]

J=[
    0 0 0 1;
    0 0 1 0;
    0 1 0 0;
    1 0 0 0
]

function testinverse(X,Y)
    if X*Y == eye(X), then
        mprintf YASS,
    else,
        mprintf NOOO,
    end
endfunction
