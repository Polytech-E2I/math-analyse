A=[
    3 1 1 1;
    1 3 1 1;
    1 1 3 1;
    1 1 1 3
]

B=[
    1 2 1 0;
    3 4 0 1;
    0 0 2 1;
    0 0 4 2
]

[Avec, Aval] = spec(A)
[Bvec, Bval] = spec(B)