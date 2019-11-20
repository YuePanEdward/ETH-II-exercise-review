% first-order one dimensional deriv [-1 0 1] 
function deriv_1d_img = ii_deriv_id(I, x_deriv, y_deriv) % x_deriv and y_deriv should be 0 or 1
  deriv_1d_img = I;
  for i=2:size(I,1)-1
     for j=2:size(I,2)-1
         deriv_1d_img(i,j)=x_deriv*(I(i,j+1)-I(i,j-1))+y_deriv*(I(i+1,j)-I(i-1,j));
     end
  end
end
