%随机10000个点范围10k*10k测试
% x=[10000.*rand(10000,2)];
% [class,type]=dbscan(x,4,[]);
% class = class + ones(size(class));%class分类+1，噪声为0类，其他依次1，2，3
% x=[x,class'];
% scatter(x(:,1),x(:,2),[],class);

%同学的爬虫奶粉店三项评分数据
x = xlsread('store_xls.xls');
[class,type]=dbscan(x,4,[]);
class = class + ones(size(class));%class分类+1，噪声为0类，其他依次1，2，3
x=[x,class'];
SIZE=1*size(5603,1);
scatter3(x(:,1),x(:,2),x(:,3),S,class);