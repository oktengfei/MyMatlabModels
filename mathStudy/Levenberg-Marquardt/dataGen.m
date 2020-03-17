%% Levenberg_Marquardt 加速度测试模拟数据
% Author:   oktengfei
% date:     2020/03/17

%% 
clc; clear;
close all;

g=9.8;                  % 重力常数
acqSize=2000;           % 传感器数据个数
rotateV = [3 3 1];      % 模拟旋转矢量

sacc = zeros(acqSize,3);    % 标准矢量
sg = zeros(acqSize,4);     % 旋转后的四元数结果

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
end
% figure(1);
% plot3(sacc(:,1),sacc(:,2),sacc(:,3));
% grid on;

%%




