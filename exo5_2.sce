
X=[1:0.01:10]
Y=flipdim(X,2)

temp = X(7)
X(7)=X(5)
X(5)=temp

