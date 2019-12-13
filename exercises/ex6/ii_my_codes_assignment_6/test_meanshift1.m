rng(42)
load kmeans_example6_1
X = kmeans_example6_1(randsample(size(kmeans_example6_1,1),400),:);

[idx, centers] = ii_meanshift(X, 5, 0.001); % 0.001

figure(1)
hold off
scatter(X(:,1),X(:,2),[],idx)
colormap(hsv(size(centers,1)))
hold on
plot(centers(:,1),centers(:,2),'kx', 'MarkerSize', 12,'LineWidth', 2)
plot(centers(:,1),centers(:,2),'ko', 'MarkerSize', 12,'LineWidth', 2)