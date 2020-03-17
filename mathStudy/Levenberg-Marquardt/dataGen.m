%% Levenberg_Marquardt 加速度测试模拟数据
% Author:   oktengfei
% date:     2020/03/17

%% 
clc; clear;
close all;

g=9.8;                  % 重力常数
acqSize=2000;           % 传感器数据个数
rotateV = [10 10 0];      % 模拟旋转矢量

sacc = zeros(acqSize,3); 	% 标准矢量
sg = zeros(acqSize,4);  	% 旋转后的四元数结果
rvt = zeros(acqSize,3);  	% 围绕旋转的矢量


%%  生成标准矢量
g0 = [0 0 g];   % 初始重力矢量
qg0 = [0 g0];   % 重力矢量构造成纯四元数
rotateVP = rotateV/norm(rotateV);   % 矢量单位化

angle = 0;      % 围绕矢量rotateV旋转的角度
for i=1:acqSize
   angle = i / acqSize * pi * 2;
   rotateq = [cos(angle/2) sin(angle/2)*rotateVP(1) sin(angle/2)*rotateVP(2) sin(angle/2)*rotateVP(3)]; % 构建四元数
   sg(i,:) = quatmultiply(rotateq,qg0);
   sg(i,:) = quatmultiply(sg(i,:),quatinv(rotateq));    % 旋转 V = q*v*q-1
   sacc(i,1) = sg(i,2);
   sacc(i,2) = sg(i,3);
   sacc(i,3) = sg(i,4);
   
   % 旋转矢量可视化显示
   rvt(i,1) = rotateV(1) * i / acqSize;
   rvt(i,2) = rotateV(2) * i / acqSize;
   rvt(i,3) = rotateV(3) * i / acqSize;
end
figure(1);
plot3(sacc(:,1),sacc(:,2),sacc(:,3));
grid on;
hold on;
plot3(rvt(:,1),rvt(:,2),rvt(:,3));  % 绘制旋转矢量

%% 计算样本矢量 
% 模拟参数
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

%安装误差阵
T=[  1	 a3   -a2;
    -a3	 1    a1;
    a2	 -a1  1;];
%尺度因子
K=[s1  0  0;
    0 s2  0;
    0  0 s3;];
%三轴偏移
B=[b1;b2;b3;];

% 标定过程 F=T*K*(ACC+B);
% 所以 ACC = K-1*T-1*F-B
% 计算加速度计整定值
AccData = zeros(acqSize,3);
for i=1:acqSize 
    AccData(i,:) = inv(K) * inv(T) * sacc(i,:)' - B;
    
    % 添加随机噪声
    AccData(i,1) = AccData(i,1) + normrnd(0,0.1,[1 1]);
    AccData(i,2) = AccData(i,2) + normrnd(0,0.1,[1 1]);
    AccData(i,3) = AccData(i,3) + normrnd(0,0.1,[1 1]);
end

% 绘图显示
figure(2);
plot3(AccData(:,1),AccData(:,2),AccData(:,3));

%% 数据验证
% TempAccIde = zeros(acqSize,3);
% for i=1:acqSize 
%     TempAccIde(i,:) = T * K * (AccData(i,:)' + B);
% end

%% 保存数据
save('accData','AccData');



