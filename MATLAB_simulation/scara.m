function scara()
%% 搭框架
Fig = figure('Position',[600,200,1000,750],'menu','none',...
    'Color','white','NumberTitle','off','Name','SCARA');

% 回调
set(Fig,'WindowButtonDownFcn',@ButtonDown);
set(Fig,'WindowButtonUpFcn',@ButtonUp);
set(Fig,'WindowButtonMotionFcn',@ButtonMotion);
set(Fig,'WindowScrollWheelFcn',@ScrollWheel);

% 面板
Pnl1 = uipanel(Fig,'Position',[0.05,0.05,0.7,0.9]);
Pnl2 = uipanel(Fig,'Position',[0.75,0.05,0.2,0.9]);

% 绘图窗
Axes = axes(Pnl1,'Position',[0.1,0.1,0.8,0.8]);
axis([-1,1,-1,1]),grid on,hold on

% 记录鼠标位置
p1 = [];
p2 = [];

function ButtonDown(~,~)
    cp = get(gca,'currentpoint');
    p1 = [cp(1,1),cp(1,2)];
    tmp = plot(p1(1),p1(2),'r.','Parent',Axes);
 end
end