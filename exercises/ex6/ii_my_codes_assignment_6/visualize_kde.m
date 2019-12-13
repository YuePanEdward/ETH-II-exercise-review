function visualize_kde( data, sample_points, h, true_pdf )
if nargin < 4
    true_pdf = [];
end
hold off
value = ii_kde(data, h, 'parzen', sample_points);
plot(sample_points, value,'r-');
hold on
value = ii_kde(data, h, 'normal', sample_points);
plot(sample_points, value,'b-');
value = ii_kde(data, h, 'epanechnikov', sample_points);
plot(sample_points, value,'g-');
if nargin == 4
    value = true_pdf(sample_points);
    plot(sample_points, value, 'k--')
    legend('Parzen', 'Normal', 'Epanechnikov','True')
else
    legend('Parzen', 'Normal', 'Epanechnikov')
end

