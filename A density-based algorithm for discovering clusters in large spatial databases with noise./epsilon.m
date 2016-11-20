% Function: [Eps]=epsilon(x,k)
% Aim: 分析方式以得到DBSCAN算法的领域半径
% Analytical way of estimating neighborhood radius for DBSCAN 
% Input: 输入
% x - data matrix (m,n); m-objects, n-variables
% x - 数据矩阵，m个对象，n个每个对象的变量值
% k - number of objects in a neighborhood of an object
% k - 一个对象的领域半径内对象数量，为最小的cluster需要数量
% (minimal number of objects considered as a cluster)
function [Eps]=epsilon(x,k)
[m,n]=size(x);
%这里的Eps并不是按照论文中的人工手动选取，另外一种合理的方法
Eps=( (prod( max(x)-min(x))*k*gamma(.5*n+1)) / (m * sqrt(pi.^n) ) ).^(1/n);	
% prod函数将矩阵的每一列进行内相乘 max对应求x每一列最大值,min则是最小值
% gamma(n) = (n-1)! 
% gamma还有一个关系
% gamma(1/2) = pi.^(1/2)
% gamma(3/2) = 1/2*(pi.^(1/2))
% gamma(5/2) = 3/4*(pi.^(1/2))
% 这个函数没有看懂，网上找的一个说法,来自
% http://www.letiantian.me/2014-03-14-dbscan-2/
% Eps.^n * s qrt(pi.^n)  / gamma(.5*n+1) * (m / k)= prod(max(x)-min(x)) 
% Eps代表邻域半径，n是数据的维度，m是数据点的个数，
% k是核心对象的邻域内至少应具有的数据点数。
% 在二维空间中，n=2，
% 公式左边Eps.^n sqrt(pi.^n) / gamma(.5n+1)代表半径为Eps的圆的面积；
% 假定所有核心对象的邻域互相没有交集，m/k则是各个核心对象的个数，也是
% 最终的不想交的由邻域构成的圆的个数。
% 公式右边则代表着这样一个矩形的面积：
% 矩形的各个边平行于横坐标轴或者纵坐标轴，
% 切这个矩形是能涵盖所有数据点的最小矩形。
% 由此可见公式1的合理性。同理，n的值更大时，也有相同的结论。
% 所以，epsilon函数求得的邻域半径是合理的。