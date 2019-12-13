function [index, modes]=ii_meanshift(data, h, theta)

N=size(data,1);
modes = []; 
index = zeros(N,1);

% Create k-d tree
kd_tree = createns(data,'nsmethod','kdtree');

for i=1:N  
    
    % print the progress
    if (mod(i,10)==0)
       i ;
    end
    
    %Find mode
    cur_mode = find_mode(data, data(i,:), h, theta, kd_tree);
   
    %Generate the first mode
    if i==1
        modes = cur_mode;
        index(i) = 1;
    else
        %Check distance from current peak to all other peaks
        for j=1:size(modes,1)
            temp_dis=norm(cur_mode-modes(j,:));
            if (temp_dis<h/5)  % merge cluster
                 index(i) = j;
                 break;
            end
            if (j==size(modes,1)) % a new cluster
                modes=[modes; cur_mode];
                index(i) = j+1;
            end
        end
    end
end



end