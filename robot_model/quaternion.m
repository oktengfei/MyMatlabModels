clc; clear; close all;
%% 
% 四元数运算及原理学习
% author:   oktengfei
% date:     2020/02/27

%% 基本运算
p = [1,2,3,4];  % 定义一个四元数
quatmod(p);          % 计算四元数的 模
quatnorm(p);         % 计算四元数的 范数
quatnormalize(p);    % 四元数单位化
quatinv(p);          % 计算四元数的 逆
quatconj(p);         % 计算共轭四元数
%quatrotate(p)
quat2dcm(p);         % 四元数转旋转矩阵
[X,Y,Z] = quat2angle(p,'ZXY');   % 四元数转欧拉角，第二个参数为对应的转序

q = [2,6,4,9];  % 再定义一个四元数
quatmultiply(p,q);   % 四元数乘法
quatdivide(q,p);     % 四元数除法

%%