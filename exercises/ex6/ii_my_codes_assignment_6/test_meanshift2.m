true_cn = randi([8, 12], 1);
spread = 5*rand(1)+1;
obj = gmdistribution(randn(true_cn,2)*spread,repmat(eye(2),[1 1 true_cn]), ones(1,true_cn)/true_cn);
X = random(obj, 800);
[idx, centers] = ii_meanshift(X, 5, 0.001);

% [idx_2, centers_2] = ii_meanshift(X, 3, 0.001);
% 
% [idx_3, centers_3] = ii_meanshift(X, 7, 0.001);
% 
% [idx_4, centers_4] = ii_meanshift(X, 9, 0.001);

figure(2)
hold off
scatter(X(:,1),X(:,2),[],idx)
colormap(hsv(size(centers,1)))
hold on
plot(centers(:,1),centers(:,2),'kx', 'MarkerSize', 12,'LineWidth', 2)
plot(centers(:,1),centers(:,2),'ko', 'MarkerSize', 12,'LineWidth', 2)

% figure(3)
% hold off
% scatter(X(:,1),X(:,2),[],idx_2)
% colormap(hsv(size(centers_2,1)))
% hold on
% plot(centers_2(:,1),centers_2(:,2),'kx', 'MarkerSize', 12,'LineWidth', 2)
% plot(centers_2(:,1),centers_2(:,2),'ko', 'MarkerSize', 12,'LineWidth', 2)
% 
% figure(4)
% hold off
% scatter(X(:,1),X(:,2),[],idx_3)
% colormap(hsv(size(centers_3,1)))
% hold on
% plot(centers_3(:,1),centers_3(:,2),'kx', 'MarkerSize', 12,'LineWidth', 2)
% plot(centers_3(:,1),centers_3(:,2),'ko', 'MarkerSize', 12,'LineWidth', 2)
% 
% figure(5)
% hold off
% scatter(X(:,1),X(:,2),[],idx_4)
% colormap(hsv(size(centers_4,1)))
% hold on
% plot(centers_4(:,1),centers_4(:,2),'kx', 'MarkerSize', 12,'LineWidth', 2)
% plot(centers_4(:,1),centers_4(:,2),'ko', 'MarkerSize', 12,'LineWidth', 2)
% 
% ii_kmeans(X, 6, 100, 10);