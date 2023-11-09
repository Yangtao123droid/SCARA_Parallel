function varargout = untitled7(varargin)
% UNTITLED7 MATLAB code for untitled7.fig
%      UNTITLED7, by itself, creates a new UNTITLED7 or raises the existing
%      singleton*.
%
%      H = UNTITLED7 returns the handle to a new UNTITLED7 or the handle to
%      the existing singleton*.
%
%      UNTITLED7('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in UNTITLED7.M with the given input arguments.
%
%      UNTITLED7('Property','Value',...) creates a new UNTITLED7 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before untitled7_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to untitled7_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help untitled7

% Last Modified by GUIDE v2.5 25-Jan-2023 13:48:47

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @untitled7_OpeningFcn, ...
                   'gui_OutputFcn',  @untitled7_OutputFcn, ...
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


% --- Executes just before untitled7 is made visible.
function untitled7_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to untitled7 (see VARARGIN)

% Choose default command line output for untitled7
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes untitled7 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = untitled7_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
x1=get(handles.slider1,'value')
x=linspace(0,x1,50)%50个点
y=sqrt(1-(x-1).^2);%圆函数 注意是点乘
plot(handles.axes1,x,y,'ro')
axis(handles.axes1,[0 2 -1 1]);
grid on


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
