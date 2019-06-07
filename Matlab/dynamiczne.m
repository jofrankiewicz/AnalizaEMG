function varargout = dynamiczne(varargin)
% DYNAMICZNE MATLAB code for dynamiczne.fig
%      DYNAMICZNE, by itself, creates a new DYNAMICZNE or raises the existing
%      singleton*.
%
%      H = DYNAMICZNE returns the handle to a new DYNAMICZNE or the handle to
%      the existing singleton*.
%
%      DYNAMICZNE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DYNAMICZNE.M with the given input arguments.
%
%      DYNAMICZNE('Property','Value',...) creates a new DYNAMICZNE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before dynamiczne_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to dynamiczne_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help dynamiczne

% Last Modified by GUIDE v2.5 16-Jan-2019 14:07:55

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @dynamiczne_OpeningFcn, ...
                   'gui_OutputFcn',  @dynamiczne_OutputFcn, ...
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


% --- Executes just before dynamiczne is made visible.
function dynamiczne_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to dynamiczne (see VARARGIN)

% Choose default command line output for dynamiczne
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes dynamiczne wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = dynamiczne_OutputFcn(hObject, eventdata, handles) 
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
rysuj(handles)


















function rysuj(handles)

h = animatedline('Color','m','LineWidth',1,'Parent', handles.axes1);
h2 = animatedline('Color','b','LineWidth',1,'Parent', handles.axes2);
h3 = animatedline('Color','k','LineWidth',1, 'Parent', handles.axes3);

t=linspace(0,298,298000);

load('emg1.mat')
load('emg2.mat')
load('emg4.mat')
load('pozycje_radiany.mat')

%handles.axes1=gca;


for i=1:298000
    
    theta = pozycje_radiany(i) - 90;
    rho = 5;
    [X(i),Y(i)] = pol2cart(theta, rho);
    [M(i),N(i)] = pol2cart(0, rho);
    
    
    
end

axes(handles.axes4);

for k = 1:10:length(emg1)
    
   
    if(k>5000)   
    gca=handles.axes1;    
    addpoints(h, t(k), emg1(k))
    gca.XLim =[t(k-5000), t(k)];
    gca.YLim = [0, 1000];
    grid on
    drawnow update
    
    
    gca=handles.axes2;   
    addpoints(h2, t(k), emg2(k))
    gca.XLim =[t(k-5000), t(k)];
    gca.YLim = [0, 1000];
    drawnow update
    
    
    gca=handles.axes3;    
    addpoints(h3, t(k), emg4(k))
    gca.XLim =[t(k-5000), t(k)];
    gca.YLim = [0, 1000];
    drawnow update
    else
        
    gca=handles.axes1;    
    addpoints(h, t(k), emg1(k)) 
    gca.XLim =[t(1), t(5000)];
    gca.YLim = [0, 1000];
    
    drawnow update
    
    
    gca=handles.axes2;   
    addpoints(h2, t(k), emg2(k))    
    gca.XLim =[t(1), t(5000)];
    gca.YLim = [0, 1000];
    drawnow update
    
    
    gca=handles.axes3;    
    addpoints(h3, t(k), emg4(k))
    gca.XLim =[t(1), t(5000)];
    gca.YLim = [0, 1000];
    drawnow update  
        
        
    end
        
        
    
    
    compass(X(k),Y(k));
    hold on
    compass(M(k),N(k));
    hold off
    
    xlabel('poruszaj±ca siê rêka    staw ³okciowy    przedramiê')
    ylabel('zakres ruchu rêki pacjenta')
    
end
    
  
