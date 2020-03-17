% 加速度计标定时计算雅克比矩阵的函数
% Author: From CSDN
function J = ComputeJacobi( a1,a2,a3,s1,s2,s3,b1,b2,b3,acc,g,num)
%函数用于计算雅可比矩阵

%赋值
phi  =a1;
theta=a2;
psi  =a3;

sx=s1;
sy=s2;
sz=s3;

bx=b1;
by=b2;
bz=b3;

amx=acc(1,:);
amy=acc(2,:);
amz=acc(3,:);

J=zeros(num,9);

for k=1:num

    Fx=sqrt((sx*(amx(k)+bx)+psi*sy*(amy(k)+by)-theta*sz*(amz(k)+bz))^2 ...
       +(-psi*sx*(amx(k)+bx)+sy*(amy(k)+by)+phi*sz*(amz(k)+bz))^2 ...
       +(theta*sx*(amx(k)+bx)-phi*sy*(amy(k)+by)+sz*(amz(k)+bz))^2 )...
       -g;

    J(k,1)=( (-psi*sx*(amx(k)+bx)+sy*(amy(k)+by)+phi*sz*(amz(k)+bz))*sz*(amz(k)+bz) ...
              -(theta*sx*(amx(k)+bx)-phi*sy*(amy(k)+by)+sz*(amz(k)+bz))*sy*(amy(k)+by)  )*(Fx/(Fx+g));
          
    J(k,2)=(-(sx*(amx(k)+bx)+psi*sy*(amy(k)+by)-theta*sz*(amz(k)+bz))*sz*(amz(k)+bz) ...
              +(theta*sx*(amx(k)+bx)-phi*sy*(amy(k)+by)+sz*(amz(k)+bz))*sx*(amx(k)+bx) )*(Fx/(Fx+g));   
          
    J(k,3)=( (sx*(amx(k)+bx)+psi*sy*(amy(k)+by)-theta*sz*(amz(k)+bz))*sy*(amy(k)+by) ...
              -(-psi*sx*(amx(k)+bx)+sy*(amy(k)+by)+phi*sz*(amz(k)+bz))*sx*(amx(k)+bx) )*(Fx/(Fx+g)); 
          
    J(k,4)=( (sx*(amx(k)+bx)+psi*sy*(amy(k)+by)-theta*sz*(amz(k)+bz))*(amx(k)+bx) ...
              -(-psi*sx*(amx(k)+bx)+sy*(amy(k)+by)+phi*sz*(amz(k)+bz))*psi*(amx(k)+bx) ...
              +(theta*sx*(amx(k)+bx)-phi*sy*(amy(k)+by)+sz*(amz(k)+bz))*theta*(amx(k)+bx) )*(Fx/(Fx+g));     
         
    J(k,5)=( (sx*(amx(k)+bx)+psi*sy*(amy(k)+by)-theta*sz*(amz(k)+bz))*psi*(amy(k)+by) ...
              +(-psi*sx*(amx(k)+bx)+sy*(amy(k)+by)+phi*sz*(amz(k)+bz))*(amy(k)+by) ...
              -(theta*sx*(amx(k)+bx)-phi*sy*(amy(k)+by)+sz*(amz(k)+bz))*phi*(amy(k)+by) )*(Fx/(Fx+g));          
          
    J(k,6)=(-(sx*(amx(k)+bx)+psi*sy*(amy(k)+by)-theta*sz*(amz(k)+bz))*theta*(amz(k)+bz) ...
              +(-psi*sx*(amx(k)+bx)+sy*(amy(k)+by)+phi*sz*(amz(k)+bz))*phi*(amz(k)+bz) ...
              +(theta*sx*(amx(k)+bx)-phi*sy*(amy(k)+by)+sz*(amz(k)+bz))*(amz(k)+bz) )*(Fx/(Fx+g)); 
     
    J(k,7)=( (sx*(amx(k)+bx)+psi*sy*(amy(k)+by)-theta*sz*(amz(k)+bz))*sx ...
              -(-psi*sx*(amx(k)+bx)+sy*(amy(k)+by)+phi*sz*(amz(k)+bz))*psi*sx ...
              +(theta*sx*(amx(k)+bx)-phi*sy*(amy(k)+by)+sz*(amz(k)+bz))*theta*sx )*(Fx/(Fx+g));      
          
    J(k,8)=( (sx*(amx(k)+bx)+psi*sy*(amy(k)+by)-theta*sz*(amz(k)+bz))*psi*sy ...
              +(-psi*sx*(amx(k)+bx)+sy*(amy(k)+by)+phi*sz*(amz(k)+bz))*sy ...
              -(theta*sx*(amx(k)+bx)-phi*sy*(amy(k)+by)+sz*(amz(k)+bz))*phi*sy )*(Fx/(Fx+g));    
          
    J(k,9)=(-(sx*(amx(k)+bx)+psi*sy*(amy(k)+by)-theta*sz*(amz(k)+bz))*theta*sz ...
              +(-psi*sx*(amx(k)+bx)+sy*(amy(k)+by)+phi*sz*(amz(k)+bz))*phi*sz ...
              -(theta*sx*(amx(k)+bx)-phi*sy*(amy(k)+by)+sz*(amz(k)+bz))*sz )*(Fx/(Fx+g)); %Fx^(-0.5)
    
end

end