function varargout = jun_gui(varargin)
% JUN_GUI MATLAB code for jun_gui.fig
%      JUN_GUI, by itself, creates a new JUN_GUI or raises the existing
%      singleton*.
%
%      H = JUN_GUI returns the handle to a new JUN_GUI or the handle to
%      the existing singleton*.
%
%      JUN_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in JUN_GUI.M with the given input arguments.
%
%      JUN_GUI('Property','Value',...) creates a new JUN_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before jun_gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to jun_gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help jun_gui

% Last Modified by GUIDE v2.5 02-Mar-2016 17:32:25

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @jun_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @jun_gui_OutputFcn, ...
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


% --- Executes just before jun_gui is made visible.
function jun_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to jun_gui (see VARARGIN)

% Choose default command line output for jun_gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);


% UIWAIT makes jun_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = jun_gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in retrieve.
function retrieve_Callback(hObject, eventdata, handles)
% hObject    handle to retrieve (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%handles.output = hObject;
% Update handles structure
%guidata(hObject, handles);

%get the input content
val=get(handles.ipquery,'String');

%initialize
currPath=fileparts(mfilename('fullpath'));
addpath(genpath(pwd));
addpath(genpath(currPath));
addpath smallTOSCA
load sumcodenumb.mat
load hksKmean.mat
guidata(hObject,handles);

%calculate and compare with the codebook
[cat0_hks] = compute_HKS(val,'OFF');
[cat0_codenumb]=codenumb(cat0_hks);
kk=cat0_codenumb(:,2)';
distance_cat0=pdist2(kk,sumcodenumb);
[s,indi]=sort(distance_cat0');
%[M,I]=min(distance_cat0');
%[filename,pathname]=uigetfile('*.mat','select');
net=load('hksKmean.mat');
handles.net=net;%put net into handles
guidata(hObject,handles);%update guidata

I=indi(1);
query=net.dataset(I); %the min, it is what we want
[v,f]=read_off(query.name);
scatter3(handles.mainfigure,v(:,1),v(:,2),v(:,3),'b.');
axis normal;% I try "axis equal", it is still can't give a good performance

I=indi(2);
query=net.dataset(I); %the 2second min
[v,f]=read_off(query.name);
scatter3(handles.subfigure1,v(:,1),v(:,2),v(:,3),'b.');
axis normal;

I=indi(3);
query=net.dataset(I); %the 3th min
[v,f]=read_off(query.name);
scatter3(handles.subfigure2,v(:,1),v(:,2),v(:,3),'b.');
axis normal;

I=indi(4);
query=net.dataset(I);%the 4th min
[v,f]=read_off(query.name);
scatter3(handles.subfigure3,v(:,1),v(:,2),v(:,3),'b.');
axis normal;

I=indi(5);
query=net.dataset(I); %the 5th min
[v,f]=read_off(query.name);
scatter3(handles.subfigure4,v(:,1),v(:,2),v(:,3),'b.');
axis normal;

I=indi(6);
query=net.dataset(I); %the 6th min
[v,f]=read_off(query.name);
scatter3(handles.subfigure5,v(:,1),v(:,2),v(:,3),'b.');
axis normal;
close(gcf)%I dont know why it always pop up a blank figure, so I need to close it!


function ipquery_Callback(hObject, eventdata, handles)
% hObject    handle to ipquery (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ipquery as text
%        str2double(get(hObject,'String')) returns contents of ipquery as a double


% --- Executes during object creation, after setting all properties.
function ipquery_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ipquery (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
