% Aim: Ŀ��
% Clustering the data with Density-Based Scan Algorithm with Noise (DBSCAN)
% �ڴ�������������¶����ݽ��л����ܶȵľ����㷨��DBSCAN��
% -------------------------------------------------------------------------
% Input: ����
% x - data set (m,n); m-objects, n-variables 
% x - ���ݼ��� (m,n)��m�Ƕ���������n��ÿһ�������Ӧ�ı���ֵ
% k - number of objects in a neighborhood of an object 
% k - һ��object�������ڵĶ���������
% (minimal number of objects considered as a cluster)
% k - һ�����󼯺Ϲ���һ����������Ҫ����С����
% Eps - neighborhood radius, if not known avoid this parameter or put []
% Eps - ����뾶��Χ�������֪�����������Ϊ��
% -------------------------------------------------------------------------
% Output: ���
% class - vector specifying assignment of the i-th object to certain
% class - ��ÿһ��������еķ��࣬����
% cluster (m,1) %cluster��m��1�е�
% type - vector specifying type of the i-th object 
% type - ÿһ����������һ�ֵ㣬1Ϊ���ĵ㣬0Ϊ��Ե�㣬-1Ϊ����㣨��������
% (core: 1, border: 0, outlier: -1)
% -------------------------------------------------------------------------
% Example of use:ʾ��
% x=[randn(30,2)*.4;randn(40,2)*.5+ones(40,1)*[4 4]];
% xΪһ����׼��̬�ֲ����������ǰ��30������30��2�������ֵ���ڡ�0.4��
% ����40������40��1����ֵΪ1�ĵ㣬Ȼ��ȫ����Ϊ4
% [class,type]=dbscan(x,5,[]); %������k˵����4ûʲô����һ�㶼��4
% ���ú�����class����cluster��ţ�type���ص����������֮һ
% -------------------------------------------------------------------------
function [class,type]=dbscan(x,k,Eps)
[m,n]=size(x);
%mΪ����������nΪÿһ�������Ӧ������ֵ
if nargin<3 || isempty(Eps)	%nargin is number of input arguments
  %nargin�������жϺ������������������Ҳ�������dbscanû������Eps
   [Eps]=epsilon(x,k);%����epsilon�����õ�Eps������뾶
end

x=[(1:m)' x];%һ��m��������ӵ������У��ȼ���x��һ�б�ţ��ڶ���x��������y
[m,n]=size(x);
type=zeros(1,m);%ÿһ�����ʼ������Ϊ0
no=1;%noΪ��ž��࣬��ʼΪ1
touched=zeros(m,1);%touched���ÿ�����Ƿ���ʹ��ˣ���ʼ0

for i=1:m	%����m����
    if touched(i)==0;	%��������û�з��ʹ�
       ob=x(i,:);	%obΪ������Ӧ������ֵ��obһ������
       D=dist(ob(2:n),x(:,2:n)); %obΪ��2�п�ʼȡ����ֵ����Ϊ��1���������
       %D����ŷ����þ������1��70�У�ÿ����һ�����������ŷ����þ���
       ind=find(D<=Eps);	%�ҵ�����i��������ڵĵ�
        %ŷ����þ���Ĭ�ϰ������������Լ��ľ��룬���Ա���1����������
       if length(ind)>1 && length(ind)<k+1       
           %��������������1����С�ڵ���k����ȷ��������
          type(i)=0;
          class(i)=0;
       end
       if length(ind)==1	
           %�������1������ֻ�����Լ�������������
          type(i)=-1;
          class(i)=-1;  
          touched(i)=1;
       end

       if length(ind)>=k+1; 	
           %���ڵ���k+1����
          type(i)=1;		%ȷ����Ϊ����1�ĺ��ĵ�
          class(ind)=ones(length(ind),1)*max(no);
          %��i����������ڵĵ�ȫ�����Ϊ��no��������
          while ~isempty(ind)	%��seeds���ϣ�ind�����յ�ʱ��
                ob=x(ind(1),:);	%ȡ��1��������ж�
                touched(ind(1))=1;	%��Ƿ��ʹ�
                ind(1)=[];	%�����ȡ����
                D=dist(ob(2:n),x(:,2:n));	%������������
                i1=find(D<=Eps);	%i1Ϊ�����������ڵĵ�
     
                if length(i1)>1		
                   class(i1)=no;	%����1��������������
                   if length(i1)>=k+1;%���ڵ���k+1Ҳ�Ǹ����ĵ�
                      type(ob(1))=1;
                   else			%����ֻ�Ǵ���1�Ļ����Ǳ�Ե��
                      type(ob(1))=0;
                   end

                   for i=1:length(i1)	%���������Eps�����ڵ�ÿһ����
                       if touched(i1(i))==0 %û�з��ʹ��Ļ�
                          touched(i1(i))=1; %���Ϊ���ʹ�
                          ind=[ind i1(i)];  %���뵽i���seeds��ind����ĩβ
                          class(i1(i))=no;	%���뵽��ǰ��Ⱥ��ȥ
                       end                    
                   end
                end
          end
          no=no+1; 	%�����Ⱥ��������չ�ˣ����+1����һ����Ⱥ׼��
       end
   end
end

i1=find(class==0);	%������ɺ󣬻����е�û�й���
class(i1)=-1;   %��Щ�㶼������
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