% Multivariate Cost Function
function y = MultiCostFun(parameters,x,y)
    
    m = length(x);
    sum = 0;

    for i = 1:m
        sum = sum + (transpose(parameters)*x(:,i) - y(i))^(2);
    end

    y = (1/2*m)*(sum);
end