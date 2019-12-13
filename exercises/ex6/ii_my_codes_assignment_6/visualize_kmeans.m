function [ output_args ] = visualize_kmeans( X, idx, centers, updated, cur_iter)
%VISUALIZE_KMEANS Visualize k-means step
figure(1)
hold off
scatter(X(:,1),X(:,2),[],idx)
colormap(hsv(size(centers,1)))
hold on
plot(centers(:,1),centers(:,2),'kx', 'MarkerSize', 12,'LineWidth', 2)
plot(centers(:,1),centers(:,2),'ko', 'MarkerSize', 12,'LineWidth', 2)
if size(centers,1) > 2
%voronoi(centers(:,1),centers(:,2),'k')
end
if updated
    title(['After update step - iteration ',num2str(cur_iter)]);
else
    title(['After assignment step - iteration ',num2str(cur_iter)]);
end
waitforbuttonpress
end

