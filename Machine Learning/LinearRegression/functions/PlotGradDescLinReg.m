% Plot Function
function PlotGradDescLinReg(Theta0,Theta1,x,y,CostParameter)
    
      % Cost Surface
        m = length(x);
        sum = 0;
        range = 40;
        Theta0Range = -range:1:range;
        Theta1Range = -range:1:range;
        Cost = ones(length(Theta0Range));

        for p = 1:length(Theta0Range)
            for q = 1:length(Theta1Range)
                for i = 1:m
                    sum = sum + (Theta0Range(p) + Theta1Range(q)*x(i) - y(i))^(2);
                end
                Cost(p,q) = (1/2*m)*(sum);
                sum = 0;
            end
        end
    
    % Plotting Results
      subplot(1,3,1)
        axis([0 5 0 5])
        scatter(x,y)
        hold on
        for i = 1:length(CostParameter)
            comet(x,Theta0(i)+ Theta1(i)*x);
        end
          
      subplot(1,3,2)
        contour(Theta0Range,Theta1Range,Cost);
        xlabel('\theta_0')
        ylabel('\theta_1')
        hold on
        for i = 1:length(CostParameter)
            comet3(Theta0(i),Theta1(i),Cost(i));
        end
       
    subplot(1,3,3);
        surf(Theta0Range,Theta1Range,Cost);
        xlabel('\theta_0')
        ylabel('\theta_1')
        hold on
        for i = 1:length(CostParameter)
            comet3(Theta0(i),Theta1(i),CostParameter(i));
        end
end