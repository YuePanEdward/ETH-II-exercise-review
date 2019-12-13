function [kd]=ii_kde(data, h, kernel_type, q_points)
N=size(data,1);
d=size(data,2);
front=1/h^d/N;
M=size(q_points,1);
kd=zeros(M,1);

if (strcmpi(kernel_type,'parzen'))
    disp('Use parzen kernel');
    for i=1:M
        count=0;
        for j=1:N
            if (max(abs(q_points(i,:)-data(j,:)))<h/2)
                count=count+1;
            end
        end
        kd(i)=front*count;
    end
    
elseif(strcmpi(kernel_type,'normal'))
    disp('Use normal kernel');
    for i=1:M
        back=0;
        for j=1:N
            back=back+exp(-0.5*(norm(q_points(i,:)-data(j,:),2))^2/h^2);
        end
        kd(i)=front/(2*pi)^(d/2)*back;        
    end
    
elseif(strcmpi(kernel_type,'epanechnikov'))
    disp('Use epanechnikov kernel');
    Vd=pi^(d/2)/gamma(d/2+1);
    for i=1:M
        back=0;
        for j=1:N
            back=back+max(0,1-(norm(q_points(i,:)-data(j,:),2))^2/h^2);
        end
        kd(i)=front*(d+2)/2/Vd*back;        
    end 
else
    disp('[Error] Wrong kernel_type');
    
end

end