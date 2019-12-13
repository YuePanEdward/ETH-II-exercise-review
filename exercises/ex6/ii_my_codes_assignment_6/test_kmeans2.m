disp('Random data (run multiple times for different results')
true_cn = randi([8, 12], 1);
spread = 5*rand(1)+5;
obj = gmdistribution(randn(true_cn,2)*spread,repmat(eye(2),[1 1 true_cn]), ones(1,true_cn)/true_cn);
Y = random(obj, 1000);
ii_kmeans(Y, 6, 100, 100);
% ii_kmeans(Y, 3, 100, 100);
% ii_kmeans(Y, 9, 100, 100);
disp('K-Means done')