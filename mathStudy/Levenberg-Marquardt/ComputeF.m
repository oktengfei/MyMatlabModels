% ���ٶȼƱ궨ʱ����ָ��ĺ���
% Author: From CSDN
function V = ComputeF(a1,a2,a3,s1,s2,s3,b1,b2,b3,accx,accy,accz,g)

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

%���ٶȼƲ���ֵ
ACC=[accx;accy;accz;];

%�궨���ֵ
F=T*K*(ACC+B);

%ָ��
V=(sqrt(F'*F)-g).^2;

end
