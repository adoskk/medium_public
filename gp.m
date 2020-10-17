% adapted from https://www.mathworks.com/help/stats/fitrgp.html
% author: Mengliu Zhao
% contact: mengliuz@sfu.ca
close all
clear
clc

rng(0,'twister'); % For reproducibility
n = 1000;
x = linspace(-10,10,n)';
y = 1 + x*5e-2 + sin(x)./x + 0.2*randn(n,1);
gprMdl = fitrgp(x,y,'Basis','linear',...
'FitMethod','exact','PredictMethod','exact');
[ypred, spred] = resubPredict(gprMdl);

figure(1)
plot(x,ypred+spred,'k-','LineWidth',1.5);
plot(x,y,'b.');
hold on;
plot(x,ypred,'r','LineWidth',1.5);
plot(x,ypred+spred,'k-','LineWidth',1.5);
plot(x,ypred-spred,'k-','LineWidth',1.5);
xlabel('x');
ylabel('y');
legend('Data','mean', 'std');
hold off
title('Gaussian process')

figure(2)
ybest = min(y);
gamma = (ybest - ypred)./spred;
plot(x,y,'b.');
hold on;
plot(x,ypred,'r','LineWidth',1.5);
plot(x,ypred+spred,'k-','LineWidth',1.5);
plot(x,ypred-spred,'k-','LineWidth',1.5);
plot(x, gamma, 'c', 'LineWidth',1.5)
xlabel('x');
ylabel('y');
legend('Data','mean', 'std', 'Gamma');
hold off
title('Gamma function')

figure(3)
plot(x,y,'b.');
hold on;
plot(x,ypred,'r','LineWidth',1.5);
plot(x,ypred+spred,'k-','LineWidth',1.5);
plot(x,ypred-spred,'k-','LineWidth',1.5);
plot(x, cumsum(gamma), 'g', 'LineWidth',1.5)
xlabel('x');
ylabel('y');
legend('Data','mean', 'std', 'Gamma', 'Improvement');
hold off
title('Acquisition function (probability of improvement)')