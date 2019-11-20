function [normal, threshold] = ii_train_lda(X,Y)
     X0=X(Y==0,:);
     X1=X(Y==1,:);
     
     mean_X0=mean(X0);
     mean_X1=mean(X1);
     S_0=zeros(size(X,2));
     S_1=zeros(size(X,2));
     
     for i=1:size(X0,1)
         S_0=S_0+(X0(i,:)-mean_X0)'*(X0(i,:)-mean_X0);
     end
     for i=1:size(X1,1)
         S_1=S_1+(X1(i,:)-mean_X1)'*(X1(i,:)-mean_X1);
     end

     S_w=S_0+S_1;
     
     normal=S_w\(mean_X1-mean_X0)';
     threshold=(0.5*(mean_X0+mean_X1)')'*normal;
end