function varargout = test(varargin)
% TEST M-file for test.fig
%      TEST, by itself, creates a new TEST or raises the existing
%      singleton*.
%
%      H = TEST returns the handle to a new TEST or the handle to
%      the existing singleton*.
%
%      TEST('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TEST.M with the given input arguments.
%
%      TEST('Property','Value',...) creates a new TEST or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before test_OpeningFunction gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to test_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help test

% Last Modified by GUIDE v2.5 25-Jan-2023 14:33:08

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @test_OpeningFcn, ...
                   'gui_OutputFcn',  @test_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin & isstr(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

% --- Executes just before test is made visible.
function test_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to test (see VARARGIN)

% Choose default command line output for test
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes test wait for user response (see UIRESUME)
% uiwait(handles.figure1);
set(gcf,'MenuBar','figure');
set(gcf,'ToolBar','figure');
set(gca,'Box','on');

% --- Outputs from this function are returned to the command line.
function varargout = test_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc
    set(hObject,'BackgroundColor','white');
else
    set(hObject,'BackgroundColor',get(0,'defaultUicontrolBackgroundColor'));
end


% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1

value1 = get(handles.listbox1,'value');
switch value1
    case 1
        x = [0:0.1:6.28];
        y = sin(x);
        handles.C = plot(x,y,'b')
        grid on
    case 2
        x = [0:0.1:6.28];
        y = sin(2*x)+1.5*cos(4*x);
        handles.C = plot(x,y,'r')
        grid on
    case 3
        x = [0:0.1:6.28];
        y = 0.5*sin(4*x)+1.5*cos(2*x);
        %xx = evalin('base','x')
        %yy = evalin('base','y')
        handles.C = plot(x,y,'black')
        grid on
    otherwise
        ;
end
guidata(hObject, handles);


% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1
try
    delete(handles.A);
    delete(handles.B);
    guidata(hObject, handles);
catch
    ;
end
if get(handles.radiobutton1,'value') == 0
    set(handles.text1,'BackgroundColor',128/255*[1 1 1]);
    set(handles.text2,'BackgroundColor',128/255*[1 1 1]);
else
    set(handles.text1,'BackgroundColor',255/255*[1 1 1]);
    set(handles.text2,'BackgroundColor',255/255*[1 1 1]);
end


% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton2
if get(handles.radiobutton2,'value') == 0
	try
        set(handles.C,'LineStyle','-')
        set(handles.C,'Marker','none')
	catch
        return;
	end
    set(handles.text1,'BackgroundColor',128/255*[1 1 1]);
    set(handles.text2,'BackgroundColor',128/255*[1 1 1]);
else
	try
        set(handles.C,'LineStyle','-')
        set(handles.C,'Marker','*')
    catch
        return;
	end

end


function test_WindowButtonMotionFcn_Callback(hObject, eventdata, handles)
AxesLineState = get(handles.radiobutton1,'value');
AxesDataState = get(handles.radiobutton2,'value');
if AxesLineState == 1
    currPt = get(gca, 'CurrentPoint');
    x = currPt(1,1);
    y = currPt(1,2);
	Xminmax = get(gca,'Xlim');
	Yminmax = get(gca,'Ylim');
    if Xminmax(1)<=x&&x<=Xminmax(2)&&Yminmax(1)<=y&&y<=Yminmax(2)
        if AxesDataState == 0
            try
                set(handles.A,'XData',Xminmax,'YData',[y,y]);
                set(handles.B,'XData',[x,x],'YData',Yminmax);
            catch
                handles.A = line(Xminmax,[y,y],'Color','magenta');
                handles.B = line([x,x],Yminmax,'Color','magenta');
                guidata(hObject, handles);
            end
            set(handles.text1,'String',num2str(x))
            set(handles.text2,'String',num2str(y))
        else
            try
                Datax = get(handles.C,'XData');
                Datay = get(handles.C,'YData');
                set(handles.C,'LineStyle','-')
                set(handles.C,'Marker','*')
            catch
                return;
            end
            
            if x<min(Datax)
                x = min(Datax);
            elseif x>max(Datax)
                x = max(Datax);
            else
                ;
            end
                
            xIndex = interp1(Datax,[1:1:length(Datax)],x);
            xIndex = round(xIndex);
            x = Datax(xIndex);
            y = Datay(xIndex);
            try
                set(handles.A,'XData',Xminmax,'YData',[y,y]);
                set(handles.B,'XData',[x,x],'YData',Yminmax);
            catch
                handles.A = line(Xminmax,[y,y],'Color','green');
                handles.B = line([x,x],Yminmax,'Color','green');
                guidata(hObject, handles);
            end
            set(handles.text1,'String',num2str(x))
            set(handles.text2,'String',num2str(y))  
        end
    end
else
    ;
end


function test_KeyPressFcn_Callback(hObject, eventdata, handles)
    disp('here!!!')
a = get(gcf,'CurrentCharacter')


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1
