function smooth_img = ii_sobel(I,x_order,y_order,gaussian_s)
% Firstly do the derivation (for sobel, usually the order should be 1)
deriv_img=ii_deriv(I,x_order,y_order);

% Then do the gaussian smoothing
smooth_img=ii_gaussian(deriv_img,gaussian_s);

end