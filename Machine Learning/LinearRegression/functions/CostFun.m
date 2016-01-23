% Cost Function
function y = CostFun(theta0,theta1,x,y)
    
    m = length(x);
    sum = 0;

    for i = 1:m
        sum = sum + (theta0 + theta1*x(i) - y(i))^(2);
    end

    y = (1/2*m)*(sum);
end