% 加速度计标定程序
% Author: From CSDN
clear;
close all;

load('accData');
ax = AccData(:,1);
ay = AccData(:,2);
az = AccData(:,3);

%迭代次数
N=100;

%传感器数据个数
acqSize=2000;

%分配空间
Acc =zeros(3,acqSize);
sum0=zeros(1,acqSize);

a1=zeros(1,N);
a2=zeros(1,N);
a3=zeros(1,N);

s1=zeros(1,N);
s2=zeros(1,N);
s3=zeros(1,N);

b1=zeros(1,N);
b2=zeros(1,N);
b3=zeros(1,N);

%赋值
for j=1:acqSize
    Acc(1,j)=ax(j);
    Acc(2,j)=ay(j);
    Acc(3,j)=az(j);
end

%由于安装导致的欧拉角误差
a1(1)=0;
a2(1)=0;
a3(1)=0;

%各轴的尺度因子
s1(1)=1;
s2(1)=1;
s3(1)=1;

%各轴的测量偏移
b1(1)=0;
b2(1)=0;
b3(1)=0;

%重力加速度的值
g=9.8;

%迭代终止条件
minvalue=0.5;

%未标定前的传感器性能指标
for n=1:acqSize  
    sum0(n)=ComputeF(a1(1),a2(1),a3(1),s1(1),s2(1),s3(1),b1(1),b2(1),b3(1),Acc(1,n),Acc(2,n),Acc(3,n),g);
end

%设定一个数组用来存储最优的lamda
Lam=zeros(2,1);

%使用LM算法来求解最小二乘优化问题
%惩罚因子
lamda=1000;

%用于存储使用上一次的X值计算得到的指标
Fk =zeros(acqSize,1);

%用于存储使用本次的X值计算得到的指标
Fk1=zeros(acqSize,1);
for i=2:N
    %使用上一次的X值计算得到的指标
    value_latest=0;
    value_new=0;
    for j=1:acqSize
        Fk(j)=ComputeF(a1(i-1),a2(i-1),a3(i-1),s1(i-1),s2(i-1),s3(i-1),b1(i-1),b2(i-1),b3(i-1),Acc(1,j),Acc(2,j),Acc(3,j),g);
        value_latest=value_latest+Fk(j);
    end
    
    %优化X的取值，Levenberg-Marquardt算法
    %计算雅可比矩阵
    Jac=ComputeJacobi(a1(i-1),a2(i-1),a3(i-1),s1(i-1),s2(i-1),s3(i-1),b1(i-1),b2(i-1),b3(i-1),Acc,g,acqSize);

    %状态更新
    D=[1;1;1;1;1;1;1;1;1;];
    X=[a1(i-1);a2(i-1);a3(i-1);s1(i-1);s2(i-1);s3(i-1);b1(i-1);b2(i-1);b3(i-1);];
    X=X-((Jac'*Jac+lamda*diag(D))^-1)*Jac'*Fk;
    
    a1(i)=X(1);
    a2(i)=X(2);
    a3(i)=X(3);
    s1(i)=X(4);
    s2(i)=X(5);
    s3(i)=X(6);
    b1(i)=X(7);
    b2(i)=X(8);
    b3(i)=X(9);
    
    %判断优化后的指标是否减小
    for k=1:acqSize
        Fk1(k)=ComputeF(a1(i),a2(i),a3(i),s1(i),s2(i),s3(i),b1(i),b2(i),b3(i),Acc(1,k),Acc(2,k),Acc(3,k),g);
        value_new=value_new+Fk1(k);
    end

    if value_new<=value_latest
        lamda=lamda*0.9;
    else
        lamda=lamda*1.1;
    end
    
end

%绘出标定前后的指标
value_wb=zeros(1,acqSize);
value_yb=zeros(1,acqSize);
for h=1:acqSize
        temp1=ComputeF(a1(1),a2(1),a3(1),s1(1),s2(1),s3(1),b1(1),b2(1),b3(1),Acc(1,h),Acc(2,h),Acc(3,h),g);
        temp2=ComputeF(a1(N),a2(N),a3(N),s1(N),s2(N),s3(N),b1(N),b2(N),b3(N),Acc(1,h),Acc(2,h),Acc(3,h),g);
        value_wb(h)=temp1;
        value_yb(h)=temp2;
end

plot(value_wb,'r')
hold on
plot(value_yb,'b')
grid on

T1=norm(a1(N));
T2=norm(a2(N));
T3=norm(a3(N));

S1=norm(s1(N));
S2=norm(s2(N));
S3=norm(s3(N));

B1=norm(b1(N));
B2=norm(b2(N));
B3=norm(b3(N));

T1
T2
T3

S1
S2
S3

B1
B2
B3