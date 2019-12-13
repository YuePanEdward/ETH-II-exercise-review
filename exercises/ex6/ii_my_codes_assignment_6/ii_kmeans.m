function [index, centers]=ii_kmeans(data, K, iter ,show_frequency) 
% this show_frequency parameter here is just for visualization (update the
% figure each show_frequency iteartions)

N=size(data,1);
cur_centers=data(randsample(N,K),:);

cur_iter=0;

while(cur_iter<iter)
    
    % assignment
    dist_mat=zeros(N,K);
    for i=1:N
       for j=1:K
          dist_mat(i,j)=norm(data(i,:)-cur_centers(j,:));
       end
    end
    [~,cur_index]=min(dist_mat');
    cur_index=cur_index';
    
    % visualize
    if(mod(cur_iter,show_frequency)==0)
       visualize_kmeans( data, cur_index, cur_centers, false, cur_iter+1);
    end
    
    % update
    for i=1:K
       points_id=find(cur_index==i);
       if (size(points_id,2)>0)
          cur_centers(i,:)= mean(data(points_id,:));
       else
          cur_centers(i,:)= data(randsample(N,1),:);
       end
    end
    
    % visualize
    if(mod(cur_iter,show_frequency)==0)
      visualize_kmeans( data, cur_index, cur_centers, true,cur_iter+1 );
    end
    cur_iter=cur_iter+1;
end
% final result
index=cur_index;
centers=cur_centers;
visualize_kmeans( data, index, centers, true, iter );

end