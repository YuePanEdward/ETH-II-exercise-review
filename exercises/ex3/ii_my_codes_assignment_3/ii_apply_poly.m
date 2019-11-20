function predicted_y = ii_apply_poly( theta, x )
%II_APPLY_POLY Summary of this function goes here
%   Detailed explanation goes here

predicted_y=zeros(size(x,1),1);

for i=1:size(theta,1)
   predicted_y=predicted_y+theta(i)*(x.^(size(theta,1)-i));
end

end

