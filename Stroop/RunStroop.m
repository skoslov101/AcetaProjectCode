%% Computerized Stroop Task
%This is so that we can have a computerized stroop to run.  There are a few
%different designs that could be implemented, but this is the 10minute,
%simple version.  This version will only use the colors Red, Blue, and
%Green on a white background.

% There will be 54 trials of congruent, 54 of incongruent, and 54 of
% neutral (XXXX) trials randomly mixed together.  Breaks will occur every
% 54 trials, so there will be 3 blocks of 54 (18 of each stim type).  Each block
% will contain 6 BB/GG/RR combos and 3 each of the incongruent combos and 6
% XXXX of each of the three colors.

%Stimuli are presented one at a time in the center of the screen.  The word
%will be on the screen for a maximum of 1.5s, after which a fixation cross
%will come up for .5s before the next trial (.5s ITI).
%Trials that get a response before 1.5s will end at the
%response time, and proceed to the fixation cross for .5.
clear


%% setup
%First, switch directories to the program files director
exptDir = pwd;
dataDir=[pwd '/Data/'];

%% Set up randomization
rseed = sum(100*clock);
rng(rseed,'twister');

%% Get input for experiment
% Enter subject data
datainputflag = 0;
while datainputflag ~= 1
    initflag = 0;
    while initflag ~= 1
        prompt = {'Subject Number', 'Subject Initials'};
        name = 'Welcome to VisSearch';
        defAns = {'9999','test','0'};
        options.Resize = 'on';
        options.WindowStyle = 'normal';
        options.Interpreter = 'tex';
        info = inputdlg(prompt,name,1,defAns,options);
        if isempty(info)
            return
        end
        subjectNum = info{1};
        subjectName = info{2};
%         slackmsg=str2double(info{3});
%         condNum = str2double(info{4});

        initTest = str2double(subjectName);
        if isnan(initTest)
            pinit = info{2};
            initCH = 1;
            initCHerr = '';
        else
            initCH = 0;
            initCHerr = 'Subject Initials needs to be entered as letters';
        end

        subjectNtest = str2double(subjectNum);
        if isnan(subjectNtest)
            subCH = 0;
            subCHerr = 'Subject Number needs to be entered as (a) number(s)';
        else
            subCHerr = '';
            subCH = 1;
        end
        

        if initCH + subCH == 2
            if strcmpi(pinit,'debug')
                options.Default='No';
                debugquest = 'You have initialized debug mode, do you want to continue in debug mode?';
                orlydebug = questdlg(debugquest,'Debug Mode?','Yes','No',options);
                if strcmpi(orlydebug,'Yes')
                    initflag = 1;
                end
                debug = 1;
            else
                debug = 0;
                initflag = 1;
            end  
        else
            errorText = {initCHerr, subCHerr};
            uiwait(errordlg(errorText, 'Error!'));
        end
    end


    options.Default='No';
    checkinfo = {'Is the following information correct',...
        '',...
        [pinit ' = Subject`s Initials'],...
        [subjectNum ' = Subject Number'],...
        };
    check = questdlg(checkinfo,'Is this info correct?','Yes','No',options);
    if strcmpi(check,'Yes')
        datainputflag = 1;
    end
end


fileName=[dataDir 'Stroop' pinit '_' subjectNum '.mat'];

%% For testing
% Open window if window doesn't exist
if ~exist('window','var')
    [window, screenRect] = Screen(0,'OpenWindow');
    HideCursor;
else
    [window, screenRect]=Screen(0,'OpenWindow'); 
end

%% For testing
if debug==1
    speedup=1/100;
else
    speedup=1;
end
HideCursor

%% More screen specifications
% Specify color values
white = [255 255 255];
gray = [128 128 128];
black = [0 0 0];
green = [0 255/2 0];
red = [255/2, 0, 0];
blue = [0, 0, 255/2];

rect = get( 0, 'Screensize' ); 
Xorigin = rect(3)/2; %X Center of screen
Yorigin = rect(4)/2; %Y Center of screen
xSize = rect(3); %length of the x-dim of the screen
ySize = rect(4); %length of the y-dim of the screen
SCREEN(window,'TextSize',32); %The text size for instructions and stroop testing will be different

%% Set up stimuli
% The stimN number will need to change to accomodate different trial
% numbers.  This isn't the best way to do this code, but I was lazy.
%Correct responses are 1=Red; 2=Blue; 3=Green
stimWord=cell(54,3);
for stimN=1:54
    if stimN<=12
        stimWord{stimN,1}='RED';
    elseif stimN<=24
        stimWord{stimN,1}='GREEN';
    elseif stimN<=36
        stimWord{stimN,1}='BLUE';
    else
        stimWord{stimN,1}='XXXX';
    end
end
for stimN=1:54
    if stimN<=6
        stimWord{stimN,2}=red;
        stimWord{stimN,3}=1;
    elseif stimN<=9
        stimWord{stimN,2}=blue;
        stimWord{stimN,3}=2;
    elseif stimN<=12
        stimWord{stimN,2}=green;
        stimWord{stimN,3}=3;
    elseif stimN<=18
        stimWord{stimN,2}=green;
        stimWord{stimN,3}=3;
    elseif stimN<=21
        stimWord{stimN,2}=blue;
        stimWord{stimN,3}=2;
    elseif stimN<=24
        stimWord{stimN,2}=red;
        stimWord{stimN,3}=1;
    elseif stimN<=30
        stimWord{stimN,2}=blue;
        stimWord{stimN,3}=2;
    elseif stimN<=33
        stimWord{stimN,2}=green;
        stimWord{stimN,3}=3;
    elseif stimN<=36
        stimWord{stimN,2}=red;
        stimWord{stimN,3}=1;
    elseif stimN<=42
        stimWord{stimN,2}=red;
        stimWord{stimN,3}=1;
    elseif stimN<=48
        stimWord{stimN,2}=green;
        stimWord{stimN,3}=3;
    else
        stimWord{stimN,2}=blue;
        stimWord{stimN,3}=2;
    end
end

%Practice Stim List
pracListWord=cell(18,1);
for stimN=1:18
    if stimN<=4
        pracListWord{stimN,1}='BLUE';
    elseif stimN<=8
        pracListWord{stimN,1}='RED';
    elseif stimN<=12
        pracListWord{stimN,1}='GREEN';
    else
        pracListWord{stimN,1}='XXXX';
    end
end
pracListCol={blue;blue;red;green;red;red;blue;green;green;green;blue;red;blue;blue;...
    green;green;red;red};
pracListAns={2;2;1;3;1;1;2;3;3;3;2;1;2;2;3;3;1;1};

pracList=[pracListWord,pracListCol,pracListAns];
        

trialTiming=1.5;


%% Start the experiment
%Instructions
instructions = {'Thanks for participating in this experiment!',...
    'You are going to be asked to perform the STROOP Task.',...
    '',...
    'In this tasks, you will see a word, like ''RED'', or a series of ''XXXX''',...
    'appear in the middle of the screen.',...
    '',...
    'Your task is to report the COLOR of the font, and to ignore the meaning of the word.'
    '',...
    'Press the SPACEBAR to continue.'};
cenTex(instructions,window,screenRect,black,white,24) % Print text centered
if debug~=1;getResp('space');end; % Wait for user to press 'space bar'; 

% Show intro slides here
slides=cell(3,1);
slides{1,1}='/Users/srk482/Dropbox (Personal)/AcetoProject/Stroop/InstructionSlides/Slide1.jpg';
slides{2,1}='/Users/srk482/Dropbox (Personal)/AcetoProject/Stroop/InstructionSlides/Slide2.jpg';
slides{3,1}='/Users/srk482/Dropbox (Personal)/AcetoProject/Stroop/InstructionSlides/Slide3.jpg';
for introSlideI=1:3
    imgStr=slides{introSlideI};
    img=imread(imgStr,'jpg');
    
    [w, h, null] = size(img);
%     hs = h;
%     ws = w;
    %Place the image on the screen
    loc = [Xorigin - w, Yorigin-h, Xorigin+w, Yorigin+h];
    Screen(window,'PutImage',img,loc)
    if debug~=1;getResp('space');end; % Wait for user to press 'space bar'; 
end
%
instructions = {'Please try to answer as quickly as possible',...
    'without sacrificing accuracy.',...
    '',...
    'You will have 1.5s on each trial to respond.',...
    'If you do not respond in time, that trial will be marked as incorrect and',...
    'the next trial will begin.',...
    '',...
    'If you think the correct response is ''red'', respond by pressing ''1''.',...
    'If you think the correct response is ''blue'', respond by pressing ''2''.',...
    'If you think the correct response is ''green'', respond by pressing ''3''.',...
    '',...
    'Please remember, your task is always to report the COLOR of the font,',... 
    'and to ignore the meaning of the word.',...
    '',...
    'Press the SPACEBAR to continue to the practice trials.'};
cenTex(instructions,window,screenRect,white,black,24) % Print text centered
if debug~=1;getResp('space');end; % Wait for user to press 'space bar'; 

instructions = {'During practice we will show you the correct response buttons.',...
    'However, during the task, you will not have them.',...
    '',...
    'So please try your best to remember: ',...
    'If you think the correct response is ''red'', respond by pressing ''1''.',...
    'If you think the correct response is ''blue'', respond by pressing ''2''.',...
    'If you think the correct response is ''green'', respond by pressing ''3''.',...
    '',...
    'Press the SPACEBAR to begin the practice trials.'};
cenTex(instructions,window,screenRect,white,black,24) % Print text centered
if debug~=1;getResp('space');end; % Wait for user to press 'space bar';

%% set font for Task
Screen(window,'TextSize',66);

%% set data array
data=cell(180,5); %180 trials and 5 columns per trial

%% Practice Trials (x18)
%Quick indication that the experiment is about to begin
cenTex({'Beginning Practice.'},window,screenRect,white,black,24) % Print text centered
pause(.5);
cenTex({'Beginning Practice..'},window,screenRect,white,black,24) % Print text centered
pause(.5);
cenTex({'Beginning Practice...'},window,screenRect,white,black,24) % Print text centered
pause(1);

Screen(window,'FillRect',white);

%Shuffle prac stims
pracList=Shuffle(pracList);

for pracI=1:18
    stimWord=pracList(pracI,1);
    stimCol=pracList{pracI,2};
    CR=pracList{pracI,3};
    
    %Display words but have the response keys along the top
    cenTex_Stroop(stimWord,window,screenRect,white,stimCol,24)
    
    %Collect Response
    %Now we want to actually collect and record results.  There will be
    %1.5s for each response
    if debug~=1
        [resp, rt]=GetRespTimed('1!','2@',trialTiming);
    else
        resp=randi(2)-1; rt=rand(1)*2; 
    end
    
    Screen(window,'FillRect',white);
    resp=resp-1;
    if resp==CR
        cenTex_Stroop({'CORRECT!'},window,screenRect,white,green,24)
    else
        cenTex_Stroop({'INCORRECT.'},window,screenRect,white,red,24)
    end
    pause(1)
    
    Screen(window,'FillRect',white);
    cenTex_Stroop({'+'},window,screenRect,white,black,24)
    pause(1);
    
    data{pracI,1}=stimWord;
    data{pracI,2}=stimCol;
    data{pracI,3}=CR;
    data{pracI,4}=resp;
    data{pracI,5}=rt;
end
    

%% Now for the real task

%Task instructions


%Begin block loop
for blockI=1:3
    for trialI=1:54
        stimWord=pracList(triallI,1);
        stimCol=pracList{trialI,2};
        CR=pracList{trialI,3};

        %Display words but have the response keys along the top
        cenTex_Stroop(stimWord,window,screenRect,white,stimCol,24)

        %Collect Response
        %Now we want to actually collect and record results.  There will be
        %1.5s for each response
        if debug~=1
            [resp, rt]=GetRespTimed('1!','2@',trialTiming);
        else
            resp=randi(2)-1; rt=rand(1)*2; 
        end

        Screen(window,'FillRect',white);
        resp=resp-1;
        if resp==CR
            cenTex_Stroop({'CORRECT!'},window,screenRect,white,green,24)
        else
            cenTex_Stroop({'INCORRECT.'},window,screenRect,white,red,24)
        end
        pause(1)

        Screen(window,'FillRect',white);
        cenTex_Stroop({'+'},window,screenRect,white,black,24)
        pause(1);

        data{(BlockI-1)*54+trialI+18,1}=stimWord;
        data{(BlockI-1)*54+trialI+18,2}=stimCol;
        data{(BlockI-1)*54+trialI+18,3}=CR;
        data{(BlockI-1)*54+trialI+18,4}=resp;
        data{(BlockI-1)*54+trialI+18,5}=rt;
    end 
    
    %Take a break at the end of each block
end

%Save data
save(fileName,'data');
    
%end of experiment bit

%sav

