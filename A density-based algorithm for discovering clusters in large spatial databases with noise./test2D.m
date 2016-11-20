x=[1000.*rand(10000,2)];
[class,type]=dbscan(x,4,[]);
class = class + ones(size(class));%class分类+1，噪声为0类，其他依次1，2，3
x=[x,class'];
scatter(x(:,1),x(:,2),[],class);