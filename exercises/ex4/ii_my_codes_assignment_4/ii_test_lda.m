function [ Y ] = ii_test_lda( X, normal, threshold )
% if X*normal > threshold then class 1, otherwise class 0
Y = (X*normal-threshold > 0);
end
