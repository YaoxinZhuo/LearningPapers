% %���10000���㷶Χ10k*10k����
% x=[10000.*rand(10000,2)];

% % t4.8k.txt�ĵ����ݣ���������վ�� http://cs.uef.fi/sipu/datasets/t4.8k.txt
% x=load('t4.8k.txt');

% % �ڶ�ƪ����Demo��demoData
% load('demoData.mat');
% x=X;

% load('fig2_panelC.dat');
% x=fig2_panelC;

% load('fig2_panelB.dat');
% x=fig2_panelB;



[class,type]=dbscan(x,4,[]);
class = class + ones(size(class));%class����+1������Ϊ0�࣬����cluster����1��2��3
x=[x,class'];
scatter(x(:,1),x(:,2),[],class);

% %ͬѧ�������̷۵�������������
% x = xlsread('store_xls.xls');
% [class,type]=dbscan(x,4,[]);
% class = class + ones(size(class));%class����+1������Ϊ0�࣬����cluster����1��2��3
% x=[x,class'];
% SIZE=1*size(class,1);
% scatter3(x(:,1),x(:,2),x(:,3),SIZE,class);

