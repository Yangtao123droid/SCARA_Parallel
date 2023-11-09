clc
clear
close all
L0=50;L1=50;L2=50;L3=50;L4=50;
x1=8;
y1=0;
x2=0;
y2=0;
x5=L0;
y5=0;

k=0;
d1=120*pi/180;  %弧度
d2=120*pi/180;%两者正方向似乎相反

    for i=1:1:60
%     x2=L1*cos(d1+0.0175*i);
%     y2=L1*sin(d1+0.0175*i); 
    
    x2=L1*cos(d1-0.0175*i);
    y2=L1*sin(d1-0.0175*i);
    
%     x4=L0-L4*cos(d2-0.0175*i);
%     y4=L4*sin(d2-0.0175*i);%角度变化与前者相反，或是没有设置正方向

    x4=L0-L4*cos(d2+0.0175*i);
    y4=L4*sin(d2+0.0175*i);%角度与前者相反，或是没有设置正方向
    
    L42=sqrt((x4-x2)^2+(y4-y2)^2);
    d11=acos((L42^2+L2^2-L3^2)/(2*L2*L42));  %d1上方角度,少了个括号
    %d11=Td11*pi/180;%转成弧度制
    x3=L2*cos(d11)+x2;
    y3=L2*sin(d11)+y2;
    
    
    x=[0,x2,x3,x4,x5];
    y=[0,y2,y3,y4,y5];
    plot(x,y,'r*');
    line(x,y)
    axis equal 
    pause(0.1)
    plot(x,y,'g*');
    line(x,y,'Color','white')
    axis equal 
%   line(x,y,'Color','w','LineStyle','--')
    hold on
    end