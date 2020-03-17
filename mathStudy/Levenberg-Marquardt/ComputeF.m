% 加速度计标定时计算指标的函数
% Author: From CSDN
function V = ComputeF(a1,a2,a3,s1,s2,s3,b1,b2,b3,accx,accy,accz,g)

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

%加速度计测量值
ACC=[accx;accy;accz;];

%标定后的值
F=T*K*(ACC+B);

%指标
V=(sqrt(F'*F)-g).^2;

end
