function smooth_img = ii_gaussian(I,s)
 % Helpful Matlab functions: fspecial, imfilter
 
 smooth_img = imgaussfilt(I,s);
  
 % Determine the standard deviation of the gaussian kernel
 standard_dev=2.0;
 gauss_filter=fspecial('gaussian',s,standard_dev);% default 0.5
 smooth_img=imfilter(I,gauss_filter);
 
end
