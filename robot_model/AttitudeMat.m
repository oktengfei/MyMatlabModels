%% 姿态转换矩阵推导
% author:   oktengfei
% data:     2020/3/14

% T 表示A到B坐标系的旋转，则B系下点P的坐标为PB，
yaw = sym('yaw');       % 偏航     
pitch = sym('pitch');   % 俯仰
roll = sym('roll');     % 横滚

% 绕x轴旋转alpha角度的旋转矩阵
% alpha = sym('alpha');
alpha = sym('phi');       
Rx = [1 0 0; 0 cos(alpha) -sin(alpha); 0 sin(alpha) cos(alpha)];

% 绕y轴旋转Beta角度的旋转矩阵
% beta = sym('beta');
beta = sym('theta');
Ry = [cos(beta) 0 sin(beta); 0 1 0; -sin(beta) 0 cos(beta)];

% 绕y轴旋转Beta角度的旋转矩阵
% gama = sym('gama');
gama = sym('psi');
Rz = [cos(gama) -sin(gama) 0; sin(gama) cos(gama) 0; 0 0 1];

%% 测试
T = Rx*Ry*Rz






