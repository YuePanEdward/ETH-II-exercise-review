function [ Y ]= ii_test_logress(model,X)
    % use glval
    Y=glmval(model,X,'logit');
    
    % impliment sigmoid yourself
    % Z=([ones(size(X,1),1) X]*model)';
    % Y=(1./(1+exp(-Z)))';

end