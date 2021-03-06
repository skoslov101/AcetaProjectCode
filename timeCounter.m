%% Set up screen and intro
% Open window if window doesn't exist
if ~exist('window','var')
    [window, screenRect] = Screen(0,'OpenWindow');
    HideCursor;
else
    [window, screenRect]=Screen(0,'OpenWindow'); 
end



% Specify color values
white = [255 255 255];
gray = [128 128 128];
black = [0 0 0];
green = [0 255/2 0];

rect = get( 0, 'Screensize' ); 
Xorigin = rect(3)/2; %X Center of screen
Yorigin = rect(4)/2; %Y Center of screen

%This is the start of the entire experiment
timeStart=GetSecs;

effTime=2;

sinceStart=GetSecs-timeStart;
while (sinceStart/60)<=effTime
    tic
    sinceStart=GetSecs-timeStart;
    timeRem=((effTime*60)-sinceStart)/60;
    timeRemStr=mat2str(timeRem);
    dotSpot=find(timeRemStr(:)=='.');
    if dotSpot>1
        mins=timeRemStr(1:dotSpot-1);
    else
        mins='0';
    end
    secs=mat2str(round(60*str2double(timeRemStr(dotSpot:end))));
    if str2double(secs)<=9
        secs=['0' secs];
    end
    timeRemNow=[mins ':' secs];
    
    sinceStartTxt={'You have completed this task.',...
        '',...
        'We want you to take a timed break at this time.',...
        'Your next task will begin in' timeRemNow ' minutes'};
    cenTex(sinceStartTxt,window,rect, white, black, 32);
    t1=toc;
    pause(1-t1);
end
Screen(window,'FillRect',black);
Screen('CloseAll')