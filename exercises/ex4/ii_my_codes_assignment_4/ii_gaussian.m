function smooth_img = ii_gaussian(I,s)
 % Helpful Matlab functions: fspecial, imfilter
 
 %smooth_img = imgaussfilt(I,s);
  
 % Determine the standard deviation of the gaussian kernel
 standard_dev=s/6; % each side 3*sigma total size=6*sigma
 gauss_filter=fspecial('gaussian',s, standard_dev);
 smooth_img=imfilter(I,gauss_filter);
 
end
