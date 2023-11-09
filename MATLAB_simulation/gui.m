function varargout = gui(varargin)
% GUI MATLAB code for gui.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui

% Last Modified by GUIDE v2.5 25-Jan-2023 15:16:16

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT



% --- Executes just before gui is made visible.
function gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui (see VARARGIN)

% Choose default command line output for gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);
global x;
global y;
x=0;
y=0;


% --- Outputs from this function are returned to the command line.
function varargout = gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;





% --- Executes during object creation, after setting all properties.
function axes3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes3


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
cla reset;
global x;
global y;
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
x=get(handles.slider1,'value')
y=get(handles.slider2,'value')

% 两个电机角速度以及角加速度
omega1=500;
omega4=500;
alpha1=0;
alpha4=0;

[u1,u4]=inverseF(x,y,l1,l2,l3,l4,l5)


[xc,yc,u2,u3,omega,alpha]=five(u1,u4,omega1,omega4,l1,l2,l3,l4,l5,alpha1,alpha4)

theta2(1) = u2;
theta3(1) = u3;
    
omega2(1)=omega(1);
omega3(1)=omega(2);
    
alpha2(1)=alpha(1);
alpha3(1)=alpha(2);
    
xcd(1) = xc;
ycd(1) = yc;

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

plot(handles.axes3,x,y,'k');
grid on;
hold on;
plot(handles.axes3,x(1),y(1),'ro');
plot(handles.axes3,x(2),y(2),'ro');
plot(handles.axes3,x(3),y(3),'ro');
plot(handles.axes3,x(4),y(4),'ro');
plot(handles.axes3,x(5),y(5),'ro');
axis(handles.axes3,[-200 600 -200 600]);
title('并联SCARA');
xlabel('mm');
ylabel('mm');
grid on;




% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider



% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function drag_point(hObject, eventdata, handles)
global xData yData hl hp flag
flag = 0;
hl = line(xData, yData);
axes(handles.axes3);
distance = max(xData) - min(xData);
factor = 0.05;
axis([min(xData)-distance*factor, max(xData)+distance*factor , min(yData)-distance*factor, max(yData)+distance*factor]);
for i = numel(xData):-1:1
    hp(i) = patch('xdata',xData(i),'ydata',yData(i),...
        'linestyle','none','facecolor','none',...
        'marker','o','markerEdgecolor','k',...
        'markersize', 3, ...
        'buttonDownFcn',@drag,'userdata',i);
end

function drag(src, ~)
global index of
index = get(src,'userdata');
of = get(gcbf,{'WindowButtonMotionFcn','WindowButtonUpFcn'});
set(gcbf,'WindowButtonMotionFcn',@move,'WindowButtonUpFcn',@drop);
    
function move(~, ~)
global index points hl hp xData
points = get(gca,'currentPoint');
xn = points(1);
yn = points(3);
if index>1 && index<size(xData,2)
    if xn<hl.XData(index-1)
        xn = hl.XData(index-1);
    end
    if xn>hl.XData(index+1)
        xn = hl.XData(index+1);
    end
    if yn<hl.YData(index-1)
        yn = hl.YData(index-1);
    end
    if yn>hl.YData(index+1)
        yn = hl.YData(index+1);
    end
end
set(hp(index),'xdata',xn,'ydata',yn)
hl.XData(index) = xn;
hl.YData(index) = yn;

function drop(src,~)
global of
set(src,'WindowButtonMotionFcn',of{1},'WindowButtonUpFcn',of{2});


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global xData yData
drag_point(hObject, eventdata, handles)
