function theta = ii_fit_poly_ridge(x,y,degree,lambda)

%To solve : A*theta=b
A=zeros(size(x,1),degree);
for i=1:size(x,1)
    for j=1:degree
        A(i,j)=x(i)^(degree+1-j);
    end
end
b=y;

%Estimate theta using matlab function
theta=ridge(b,A,lambda,0);
theta=[theta(2:degree+1);theta(1)];

% Manually do least square
% %Assign A
% A=zeros(size(x,1),degree+1);
% for i=1:size(x,1)
%     for j=1:degree+1
%         A(i,j)=x(i)^(degree+1-j);
%     end
% end
% 
% %Assign b
% b=y;

%Estimate theta using least square (done manually)
% theta=inv(lambda*eye(degree+1)+A'*A)*(A'*b);


end