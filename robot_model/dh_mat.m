clc; clear; close all;
%% DHת�������Ƶ�
% author:   oktengfei
% data:     2020/2/25

%%
% �ؽڱ��� a, d, alhpa, theta
a = sym('a'); 
d = sym('d');
alpha = sym('alpha');
theta = sym('theta')

% ����DH����ϵ�ƶ��ļ�������
% ��Z����תtheta
Rz = [cos(theta) -sin(theta) 0 0; sin(theta) cos(theta) 0 0; 0 0 1 0; 0 0 0 1];
% ��Z��ƽ�ƾ���d
Mz = [1 0 0 0; 0 1 0 0; 0 0 1 d; 0 0 0 1];
% ��x��ƽ�ƾ���a
Mx = [1 0 0 a; 0 1 0 0; 0 0 1 0; 0 0 0 1];
% ��x����תalpha
Rx = [1 0 0 0; 0 cos(alpha) -sin(alpha) 0; 0 sin(alpha) cos(alpha) 0; 0 0 0 1];

%% ��׼��DH��������
% 1. ��Z����תtheta, ʹXi-1��X��ƽ��
% 2. ��Z��ƽ�ƾ���d��ʹXi-1��X�Ṳ��
% 3. ��x��ƽ�ƾ���a��ʹ����ԭ���غ�
% 4. ��x����תalpha, ʹ����ϵ��ȫ�غ�
% ������ϵn-1������ϵn, dh�����±�ȫΪn
Ts = Rz*Mz*Mx*Rx

%% Craig��DH��������
% 1. ��x����תalpha, ʹZ��ƽ��
% 2. ��x��ƽ�ƾ���a��ʹZ�Ṳ��
% 3. ��Z����תtheta, ʹXi-1��X��ƽ��
% 4. ��Z��ƽ�ƾ���d��ʹXi-1��X�Ṳ��
% ������ϵn-1������ϵn, dh����a��alpha�±�Ϊn-1��theta��d�±�Ϊn
Tc = Rx*Mx*Rz*Mz
