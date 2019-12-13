rng('default')
data = 0;
sample_points = (-3:0.05:3)';
figure(1)
subplot 221
visualize_kde(data, sample_points, 1)
title 'Bandwidth 1'
subplot 222
visualize_kde(data, sample_points, 2)
title 'Bandwidth 2'
subplot 223
visualize_kde(data, sample_points, 0.5)
title 'Bandwidth 0.5'
subplot 224
[n, xout] = hist(data, 30);
bar(xout, n/sum(n(:)))
title 'Histogram'