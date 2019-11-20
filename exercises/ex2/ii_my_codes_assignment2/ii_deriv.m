function deriv_img = ii_deriv(I,x_order,y_order) 
% Condition: x_order>=0  && y_order>=0 && (x_order+y_order!=0)

% Method 1 Do Derivation x_order or y_order times
% function ii_deriv_1d needed to be called
deriv_img_x=I;
deriv_img_y=I;
m=0;
n=0;

% x_deriv
while (m<x_order)
    deriv_img_x=ii_deriv_1d(deriv_img_x,1,0);
    m=m+1;
end 
% y_deriv
while (n<y_order)
    deriv_img_y=ii_deriv_1d(deriv_img_y,0,1);
    n=n+1;
end

% Add them together
if x_order==0
    deriv_img=deriv_img_y;
elseif y_order==0
    deriv_img=deriv_img_x; 
else
    deriv_img=deriv_img_x+deriv_img_y;
end

% Method 2 
%{
if x_order<2 && y_order<2
  for i=2:size(I,1)-1
     for j=2:size(I,2)-1
       deriv_img(i,j)=x_order*(I(i,j+1)-I(i,j-1))+y_order*(I(i+1,j)-I(i-1,j));
     end
  end
else 
  for i=3:size(I,1)-2
     for j=3:size(I,2)-2
       deriv_img(i,j)=x_order/2*(I(i,j+2)+I(i,j-2)-2*I(i,j))+y_order/2*(I(i+2,j)+I(i-2,j)-2*I(i,j));
     end
  end
end
%}
% may have some problm here when do 1-order and 2-order deriv at the same time

end