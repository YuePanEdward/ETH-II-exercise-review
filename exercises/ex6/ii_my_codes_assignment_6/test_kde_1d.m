rng('default')
data = [randn(2000,1)-2;randn(1500,1)+2];
true_pdf = @(x) 4/7*normpdf(x,-2) + 3/7*normpdf(x,+2);
sample_points = (-5:0.05:5)';
figure(1)
subplot 221
visualize_kde(data, sample_points, 1, true_pdf)
title 'Bandwidth 1'
subplot 222
visualize_kde(data, sample_points, 2, true_pdf)
title 'Bandwidth 2'
subplot 223
visualize_kde(data, sample_points, 0.5, true_pdf)
title 'Bandwidth 0.5'
subplot 224
[n, xout] = hist(data, 30);
bar(xout, n/sum(n(:)))
title 'Histogram'