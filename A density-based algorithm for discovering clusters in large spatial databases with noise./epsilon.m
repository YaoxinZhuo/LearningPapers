% Function: [Eps]=epsilon(x,k)
% Aim: ������ʽ�Եõ�DBSCAN�㷨������뾶
% Analytical way of estimating neighborhood radius for DBSCAN 
% Input: ����
% x - data matrix (m,n); m-objects, n-variables
% x - ���ݾ���m������n��ÿ������ı���ֵ
% k - number of objects in a neighborhood of an object
% k - һ�����������뾶�ڶ���������Ϊ��С��cluster��Ҫ����
% (minimal number of objects considered as a cluster)
function [Eps]=epsilon(x,k)
[m,n]=size(x);
%�����Eps�����ǰ��������е��˹��ֶ�ѡȡ������һ�ֺ���ķ���
Eps=( (prod( max(x)-min(x))*k*gamma(.5*n+1)) / (m * sqrt(pi.^n) ) ).^(1/n);	
% prod�����������ÿһ�н�������� max��Ӧ��xÿһ�����ֵ,min������Сֵ
% gamma(n) = (n-1)! 
% gamma����һ����ϵ
% gamma(1/2) = pi.^(1/2)
% gamma(3/2) = 1/2*(pi.^(1/2))
% gamma(5/2) = 3/4*(pi.^(1/2))
% �������û�п����������ҵ�һ��˵��,����
% http://www.letiantian.me/2014-03-14-dbscan-2/
% Eps.^n * s qrt(pi.^n)  / gamma(.5*n+1) * (m / k)= prod(max(x)-min(x)) 
% Eps��������뾶��n�����ݵ�ά�ȣ�m�����ݵ�ĸ�����
% k�Ǻ��Ķ��������������Ӧ���е����ݵ�����
% �ڶ�ά�ռ��У�n=2��
% ��ʽ���Eps.^n sqrt(pi.^n) / gamma(.5n+1)����뾶ΪEps��Բ�������
% �ٶ����к��Ķ����������û�н�����m/k���Ǹ������Ķ���ĸ�����Ҳ��
% ���յĲ��뽻�������򹹳ɵ�Բ�ĸ�����
% ��ʽ�ұ������������һ�����ε������
% ���εĸ�����ƽ���ں�����������������ᣬ
% ������������ܺ����������ݵ����С���Ρ�
% �ɴ˿ɼ���ʽ1�ĺ����ԡ�ͬ��n��ֵ����ʱ��Ҳ����ͬ�Ľ��ۡ�
% ���ԣ�epsilon������õ�����뾶�Ǻ���ġ�