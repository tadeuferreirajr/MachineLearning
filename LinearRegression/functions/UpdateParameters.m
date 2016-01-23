function y = UpdateParameters(theta0,theta1,x,y,alpha)
    
    m = length(x);
    sum1 = 0;
    sum2 = 0;
    
    for i = 1:m    
        sum1 = sum1 + theta0 + theta1*x(i) - y(i);
        sum2 = sum2 + (theta0 + theta1*x(i) - y(i))*x(i);
    end

    y = [theta0 - (alpha/m)*(sum1),theta1 - (alpha/m)*(sum2)];

end