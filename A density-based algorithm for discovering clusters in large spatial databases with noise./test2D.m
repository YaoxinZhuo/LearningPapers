x=[1000.*rand(10000,2)];
[class,type]=dbscan(x,4,[]);
class = class + ones(size(class));%class����+1������Ϊ0�࣬��������1��2��3
x=[x,class'];
scatter(x(:,1),x(:,2),[],class);