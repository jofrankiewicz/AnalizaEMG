function varargout = slider2(varargin)
% SLIDER2 MATLAB code for slider2.fig
%      SLIDER2, by itself, creates a new SLIDER2 or raises the existing
%      singleton*.
%
%      H = SLIDER2 returns the handle to a new SLIDER2 or the handle to
%      the existing singleton*.
%
%      SLIDER2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SLIDER2.M with the given input arguments.
%
%      SLIDER2('Property','Value',...) creates a new SLIDER2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before slider2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to slider2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help slider2

% Last Modified by GUIDE v2.5 15-Jan-2019 21:00:05

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @slider2_OpeningFcn, ...
                   'gui_OutputFcn',  @slider2_OutputFcn, ...
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


% --- Executes just before slider2 is made visible.
function slider2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to slider2 (see VARARGIN)

% Choose default command line output for slider2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes slider2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = slider2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

load('emg1.mat');
load('emg2.mat');
load('emg4.mat');

plot(handles.axes1,(round(get(hObject,'Value')*293000)+1):1:round(get(hObject,'Value')*293000+5000),emg1((round(get(hObject,'Value')*293000)+1):1:round(get(hObject,'Value')*293000+5000)));
plot(handles.axes2,(round(get(hObject,'Value')*293000)+1):1:round(get(hObject,'Value')*293000+5000),emg2((round(get(hObject,'Value')*293000)+1):1:round(get(hObject,'Value')*293000+5000)));
plot(handles.axes3,(round(get(hObject,'Value')*293000)+1):1:round(get(hObject,'Value')*293000+5000),emg4((round(get(hObject,'Value')*293000)+1):1:round(get(hObject,'Value')*293000+5000)));
%set axes
ylim(handles.axes1,[0 1000]);
ylim(handles.axes2,[0 1000]);
ylim(handles.axes3,[0 1000]);

sliderVal = get(handles.slider2, 'Value');
sliderVal = round(sliderVal * 298000);
set(handles.edit2, 'String', num2str(round(sliderVal)));

load('pozycje_radiany.mat');
theta = pozycje_radiany(sliderVal) - 90
rho = 5
[X,Y] = pol2cart(theta,rho)
[M,N] = pol2cart(0, rho)
compass(X,Y)
hold on
compass(M,N)
hold off
ylabel('zakres ruchu rêki pacjenta')
pause(0.001)

% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

 



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double
 %handles = guidata(hFigure);
 
 

% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
