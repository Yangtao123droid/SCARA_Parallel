%1  输入已知数据
clc
clear 
close all

% 四个杆子的长度
l1=250;    
l2=300;
l3=300;
l4=250;
l5=250;

% 两个电机之间的距离
l5=250;
hd=pi/180;

% 末端目标位置
x=125;
y=382.338;

% 两个电机角速度以及角加速度
omega1=500;
omega4=500;
alpha1=0;
alpha4=0;

[u1,u4]=inverseF(x,y,l1,l2,l3,l4,l5)


[xc,yc,u2,u3,omega,alpha]=forwardF(u1,u4,omega1,omega4,l1,l2,l3,l4,l5,alpha1,alpha4)

theta2(1) = u2;
theta3(1) = u3;
    
omega2(1)=omega(1);
omega3(1)=omega(2);
    
alpha2(1)=alpha(1);
alpha3(1)=alpha(2);
    
xcd(1) = xc;
ycd(1) = yc;

figure(2)

x(1)=0;
y(1)=0;
x(2)=l1*cos(u1);
y(2)=l1*sin(u1);
x(3)=xcd(1);
y(3)=ycd(1);
x(4)=l4*cos(u4)+l5;
y(4)=l4*sin(u4);
x(5)=l5;
y(5)=0;
plot(x,y,'k');
grid on;
hold on;
plot(x(1),y(1),'ro');
plot(x(2),y(2),'ro');
plot(x(3),y(3),'ro');
plot(x(4),y(4),'ro');
plot(x(5),y(5),'ro');
axis([-200 600 -200 600]);
title('并联SCARA');
xlabel('mm');
ylabel('mm');
m(1)=getframe;




