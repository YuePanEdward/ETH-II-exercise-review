function visualize_kde_2d( data, sample_points_x, sample_points_y, true_pdf )
%subplot 221
hold off
[grid_x, grid_y] = meshgrid(sample_points_x, sample_points_y);
sample_points = [grid_x(:) grid_y(:)];

figure(1)
h=2;
value = ii_kde(data, h, 'parzen', sample_points);
plot_helper(sample_points_x, sample_points_y, reshape(value, size(grid_x)));
title 'Parzen (h=2)'

figure(2)
h=1;
value = ii_kde(data, h, 'epanechnikov', sample_points);
plot_helper(sample_points_x, sample_points_y, reshape(value, size(grid_x)));
title 'Epanechnikov (h=1)'

figure(3)
h=0.5;
value = ii_kde(data, h, 'normal', sample_points);
plot_helper(sample_points_x, sample_points_y, reshape(value, size(grid_x)));
title 'Normal (h=0.5)'

figure(4)
value=true_pdf(sample_points);
plot_helper(sample_points_x, sample_points_y, reshape(value, size(grid_x)));
title 'True distribution'

figure(5)
h=1;
value = ii_kde(data, h, 'parzen', sample_points);
plot_helper(sample_points_x, sample_points_y, reshape(value, size(grid_x)));
title 'Parzen (h=1)'

figure(6)
h=0.5;
value = ii_kde(data, h, 'epanechnikov', sample_points);
plot_helper(sample_points_x, sample_points_y, reshape(value, size(grid_x)));
title 'Epanechnikov (h=0.5)'

figure(7)
h=1;
value = ii_kde(data, h, 'normal', sample_points);
plot_helper(sample_points_x, sample_points_y, reshape(value, size(grid_x)));
title 'Normal (h=1)'

figure(8)
h=0.5;
value = ii_kde(data, h, 'parzen', sample_points);
plot_helper(sample_points_x, sample_points_y, reshape(value, size(grid_x)));
title 'Parzen (h=0.5)'

figure(9)
h=2;
value = ii_kde(data, h, 'epanechnikov', sample_points);
plot_helper(sample_points_x, sample_points_y, reshape(value, size(grid_x)));
title 'Epanechnikov (h=2)'

figure(10)
h=2;
value = ii_kde(data, h, 'normal', sample_points);
plot_helper(sample_points_x, sample_points_y, reshape(value, size(grid_x)));
title 'Normal (h=2)'

end

function plot_helper(sample_points_x, sample_points_y, values)
h=surf(sample_points_x, sample_points_y, values);
shading interp
set(h,'FaceLighting','phong','FaceColor','interp',...
      'AmbientStrength',0.5)
light('Position',[1 0 0],'Style','infinite');
end