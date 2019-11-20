function theta = ii_fit_poly( x,y,degree )
%II_FIT_POLY Summary of this function goes here
%   Detailed explanation goes here

%To solve : A*theta=b
%Assign A
A=zeros(size(x,1),degree+1);
for i=1:size(x,1)
    for j=1:degree+1
        A(i,j)=x(i)^(degree+1-j);
    end
end

%Assign b
b=y;

%Estimate theta (matlab_function)
theta=A\b

%Estimate theta using least square (manully)
% theta=inv(A'*A)*(A'*b)


end

