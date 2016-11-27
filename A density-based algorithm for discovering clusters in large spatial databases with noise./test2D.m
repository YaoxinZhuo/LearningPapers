% %随机10000个点范围10k*10k测试
% x=[10000.*rand(10000,2)];

% % t4.8k.txt的点数据，来自于网站： http://cs.uef.fi/sipu/datasets/t4.8k.txt
% x=load('t4.8k.txt');

% % 第二篇论文Demo中demoData
% load('demoData.mat');
% x=X;

% load('fig2_panelC.dat');
% x=fig2_panelC;

% load('fig2_panelB.dat');
% x=fig2_panelB;



[class,type]=dbscan(x,4,[]);
class = class + ones(size(class));%class分类+1，噪声为0类，其他cluster依次1，2，3
x=[x,class'];
scatter(x(:,1),x(:,2),[],class);

% %同学的爬虫奶粉店三项评分数据
% x = xlsread('store_xls.xls');
% [class,type]=dbscan(x,4,[]);
% class = class + ones(size(class));%class分类+1，噪声为0类，其他cluster依次1，2，3
% x=[x,class'];
% SIZE=1*size(class,1);
% scatter3(x(:,1),x(:,2),x(:,3),SIZE,class);

