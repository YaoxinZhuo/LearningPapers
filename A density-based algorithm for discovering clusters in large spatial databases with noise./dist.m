% function: [D]=dist(i,x)
% Aim: 计算第i个点和其余点的欧几里距离
% Calculates the Euclidean distances between the i-th object and all objects in x	?????i?object??????objects??????? 	    
% Input: 
% i - an object (1,n)
% i - 第i个对象坐标矩阵
% x - data matrix (m,n); m-objects, n-variables	
% x - 点集
% Output: 输出m行一列的每一个点和其他点的欧几里得距离
% D - Euclidean distance (m,1)
function [D]=dist(i,x)
[m,n]=size(x);
if n==1
   %如果一维/线上，的点集，则距离计算就是相减，然后取绝对值即可
   D=abs((ones(m,1)*i-x))';
end
    D=sqrt(sum((((ones(m,1)*i)-x).^2)'));
% ((ones(m,1)*i)-x).^2)把m行n列全变成第i个点的坐标值，然后和原始所有点的x
% 坐标值相减，然后每一个都平方，对每一个i点和其他点的坐标差求平方后求和，
% 然后开根号，就是欧几里得距离了，然后旋转矩阵成
end