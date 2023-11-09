function [thta1,thta2] = inverseF(x,y,l1,l2,l3,l4,l5)
Xc = x; %Xc∈（35,80）
Yc = y; %Yc∈（75,115）
cosfoai_12 = (Xc.^2 + Yc.^2 - l1.^2 - l2.^2)/(2 * l1 * l2);
%foai_12∈（pi，2pi）
foai_12 = 2*pi - acos(cosfoai_12);
cosfoai_01 = (l2*Yc*sin(foai_12)+Xc*(l2*cos(foai_12)+l1))/((l2*cos(foai_12)+l1).^2+l2.^2*(sin(foai_12)).^2);
%foai_01∈（20,180）
foai_01 = acos(cosfoai_01);
cosfoai_34 = ((Xc-l5).^2+Yc.^2-l3.^2-l4.^2)/(2*l3*l4);
%foai_34∈（pi,2pi）
foai_34 = 2*pi - acos(cosfoai_34);
A = l5 - Xc;
B = l3 * sin(foai_34);
C = l4 + l3*cos(foai_34);
%foai_t = asin(C/sqrt(B.^2+C.^2));
foai_t = acos(B/sqrt(B.^2+C.^2));
%foai_40∈（0,pi）
foai_40 = foai_t - asin(A/sqrt(B.^2+C.^2));
thta1 = foai_01/pi*180;
thta2 = 180 - foai_40/pi*180;
thta1 = thta1/180*pi;
thta2 = thta2/180*pi;
end