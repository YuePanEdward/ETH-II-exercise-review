function [model] = ii_train_logress(X,Y)
%input Y: -1 or 1
Y(Y==-1)=0;
model = glmfit(X, [Y ones(size(Y,1),size(Y,2))], 'binomial', 'link', 'logit');


end