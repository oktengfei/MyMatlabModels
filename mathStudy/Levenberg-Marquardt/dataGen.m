%% Levenberg_Marquardt ���ٶȲ���ģ������
% Author:   oktengfei
% date:     2020/03/17

%% 
clc; clear;
close all;

g=9.8;                  % ��������
acqSize=2000;           % ���������ݸ���
rotateV = [10 10 0];      % ģ����תʸ��

sacc = zeros(acqSize,3); 	% ��׼ʸ��
sg = zeros(acqSize,4);  	% ��ת�����Ԫ�����
rvt = zeros(acqSize,3);  	% Χ����ת��ʸ��


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
   
   % ��תʸ�����ӻ���ʾ
   rvt(i,1) = rotateV(1) * i / acqSize;
   rvt(i,2) = rotateV(2) * i / acqSize;
   rvt(i,3) = rotateV(3) * i / acqSize;
end
figure(1);
plot3(sacc(:,1),sacc(:,2),sacc(:,3));
grid on;
hold on;
plot3(rvt(:,1),rvt(:,2),rvt(:,3));  % ������תʸ��

%% ��������ʸ�� 
% ģ�����
a1 = 0.36;
a2 = 0.1;
a3 = -0.2;
s1 = 0.98;
s2 = 0.96;
s3 = 1.02;
b1 = 0.2;
b2 = 0.12;
b3 = -0.1;

% a1 = 0;
% a2 = 0;
% a3 = 0;
% s1 = 0.7;
% s2 = 1.2;
% s3 = 0.9;
% b1 = 0;
% b2 = 0;
% b3 = 0;

%��װ�����
T=[  1	 a3   -a2;
    -a3	 1    a1;
    a2	 -a1  1;];
%�߶�����
K=[s1  0  0;
    0 s2  0;
    0  0 s3;];
%����ƫ��
B=[b1;b2;b3;];

% �궨���� F=T*K*(ACC+B);
% ���� ACC = K-1*T-1*F-B
% ������ٶȼ�����ֵ
AccData = zeros(acqSize,3);
for i=1:acqSize 
    AccData(i,:) = inv(K) * inv(T) * sacc(i,:)' - B;
    
    % ����������
    AccData(i,1) = AccData(i,1) + normrnd(0,0.1,[1 1]);
    AccData(i,2) = AccData(i,2) + normrnd(0,0.1,[1 1]);
    AccData(i,3) = AccData(i,3) + normrnd(0,0.1,[1 1]);
end

% ��ͼ��ʾ
figure(2);
plot3(AccData(:,1),AccData(:,2),AccData(:,3));

%% ������֤
% TempAccIde = zeros(acqSize,3);
% for i=1:acqSize 
%     TempAccIde(i,:) = T * K * (AccData(i,:)' + B);
% end

%% ��������
save('accData','AccData');



