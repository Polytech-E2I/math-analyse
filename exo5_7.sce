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
        disp('YES'),
    else,
        disp('NO'),
    end
endfunction

testinverse(J,J)
testinverse(J,A)
