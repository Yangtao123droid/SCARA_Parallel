function GUI9()

%% 搭框架
Fig = figure('Position',[600,200,1000,750],'menu','none',...
    'Color','white','NumberTitle','off','Name','GUI9');
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
% 文本框
str = '';
Text = uicontrol(Pnl2,'style','text',...
    'String',str,'Fontsize',16,...
    'Units','normalized','Position',[0.1,0.1,0.8,0.5]);
% 按钮组
Bt1 = uicontrol(Pnl2,'style','togglebutton',...
    'String','创建新圆形','Fontsize',16,'BackgroundColor',[0.6,1,0.6],...
    'Unit','normalized','Position',[0,0.9,1,0.1],...
    'Callback',@Doit1);
Bt2 = uicontrol(Pnl2,'style','togglebutton',...
    'String','修改已有圆形','Fontsize',16,'BackgroundColor',[0.6,0.6,1],...
    'Unit','normalized','Position',[0,0.8,1,0.1],...
    'Callback',@Doit2);
Bt3 = uicontrol(Pnl2,'style','togglebutton',...
    'String','清除已有圆形','Fontsize',16,'BackgroundColor',[1,0.6,0.6],...
    'Unit','normalized','Position',[0,0.7,1,0.1],...
    'Callback',@Doit3);

%% 成员
% 执行什么任务
task = 0;
state = 0;
tmp = [];% 存临时句柄
% 记录鼠标位置
p1 = [];
p2 = [];
% 圆信息
circleInfo = []; % 存圆心半径
circleList = {}; % 存句柄
circleNum = 0; % 数量
circleIdx = 0; % 当前操作对象
basicCircle = DrawCircle(); % 基本结构

%% 按钮组
    function Doit1(~,~)
        if get(Bt1,'Value')
            set(Bt2,'Value',0)
            set(Bt3,'Value',0)
            task = 1;
            str = '请确定圆心位置';
            set(Text,'String',str)
        else
            task = 0;
        end
    end

    function Doit2(~,~)
        if get(Bt2,'Value')
            set(Bt1,'Value',0)
            set(Bt3,'Value',0)
            task = 2;
            str = '请选择要修改的圆';
            set(Text,'String',str)
        else
            task = 0;
        end
    end

    function Doit3(~,~)
        if get(Bt3,'Value')
            set(Bt1,'Value',0)
            set(Bt2,'Value',0)
            task = 3;
            str = '请选择要删除的圆';
            set(Text,'String',str)
        else
            task = 0;
        end
    end

%% 鼠标组
    function ButtonDown(~,~)
        cp = get(gca,'currentpoint');
        switch task
            case 1
                p1 = [cp(1,1),cp(1,2)];
                tmp = plot(p1(1),p1(2),'r.','Parent',Axes);
                state = 1;
            case 2
                if circleNum>0
                    p1 = [cp(1,1),cp(1,2)];
                    circleIdx = ChooseCircle(circleInfo,p1);
                    set(circleList{circleIdx},'LineStyle','--')
                    state = 1;
                end
            case 3
                if circleNum>0
                    p1 = [cp(1,1),cp(1,2)];
                    circleIdx = ChooseCircle(circleInfo,p1);
                    state = 1;
                end
        end
    end

    function ButtonUp(~,~)
        if state
            cp = get(gca,'currentpoint');
            switch task
                case 1
                    delete(tmp)
                    p2 = [cp(1,1),cp(1,2)];
                    R = norm(p1-p2);
                    [cx,cy] = Updata(basicCircle,[p1,R]);
                    h = plot(cx,cy,'LineWidth',5,'Parent',Axes);
                    
                    circleNum = circleNum+1;
                    circleIdx = circleNum;
                    circleInfo(circleNum,:) = [p1,R];
                    circleList{circleNum} = h;
                case 2
                    set(circleList{circleIdx},'LineStyle','-')
                case 3
                    delete(circleList{circleIdx})
                    circleList(circleIdx) = [];
                    circleInfo(circleIdx,:) = [];
                    circleNum = circleNum-1;
            end
            state = 0;
        end
    end

    function ButtonMotion(~,~)
        if task==2 && state
            cp = get(gca,'currentpoint');
            p2 = [cp(1,1),cp(1,2)];
            dp = p2-p1;
            if norm(dp)>0.01
                circleInfo(circleIdx,1:2) = circleInfo(circleIdx,1:2)+dp;
                [cx,cy] = Updata(basicCircle,circleInfo(circleIdx,:));
                circleList{circleIdx}.XData = cx;
                circleList{circleIdx}.YData = cy;
                p1 = p2;
            end
        end
    end

    function ScrollWheel(~,event)
        if task==2 
            cp = get(gca,'currentpoint');
            p2 = [cp(1,1),cp(1,2)];
            circleIdx = ChooseCircle(circleInfo,p2);
            
            value = event.VerticalScrollCount; % 关键句
            circleInfo(circleIdx,3) = max(circleInfo(circleIdx,3)+value*0.01,0.01);
            [cx,cy] = Updata(basicCircle,circleInfo(circleIdx,:));
            circleList{circleIdx}.XData = cx;
            circleList{circleIdx}.YData = cy;
            
        end
    end

%% 子函数
% 计算距离
    function idx = ChooseCircle(circleInfo,C)
        dis = sum((circleInfo(:,1:2)-C).^2,2);
        [~,idx] = min(dis);
    end

% 更新圆
    function [cx,cy] = Updata(basicCircle,w)
        cx = w(3)*basicCircle(:,1)+w(1);
        cy = w(3)*basicCircle(:,2)+w(2);
    end

% 生成圆形
    function out = DrawCircle()
        t = 0:pi/32:2*pi;
        cx = cos(t');
        cy = sin(t');
        out = [cx,cy];
    end

end