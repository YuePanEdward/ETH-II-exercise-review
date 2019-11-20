function prediction = ii_predict_face_reg(X_train, query, lambda)
   
   [lgth, wdth, num_train_images] = size(X_train(:, :, :));

   half_wdth_left=round(wdth/2); % 0.0->+0  0.5->+1  
   half_wdth_right=wdth-half_wdth_left;
   
   vec_length_left=half_wdth_left*lgth;
   vec_length_right=half_wdth_right*lgth;
   
   % F3 fully connected 
   tic=clock;
   
   % initialization
   X=ones(num_train_images,vec_length_left+1);  
   Y=ones(num_train_images,vec_length_right);
   Y_residual=ones(num_train_images,vec_length_right);
   Y_predicted=[];
  
   % Assign the value for X and Y
   for i=1:num_train_images
       for j=1:lgth
            for k=1:half_wdth_left
                 X(i,(j-1)*half_wdth_left+k)=X_train(j,k,i);      
            end
            for k=1:half_wdth_right
                Y(i,(j-1)*half_wdth_right+k)=X_train(j,k+half_wdth_left,i);
            end
       end
   end
   
    % Ridge Regression
   theta=(X'*X + num_train_images*lambda*eye(vec_length_left+1))\(X'*Y);
   
   % Levenberg-Marquardt Optimization 

%    % Get Jacobi
%    J=X;
%    
%    % initial guess
%    theta=zeros(vec_length_left+1,vec_length_right);
%    for i=1:vec_length_right
%        m=floor((i-1)/half_wdth_right)+1;
%        n=half_wdth_left+1-(mod(i-1,half_wdth_right)+1);
%        index_left=(m-1)*half_wdth_left+n;
%        theta(index_left,i)=1;
%    end
%    
%    iter_num=0;
%    max_iter_num=10;
%    
%    while (iter_num<max_iter_num)
%    
%        Y_predicted= X * theta;
%   
%        Y_residual=Y-Y_predicted;
%    
%        delta_theta=inv(lambda*eye(vec_length_left+1)+J'*J)*J'*Y_residual;
%    
%        theta=theta+delta_theta;
%        
%        iter_num=iter_num+1;
%        
%    end
   
   % predict the result
   prediction=[];  
   [lgth, wdth, num_test_images] = size(query(:, :, :));
   for i=1:num_test_images
      temp_pred_vec=[reshape(query(:,:,i)',[1 vec_length_left]) 1] * theta;
      prediction(:,:,i)= reshape(temp_pred_vec,[half_wdth_right lgth])';
   end
   
   toc=clock;
   run_time_ridge=etime(toc,tic)
end 



