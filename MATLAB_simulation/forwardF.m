function [xc,yc,u2,u3,omega,alpha]=five(u1,u4,omega1,omega4,l1,l2,l3,l4,l5,alpha1,alpha4)
% 位置分析
xb = l1*cos(u1);
yb = l1*sin(u1);
xd = l5 + l4*cos(u4);
yd = l4*sin(u4);
lbd = sqrt((xd-xb).^2 + (yd-yb).^2);
A0 = 2*l2*(xd-xb);
B0 = 2*l2*(yd-yb);
C0 = l2.^2 + lbd.^2 - l3.^2;
u2 = 2*atan((B0 + sqrt(A0.^2 + B0.^2 - C0.^2))/(A0 + C0));  
xc = xb + l2*cos(u2);
yc = yb + l2*sin(u2);
u3 = atan((yc-yd)/(xc-xd))+pi;




%速度分析
A = [l2*sin(u2),-l3*sin(u3);
    l2*cos(u2),-l3*cos(u3)];

B = [-l1*omega1*sin(u1) + l4*omega4*sin(u4);-l1*omega1*cos(u1) + l4*omega4*cos(u4)];

omega = A\B;
omega2 = omega(1);
omega3 = omega(2);

%加速度分析
Aa = [l2*sin(u2),-l3*sin(u3);
    l2*cos(u2),-l3*cos(u3)];

Ba = [l3*cos(u3)*omega3.^2-l2*cos(u2)*omega2.^2+l4*cos(u4)*omega4.^2+l4*sin(u4)*alpha4-l1*cos(u1)*omega1.^2-l1*sin(u1)*alpha1;-l3*sin(u3)*omega3.^2+l2*sin(u2)*omega2.^2-l4*sin(u4)*omega4.^2+l4*cos(u4)*alpha4+l1*sin(u1)*omega1.^2-l1*cos(u1)*alpha1];

alpha = Aa\Ba;
end

