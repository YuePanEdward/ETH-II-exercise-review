function smooth_img = ii_variance(I,s) 
% Attention: the s here is the half size of the neighborhood
% Which means the neighborhood's actual size should be (2*s+1)*(2*s+1)
% Helpful Matlab Functions: padarray, colfilt

% Do the padding
img_pad=padarray(I,[s s],'symmetric','both');

% Variance calculation function
func_variance='var(x)';

% Calculate variance
smooth_img_pad=colfilt(img_pad,[2*s+1 2*s+1],'sliding',func_variance);

% Keep the same size as the original image
smooth_img=smooth_img_pad(s+1:size(smooth_img_pad,1)-s, s+1:size(smooth_img_pad,2)-s);

end