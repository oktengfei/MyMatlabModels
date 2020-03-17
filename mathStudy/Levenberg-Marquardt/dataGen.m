%% Levenberg_Marquardt ���ٶȲ���ģ������
% Author:   oktengfei
% date:     2020/03/17

%% 
clc; clear;
close all;

g=9.8;                  % ��������
acqSize=2000;           % ���������ݸ���
rotateV = [3 3 1];      % ģ����תʸ��

sacc = zeros(acqSize,3);    % ��׼ʸ��
sg = zeros(acqSize,4);     % ��ת�����Ԫ�����

%%  ���ɱ�׼ʸ��
g0 = [0 0 g];   % ��ʼ����ʸ��
qg0 = [0 g0];   % ����ʸ������ɴ���Ԫ��
rotateVP = rotateV/norm(rotateV);   % ʸ����λ��

angle = 0;      % Χ��ʸ��rotateV��ת�ĽǶ�
for i=1:acqSize
   angle = i / acqSize * pi * 2;
   rotateq = [cos(angle/2) sin(angle/2)*rotateVP(1) sin(angle/2)*rotateVP(2) sin(angle/2)*rotateVP(3)]; % ������Ԫ��
   sg(i,:) = quatmultiply(rotateq,qg0);
   sg(i,:) = quatmultiply(sg(i,:),quatinv(rotateq));    % ��ת V = q*v*q-1
   sacc(i,1) = sg(i,2);
   sacc(i,2) = sg(i,3);
   sacc(i,3) = sg(i,4);
end
% figure(1);
% plot3(sacc(:,1),sacc(:,2),sacc(:,3));
% grid on;

%%




