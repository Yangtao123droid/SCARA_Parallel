%逆解，实际上是给定末端坐标，已知长度，和机架复现其他杆
clc
clear
close all
L0=80;L1=50;L2=50;L3=50;L4=50;
x1=0;
y1=0;%机架左
% x3=68;
% y3=68;%末端坐标
x5=L0;
y5=0;%机架右

% k=0;
for x3=1:60
y3=sqrt(50^2-x3^2);
x=x3;
y=y3;
[thta1,thta2] = inverseF(x,y,L1,L2,L3,L4,L0);
L13=sqrt((x3-x1)^2+(y3-y1)^2);
L35=sqrt((x5-x3)^2+(y3-y5)^2);%内三角形两条边

a1=acos((L13^2+L0^2-L35^2)/(2*L13*L0));
a2=acos((L35^2+L0^2-L13^2)/(2*L35*L0));%内三角形的两个底角

b1=acos((L1^2+L13^2-L2^2)/(2*L1*L13));
b2=acos((L35^2+L4^2-L3^2)/(2*L35*L4));%两个外三角形角

c1=pi-b1-a1;
c2=pi-b2-a2;

x2=x1-L1*cos(c1);
y2=y1+L1*sin(c1);

x4=x5+L4*cos(c2);
y4=y5+L4*sin(c2);

x=[0,x2,x3,x4,x5];
y=[0,y2,y3,y4,y5];
 
plot(x,y,'r*');
axis([-100 100 -100 100])
axis equal
line(x,y)

pause(0.1)
plot(x,y,'g*');
line(x,y,'Color','white')
axis([-100 100 -100 100])
axis equal
hold on
end

    
%     for i=1:1:60
% %     x2=L1*cos(d1+0.0175*i);
% %     y2=L1*sin(d1+0.0175*i); 
%     
%     x2=L1*cos(d1-0.0175*i);
%     y2=L1*sin(d1-0.0175*i);
%     
% %     x4=L0-L4*cos(d2-0.0175*i);
% %     y4=L4*sin(d2-0.0175*i);%角度变化与前者相反，或是没有设置正方向
% 
%     x4=L0-L4*cos(d2+0.0175*i);
%     y4=L4*sin(d2+0.0175*i);%角度与前者相反，或是没有设置正方向
%     
%     L42=sqrt((x4-x2)^2+(y4-y2)^2);
%     d11=acos((L42^2+L2^2-L3^2)/(2*L2*L42));  %d1上方角度,少了个括号
%     %d11=Td11*pi/180;%转成弧度制
%     x3=L2*cos(d11)+x2;
%     y3=L2*sin(d11)+y2;
% 
%     x=[0,x2,x3,x4,x5];
%     y=[0,y2,y3,y4,y5];
%     plot(x,y,'r*');
%     line(x,y)
%     axis equal 
%     pause(0.1)
%     plot(x,y,'g*');
%     line(x,y,'Color','white')
%     axis equal 
% %   line(x,y,'Color','w','LineStyle','--')
%     hold on
%     end