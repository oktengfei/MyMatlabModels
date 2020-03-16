%% ��̬ת�������Ƶ�
% author:   oktengfei
% data:     2020/3/14

% T ��ʾA��B����ϵ����ת����Bϵ�µ�P������ΪPB��
yaw = sym('yaw');       % ƫ��     
pitch = sym('pitch');   % ����
roll = sym('roll');     % ���

% ��x����תalpha�Ƕȵ���ת����
% alpha = sym('alpha');
alpha = sym('phi');       
Rx = [1 0 0; 0 cos(alpha) -sin(alpha); 0 sin(alpha) cos(alpha)];

% ��y����תBeta�Ƕȵ���ת����
% beta = sym('beta');
beta = sym('theta');
Ry = [cos(beta) 0 sin(beta); 0 1 0; -sin(beta) 0 cos(beta)];

% ��y����תBeta�Ƕȵ���ת����
% gama = sym('gama');
gama = sym('psi');
Rz = [cos(gama) -sin(gama) 0; sin(gama) cos(gama) 0; 0 0 1];

%% ����
T = Rx*Ry*Rz






