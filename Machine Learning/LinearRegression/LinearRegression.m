%% LINEAR REGRESSION

% It takes a data and perform a linear regression to determine the 
% curve that describes the relationship among the variables of the data.

%% INFO

% Author: Tadeu Ferreira de Sousa Júnior
% Date: Jan/2016
% visit: http://datascienceinsights.blogspot.com.br/

%% INITIALIZATION
addpath('functions/');
addpath('data/');

clear all;
close all;

%% UNIVARIATE LINEAR REGRESSION APPLICATION

% Reading data
data = importdata('Data1.txt',',',0);

x = data(:,1);
y = data(:,2);

% Plotting data
scatter(x,y,'filled','r');
xlabel('x');
ylabel('y')
grid on;

% Initial guesses for parameters
parameters = [0,0];
theta0 = parameters(1);
theta1 = parameters(2);

alpha = 0.02; % learning rate


CostHist = [];
num_iter = [];
Theta0Hist = [];
Theta1Hist = [];

J = CostFun(theta0,theta1,x,y);
CostHist = [CostHist J];

num_iter = [num_iter 1];
Theta0Hist = [Theta0Hist theta0];
Theta1Hist = [Theta1Hist theta1];

i = 2;
delta = 100;

while delta > 10^(-7)
   
    % Updating parameters theta0 and theta1
    parameters = UpdateParameters(theta0,theta1,x,y,alpha);
    theta0 = parameters(1);
    theta1 = parameters(2);
    Theta0Hist = [Theta0Hist theta0];
    Theta1Hist = [Theta1Hist theta1];
    
    J = CostFun(theta0,theta1,x,y); 
    
    CostHist = [CostHist J];
    
    delta = abs(CostHist(i-1) - CostHist(i));
    
    % Diverging Handler
    if abs(CostHist(i) > 2*abs(CostHist(i-1)))
        disp('The cost function is diverging! Consider a smaller value for alpha.')
        return
    end
       
    num_iter = [num_iter i];
    i = i + 1;
end


% Cost Plot
fig = figure;
plot(num_iter,CostHist,'LineWidth',3);
xlabel('Number of iterations');
ylabel('Cost');
grid on

% Contour Plot
range = 500;
Theta0Range = linspace(-range,range);
Theta1Range = linspace(-range,range);
sum = 0;
m = length(x);

for p = 1:length(Theta0Range)
    for q = 1:length(Theta1Range)
        for i = 1:m
            sum = sum + (Theta0Range(p) + Theta1Range(q)*x(i) - y(i))^(2);
        end
        Cost(p,q) = (1/2*m)*(sum);
        sum = 0;
    end
end

fig = figure;
grid on
contour(Theta0Range,Theta1Range,Cost);
xlabel('\theta_0')
ylabel('\theta_1')
hold on
scatter(Theta0Hist(end),Theta1Hist(end),'filled','LineWidth',3);
grid on


% Estimated curve plot
theta0est = Theta0Hist(end); % estimated theta0
theta1est = Theta1Hist(end); % estimated theta 1

yestimated = theta0est + theta1est*x;

fig = figure;
scatter(x,y,'filled','r');
hold on
plot(x,yestimated,'b','LineWidth',2);
xlabel('x');
ylabel('y estimated');
legend('Original Data','Estimated curve');
grid on


%% MULTIVARIATE LINEAR REGRESSION APPLICATION 

% Reading data
data = importdata('Data2.txt',',',0);

x = data;
x(:,end) = [];
unitColumn = ones([size(x,1),1]);

x = transpose([unitColumn x]);
y = data(:,end);

% Plotting data
fig = figure;
scatter3(transpose(x(2,:)),transpose(x(3,:)),y,'filled','r');
xlabel('x');
ylabel('y');
zlabel('z');
grid on

% Featuring Scale with Mean Normalization
x = transpose(x);
for j = 2:size(x,2)
    mean_value = mean(x(:,j));
    std_value = std(x(:,j));
    for i = 1:size(x,1)
        x(i,j) = (x(i,j) - mean_value)/(std_value);
    end   
end
x = transpose(x);

% % Initial guesses for parameters
parameters = [0;0;0];
alpha = 1; % learning rate


CostHist = [];
num_iter = [];
ThetaHist = [];

 
J = MultiCostFun(parameters,x,y);
CostHist = [CostHist J];
 
num_iter = [num_iter 1];
ThetaHist = [ThetaHist parameters];
 
i = 2;
delta = 100;
 
while delta > 10^(-7)
    
    % Updating parameters theta0 and theta1
    parameters = MultiUpdateParameters(parameters,x,y,alpha);
     
    ThetaHist = [ThetaHist parameters];

    J = MultiCostFun(parameters,x,y); 
    
    CostHist = [CostHist J];
    
    delta = abs(CostHist(i-1) - CostHist(i));
    
    % Diverging Handler
    if abs(CostHist(i) > 2*abs(CostHist(i-1)))
        disp('The cost function is diverging! Consider a smaller value for alpha');
        return
    end
    
    num_iter = [num_iter i];
    i = i + 1;
end


% Cost Plot
fig = figure;
plot(num_iter,CostHist,'LineWidth',3);
xlabel('Number of iterations');
ylabel('Cost');
grid on

% Estimated curve plot
yestimated = transpose(parameters)*x;

x = data;
x(:,end) = [];
unitColumn = ones([size(x,1),1]);
x = transpose([unitColumn x]);

fig = figure;
scatter3(x(2,:),x(3,:),y,'filled','r');
hold on
scatter3(x(2,:),x(3,:),yestimated,'b','LineWidth',2);
xlabel('x');
ylabel('y');
legend('Original Data','Estimated Data');