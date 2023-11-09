function varargout = movePoints(varargin)
% MOVEPOINTS MATLAB code for movePoints.fig
%      MOVEPOINTS, by itself, creates a new MOVEPOINTS or raises the existing
%      singleton*.
%
%      H = MOVEPOINTS returns the handle to a new MOVEPOINTS or the handle to
%      the existing singleton*.
%
%      MOVEPOINTS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MOVEPOINTS.M with the given input arguments.
%
%      MOVEPOINTS('Property','Value',...) creates a new MOVEPOINTS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before movePoints_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to movePoints_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help movePoints

% Last Modified by GUIDE v2.5 29-Jul-2018 04:49:24

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @movePoints_OpeningFcn, ...
                   'gui_OutputFcn',  @movePoints_OutputFcn, ...
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


% --- Executes just before movePoints is made visible.
function movePoints_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to movePoints (see VARARGIN)

% Choose default command line output for movePoints
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes movePoints wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = movePoints_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global xData yData
xData = textread('xData.txt');
yData = textread('yData.txt');
drag_point(hObject, eventdata, handles)

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
zoom on;


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
zoom off;

function drag_point(hObject, eventdata, handles)
global xData yData hl hp flag
flag = 0;
hl = line(xData, yData);
axes(handles.axes1);
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


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global flag hl
flag = 1;
dlmwrite('newX.txt',hl.XData)
dlmwrite('newY.txt',hl.YData)

% --- Executes on mouse press over axes background.
function axes1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% axes(handles.axes1);
% zoom on
global flag
if flag==1
    drag_point(hObject, eventdata, handles);
end


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1);
positionX = get(gca, 'xlim');
% positionY = get(gca, 'ylim');
factor = 0.1;
positionX = positionX - factor * (positionX(2)-positionX(1));
set(gca, 'xlim', [positionX(1), positionX(2)]);
% set(gca, 'ylim', [positionY(1),  positionY(2)]);


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1);
positionX = get(gca, 'xlim');
% positionY = get(gca, 'ylim');
factor = 0.1;
positionX = positionX + factor * (positionX(2)-positionX(1));
set(gca, 'xlim', [positionX(1), positionX(2)]);
