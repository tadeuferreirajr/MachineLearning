function y = MultiUpdateParameters(parameters,x,y,alpha)
    
    m = length(x);
    sum = zeros([size(parameters,1),1]);
    
    for i = 1:m    
        sum = sum + (transpose(parameters)*x(:,i) - y(i))*x(:,i);
    end

    y = parameters - (alpha/m)*sum;

end