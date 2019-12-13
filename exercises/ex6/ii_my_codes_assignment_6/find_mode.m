function mode = find_mode(X, q0, h, theta, kd_tree)
    dimension=size(X,2);
    cur_q = q0;
    shift_dis = realmax;
    
    count=0;
    while(shift_dis>=theta)
       [neighbor_idx, d_vec] = rangesearch(kd_tree,cur_q,h);
       inliers=X(neighbor_idx{1}',:);
       weight=1-(d_vec{1}').^2./(h^2);
       
       new_q=sum(repmat(weight,1,dimension).*inliers)./sum(weight);
       
       shift_dis=norm(new_q-cur_q);
       cur_q=new_q;
       count=count+1;
    end
    count;
    mode = cur_q;

end
