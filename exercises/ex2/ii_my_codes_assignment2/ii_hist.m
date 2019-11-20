function hist = ii_hist(I,s)
% Helpful Matlab functions: linspace, imquantize

thre_vec=linspace(0,1,s+1);

% Squeeze to s levels (value from 1 to s)
hist_img=imquantize(I,thre_vec(2:s));

hist=zeros(s,1);
% Accumulate the histogram bars
for i=1:size(hist_img,1)
    for j=1:size(hist_img,2)
        hist(hist_img(i,j))=hist(hist_img(i,j))+1;
    end
end

end