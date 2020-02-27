clc; clear; close all;
%% DH转换矩阵推导
% author:   oktengfei
% data:     2020/2/25

%%
% 关节变量 a, d, alhpa, theta
a = sym('a'); 
d = sym('d');
alpha = sym('alpha');
theta = sym('theta')

% 定义DH坐标系移动的几个步骤
% 绕Z轴旋转theta
Rz = [cos(theta) -sin(theta) 0 0; sin(theta) cos(theta) 0 0; 0 0 1 0; 0 0 0 1];
% 沿Z轴平移距离d
Mz = [1 0 0 0; 0 1 0 0; 0 0 1 d; 0 0 0 1];
% 沿x轴平移距离a
Mx = [1 0 0 a; 0 1 0 0; 0 0 1 0; 0 0 0 1];
% 绕x轴旋转alpha
Rx = [1 0 0 0; 0 cos(alpha) -sin(alpha) 0; 0 sin(alpha) cos(alpha) 0; 0 0 0 1];

%% 标准版DH参数定义
% 1. 绕Z轴旋转theta, 使Xi-1与X轴平行
% 2. 沿Z轴平移距离d，使Xi-1与X轴共线
% 3. 沿x轴平移距离a，使坐标原点重合
% 4. 绕x轴旋转alpha, 使坐标系完全重合
% 由坐标系n-1到坐标系n, dh参数下标全为n
Ts = Rz*Mz*Mx*Rx

%% Craig版DH参数定义
% 1. 绕x轴旋转alpha, 使Z轴平行
% 2. 沿x轴平移距离a，使Z轴共线
% 3. 绕Z轴旋转theta, 使Xi-1与X轴平行
% 4. 沿Z轴平移距离d，使Xi-1与X轴共线
% 由坐标系n-1到坐标系n, dh参数a和alpha下标为n-1，theta和d下标为n
Tc = Rx*Mx*Rz*Mz
