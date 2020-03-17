clc; clear; close all;
%% 
% ��Ԫ�����㼰ԭ��ѧϰ
% author:   oktengfei
% date:     2020/02/27
% ���Ͽ��Խ�������Ƶ�����������Ԫ����https://eater.net/quaternions

%% ��������
p = [1,2,3,4];      % ����һ����Ԫ��
quatmod(p);          % ������Ԫ���� ģ
quatnorm(p);         % ������Ԫ���� ����
quatnormalize(p);    % ��Ԫ����λ��
quatinv(p);          % ������Ԫ���� ��
quatconj(p);         % ���㹲����Ԫ��
%quatrotate(p)
quat2dcm(p);         % ��Ԫ��ת��ת����
[X,Y,Z] = quat2angle(p,'ZXY');   % ��Ԫ��תŷ���ǣ��ڶ�������Ϊ��Ӧ��ת��

q = [2,6,4,9];  % �ٶ���һ����Ԫ��
quatmultiply(p,q);   % ��Ԫ���˷�
quatdivide(q,p);     % ��Ԫ������

%%
% ��ʼ����
F1 = [1,0,0];
h = quiver3(0,0,0,F1(1),F1(2),F1(3),'MaxHeadSize',1);


