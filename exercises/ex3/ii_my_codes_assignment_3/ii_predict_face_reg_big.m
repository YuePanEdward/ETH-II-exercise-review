function prediction = ii_predict_face_reg_big(X_train, query, lambda)
   
   % Gradient Descend
   tic=clock;

   [lgth, wdth, num_train_images] = size(X_train(:, :, :));
   half_wdth_left=round(wdth/2); % 0.0->+0  0.5->+1  % if using int32, it may cause some problem
   half_wdth_right=wdth-half_wdth_left;
   
   vec_length_left=half_wdth_left*lgth;
   vec_length_right=half_wdth_right*lgth;
   
   % initialization
   X=ones(num_train_images,vec_length_left+1);  
   Y=ones(num_train_images,vec_length_right);
   
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
   
   % initial guess of theta
   theta=zeros(vec_length_left+1,vec_length_right);
   for i=1:vec_length_right
       m=floor((i-1)/half_wdth_right)+1;
       n=half_wdth_left+1-(mod(i-1,half_wdth_right)+1);
       index_left=(m-1)*half_wdth_left+n;
       theta(index_left,i)=1;
   end
   
   % Iteration  parameters
   iter_num=0;
   d_theta_magnitude=1e-6;
   epsion=d_theta_magnitude*5;
   max_iter_num=20;
   d_theta=realmax;
   
   % Iterative process
   while (any(any(d_theta>epsion)) && iter_num<max_iter_num)
       % Calculate Jacobi 
       % Target function :
       % f(theta)=(Xtheta-Y)T(Xtheta-Y)+lambda*thetaTtheta
       % So we get the Jacobia
       J=X'* (X*theta-Y) + 2*lambda*theta;
       J_magnitude=mean(mean(J));
       learning_rate=d_theta_magnitude/J_magnitude;
       % Update theta
       d_theta=learning_rate*J;
       theta=theta-d_theta;    
       
       iter_num=iter_num+1
    end
      
   % predict the result
   prediction=[];  
   [lgth, wdth, num_test_images] = size(query(:, :, :));
   for i=1:num_test_images
      temp_pred_vec=[reshape(query(:,:,i)',[1 vec_length_left]) 1] * theta;
      prediction(:,:,i)= reshape(temp_pred_vec,[half_wdth_right lgth])';
   end
   
   
   toc=clock;
   
   run_time_g_d_big=etime(toc,tic)
   
end