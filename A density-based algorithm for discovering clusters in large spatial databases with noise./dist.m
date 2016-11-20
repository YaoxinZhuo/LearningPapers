% function: [D]=dist(i,x)
% Aim: �����i�����������ŷ�������
% Calculates the Euclidean distances between the i-th object and all objects in x	?????i?object??????objects??????? 	    
% Input: 
% i - an object (1,n)
% i - ��i�������������
% x - data matrix (m,n); m-objects, n-variables	
% x - �㼯
% Output: ���m��һ�е�ÿһ������������ŷ����þ���
% D - Euclidean distance (m,1)
function [D]=dist(i,x)
[m,n]=size(x);
if n==1
   %���һά/���ϣ��ĵ㼯������������������Ȼ��ȡ����ֵ����
   D=abs((ones(m,1)*i-x))';
end
    D=sqrt(sum((((ones(m,1)*i)-x).^2)'));
% ((ones(m,1)*i)-x).^2)��m��n��ȫ��ɵ�i���������ֵ��Ȼ���ԭʼ���е��x
% ����ֵ�����Ȼ��ÿһ����ƽ������ÿһ��i�����������������ƽ������ͣ�
% Ȼ�󿪸��ţ�����ŷ����þ����ˣ�Ȼ����ת�����
end