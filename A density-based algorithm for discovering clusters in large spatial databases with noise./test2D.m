%���10000���㷶Χ10k*10k����
% x=[10000.*rand(10000,2)];
% [class,type]=dbscan(x,4,[]);
% class = class + ones(size(class));%class����+1������Ϊ0�࣬��������1��2��3
% x=[x,class'];
% scatter(x(:,1),x(:,2),[],class);

%ͬѧ�������̷۵�������������
x = xlsread('store_xls.xls');
[class,type]=dbscan(x,4,[]);
class = class + ones(size(class));%class����+1������Ϊ0�࣬��������1��2��3
x=[x,class'];
SIZE=1*size(5603,1);
scatter3(x(:,1),x(:,2),x(:,3),S,class);