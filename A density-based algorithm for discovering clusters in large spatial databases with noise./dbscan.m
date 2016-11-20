% Aim: 目标
% Clustering the data with Density-Based Scan Algorithm with Noise (DBSCAN)
% 在存在噪声的情况下对数据进行基于密度的聚类算法（DBSCAN）
% -------------------------------------------------------------------------
% Input: 输入
% x - data set (m,n); m-objects, n-variables 
% x - 数据集合 (m,n)，m是对象数量，n是每一个对象对应的变量值
% k - number of objects in a neighborhood of an object 
% k - 一个object的领域内的对象数量。
% (minimal number of objects considered as a cluster)
% k - 一个对象集合构成一个聚类所需要的最小数量
% Eps - neighborhood radius, if not known avoid this parameter or put []
% Eps - 领域半径范围，如果不知道这个参数置为空
% -------------------------------------------------------------------------
% Output: 输出
% class - vector specifying assignment of the i-th object to certain
% class - 对每一个对象进行的分类，向量
% cluster (m,1) %cluster是m行1列的
% type - vector specifying type of the i-th object 
% type - 每一个对象是哪一种点，1为核心点，0为边缘点，-1为出类点（噪声？）
% (core: 1, border: 0, outlier: -1)
% -------------------------------------------------------------------------
% Example of use:示例
% x=[randn(30,2)*.4;randn(40,2)*.5+ones(40,1)*[4 4]];
% x为一个标准正态分布的随机矩阵，前面30个点是30行2列随机数值，在×0.4倍
% 后面40个点是40行1列数值为1的点，然后全部变为4
% [class,type]=dbscan(x,5,[]); %论文里k说大于4没什么区别，一般都用4
% 调用函数，class返回cluster标号，type返回点的三种类型之一
% -------------------------------------------------------------------------
function [class,type]=dbscan(x,k,Eps)
[m,n]=size(x);
%m为对象数量，n为每一个对象对应的坐标值
if nargin<3 || isempty(Eps)	%nargin is number of input arguments
  %nargin是用来判断函数的输入参数数量，也就是如果dbscan没有输入Eps
   [Eps]=epsilon(x,k);%调用epsilon函数得到Eps，领域半径
end

x=[(1:m)' x];%一个m行数据添加到矩阵中，等价于x第一列编号，第二列x，第三列y
[m,n]=size(x);
type=zeros(1,m);%每一个点初始化类型为0
no=1;%no为标号聚类，初始为1
touched=zeros(m,1);%touched标记每个点是否访问过了，初始0

for i=1:m	%遍历m个点
    if touched(i)==0;	%如果这个点没有访问过
       ob=x(i,:);	%ob为这个点对应的坐标值，ob一行两列
       D=dist(ob(2:n),x(:,2:n)); %ob为第2列开始取坐标值，因为第1列是序号列
       %D返回欧几里得距离矩阵1行70列，每列是一个和其他点的欧几里得距离
       ind=find(D<=Eps);	%找到所有i点的领域内的点
        %欧几里得距离默认包含这个点和它自己的距离，所以必有1点在领域内
       if length(ind)>1 && length(ind)<k+1       
           %如果点的数量大于1并且小于等于k，不确定，搁置
          type(i)=0;
          class(i)=0;
       end
       if length(ind)==1	
           %如果等于1，就是只有它自己，它就是噪声
          type(i)=-1;
          class(i)=-1;  
          touched(i)=1;
       end

       if length(ind)>=k+1; 	
           %大于等于k+1个点
          type(i)=1;		%确定它为类型1的核心点
          class(ind)=ones(length(ind),1)*max(no);
          %第i个点的领域内的点全部标记为第no个聚类内
          while ~isempty(ind)	%当seeds集合（ind）不空的时候
                ob=x(ind(1),:);	%取第1个点出来判断
                touched(ind(1))=1;	%标记访问过
                ind(1)=[];	%这个点取出来
                D=dist(ob(2:n),x(:,2:n));	%对这个点算距离
                i1=find(D<=Eps);	%i1为这个点的领域内的点
     
                if length(i1)>1		
                   class(i1)=no;	%大于1标记在这个类里面
                   if length(i1)>=k+1;%大于等于k+1也是个核心点
                      type(ob(1))=1;
                   else			%否则只是大于1的话就是边缘点
                      type(ob(1))=0;
                   end

                   for i=1:length(i1)	%对于这个点Eps领域内的每一个点
                       if touched(i1(i))==0 %没有访问过的话
                          touched(i1(i))=1; %标记为访问过
                          ind=[ind i1(i)];  %加入到i点的seeds（ind）中末尾
                          class(i1(i))=no;	%加入到当前集群中去
                       end                    
                   end
                end
          end
          no=no+1; 	%这个集群不能再扩展了，标号+1，下一个集群准备
       end
   end
end

i1=find(class==0);	%遍历完成后，还是有点没有归类
class(i1)=-1;   %这些点都是噪音
type(i1)=-1;

% References:
% [1] M. Ester, H. Kriegel, J. Sander, X. Xu, A density-based algorithm for 
% discovering clusters in large spatial databases with noise, proc. 
% 2nd Int. Conf. on Knowledge Discovery and Data Mining, Portland, OR, 1996, 
% p. 226, available from: 
% www.dbs.informatik.uni-muenchen.de/cgi-bin/papers?query=--CO
% [2] M. Daszykowski, B. Walczak, D. L. Massart, Looking for 
% Natural Patterns in Data. Part 1: Density Based Approach, 
% Chemom. Intell. Lab. Syst. 56 (2001) 83-92 
% -------------------------------------------------------------------------
% Written by Michal Daszykowski
% Department of Chemometrics, Institute of Chemistry, 
% The University of Silesia
% December 2004
% http://www.chemometria.us.edu.pl