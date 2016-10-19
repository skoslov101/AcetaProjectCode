function [affData]=AffectiveFlankerTask(debug,subjN,init,runNum,window,respBut)
%% Set up the experiment parameters
filename=['AffFlank_' mat2str(subjN) '_' init '_' mat2str(runNum) '.mat'];

if debug==1;speedup=1/100;else speedup=1;end % Speed up delays if in debug mode

% % Open window if window doesn't exist
% if ~exist('window','var')
%     [window, screenRect] = Screen(0,'OpenWindow');
%     HideCursor;
% else
%     [window, screenRect]=Screen(0,'OpenWindow'); 
% end
% 
% Specify color values
white = [255 255 255];
gray = [128 128 128];
black = [0 0 0];
green = [0 255/2 0];
% 
rect = get( 0, 'Screensize' ); 
screenRect=get(0,'Screensize');
Xorigin = rect(3)/2; %X Center of screen
Yorigin = rect(4)/2; %Y Center of screen
% xSize = rect(3); %length of the x-dim of the screen
% ySize = rect(4); %length of the y-dim of the screen

Screen(window,'TextSize',32);
Screen(window,'FillRect',black);

%% Stimuli Set up
%Set Directories
curDir=pwd;
stimDir=[curDir '/TopStims'];
pracDir=[curDir '/pracList'];
if respBut==1
    instDir=[curDir '/Instructions1'];
elseif respBut==2
    instDir=[curDir '/Instructions2'];
else
    instDir=[curDir '/Instructions3'];
end

%Actually its way faster to pregenerate the stimuli and then just load and
%shuffle for each block, so that's what I'll do.  Each row is a stimulus
%set.
[nothing1,nothing2,stimListOrig]=xlsread([stimDir '/stimList.xlsx']);
clear nothing1
clear nothing2
for stimI=1:length(stimListOrig)
    if respBut==1
        stimListOrig{stimI,5}=stimListOrig{stimI,2}(find(stimListOrig{stimI,2}=='.')-3:find(stimListOrig{stimI,2}=='.')-2);
        if strcmpi(stimListOrig{stimI,5},'AN')==1
            stimListOrig{stimI,6}=1; %angry
        elseif strcmpi(stimListOrig{stimI,5},'HA')==1
            stimListOrig{stimI,6}=2; %Happy
        else
            stimListOrig{stimI,6}=3; %Neutral
        end
    elseif respBut==2
        stimListOrig{stimI,5}=stimListOrig{stimI,2}(find(stimListOrig{stimI,2}=='.')-3:find(stimListOrig{stimI,2}=='.')-2);
        if strcmpi(stimListOrig{stimI,5},'AN')==1
            stimListOrig{stimI,6}=2; %angry
        elseif strcmpi(stimListOrig{stimI,5},'HA')==1
            stimListOrig{stimI,6}=3; %Happy
        else
            stimListOrig{stimI,6}=1; %Neutral
        end
    else
        stimListOrig{stimI,5}=stimListOrig{stimI,2}(find(stimListOrig{stimI,2}=='.')-3:find(stimListOrig{stimI,2}=='.')-2);
        if strcmpi(stimListOrig{stimI,5},'AN')==1
            stimListOrig{stimI,6}=3; %angry
        elseif strcmpi(stimListOrig{stimI,5},'HA')==1
            stimListOrig{stimI,6}=1; %Happy
        else
            stimListOrig{stimI,6}=2; %Neutral
        end
    end
end

%The practice data stuff
[nothing1,nothing2,pracList]=xlsread([pracDir '/pracList.xlsx']);
for stimI=1:length(pracList)
    if respBut==1
        pracList{stimI,5}=pracList{stimI,2}(find(pracList{stimI,2}=='.')-3:find(pracList{stimI,2}=='.')-2);
        if strcmpi(pracList{stimI,5},'AN')==1
            pracList{stimI,6}=1; %angry
        elseif strcmpi(pracList{stimI,5},'HA')==1
            pracList{stimI,6}=2; %Happy
        else
            pracList{stimI,6}=3; %Neutral
        end
    elseif respBut==2
        pracList{stimI,5}=pracList{stimI,2}(find(pracList{stimI,2}=='.')-3:find(pracList{stimI,2}=='.')-2);
        if strcmpi(pracList{stimI,5},'AN')==1
            pracList{stimI,6}=2; %angry
        elseif strcmpi(pracList{stimI,5},'HA')==1
            pracList{stimI,6}=3; %Happy
        else
            pracList{stimI,6}=1; %Neutral
        end
    else
        pracList{stimI,5}=pracList{stimI,2}(find(pracList{stimI,2}=='.')-3:find(pracList{stimI,2}=='.')-2);
        if strcmpi(pracList{stimI,5},'AN')==1
            pracList{stimI,6}=3; %angry
        elseif strcmpi(pracList{stimI,5},'HA')==1
            pracList{stimI,6}=1; %Happy
        else
            pracList{stimI,6}=2; %Neutral
        end
    end
end
clear nothing1
clear nothing2
%Decide the stimuli locations:


if respBut==1
    pracIns='(1) - Angry       (2) - Happy      (3) - Neutral';
    instInsert1= 'Press ''1'' if the target face is ANGRY.';
    instInsert2='Press ''2'' if the target face is HAPPY.';
    instInsert3= 'Press ''3'' if the target face is NEUTRAL.';
elseif respBut==2
    pracIns='(1) - Neutral       (2) - Angry      (3) - Happy';
    instInsert2= 'Press ''2'' if the target face is ANGRY.';
    instInsert3='Press ''3'' if the target face is HAPPY.';
    instInsert1= 'Press ''1'' if the target face is NEUTRAL.';
else
    pracIns='(1) - Happy       (2) - Neutral      (3) - Angry';
    instInsert3= 'Press ''3'' if the target face is ANGRY.';
    instInsert1='Press ''1'' if the target face is HAPPY.';
    instInsert2= 'Press ''2'' if the target face is NEUTRAL.';
end




%% Present instructions for the experiment
if runNum==1
    instList={'/Slide1.jpg';'/Slide2.jpg';'/Slide3.jpg';'/Slide4.jpg';'/Slide5.jpg';'/Slide6.jpg';'/Slide7.jpg'};
    for instI=1:length(instList)
        instN=[instDir instList{instI}];
        instSlide=imread(instN,'jpg');
        Screen(window,'PutImage',instSlide);
        getResp('space')
    end
else
    instList={'/Slide8.jpg';'/Slide2.jpg';'/Slide3.jpg';'/Slide4.jpg';'/Slide5.jpg';'/Slide6.jpg';'/Slide7.jpg'};
    for instI=1:length(instList)
        instN=[instDir instList{instI}];
        instSlide=imread(instN,'jpg');
        Screen(window,'PutImage',instSlide);
        getResp('space')
    end
end
    
cenTex({'Beginning Practice'},window,screenRect,white,black,24);
pause(.5);
%% Go through 10 trials of training with feedback
pracEnd=0;
while pracEnd==0
    
    %Shuffle stimuli by row for this block
    pracPerm=randperm(length(pracList));
    pracList=pracList(pracPerm,:);
    
    %Create jitter for practice block
    jitListP=.4 + (.6-.4).*rand(length(pracList),1);
    for pracTrialI=1:length(pracList)
        %500 ms fixation before trial
        cenTex({'+'},window,screenRect,white,black,24)
        pause(.5*speedup) 
        Screen(window,'FillRect',black);

        % Display Stim Image
        %Set the image string name
        imgFlank_Name=[pracDir '/' pracList{pracTrialI,1}];
        imgTarget_Name=[pracDir '/' pracList{pracTrialI,2}];
        %Get the image information
        ruleCR=pracList{pracTrialI,6};

        %Do the actual loading of the image file
        imgTarg=imread(imgTarget_Name,'jpg');
        imgFlank=imread(imgFlank_Name,'jpg');
        %Decide whether or not to greyscale
        imgTargG=rgb2gray(imgTarg);
        imgFlankG=rgb2gray(imgFlank);

        [wT, hT, nothing1] = size(imgTarg);
        imageHeight=hT/2;
        imageWidth=wT/3.75;
        clear nothing1

        %Decide the location for right, left flanker + target
        locTarg = [Xorigin - imageWidth/2, Yorigin-imageHeight/2, Xorigin+imageWidth/2, Yorigin+imageHeight/2];
        locLeft = [Xorigin - imageWidth - imageWidth/2, Yorigin-imageHeight/2, Xorigin-imageWidth/2, Yorigin+imageHeight/2];
        locRight= [Xorigin + imageWidth/2, Yorigin-imageHeight/2, Xorigin+imageWidth+imageWidth/2, Yorigin+imageHeight/2];
        Screen(window,'PutImage',imgTargG,locTarg)
        Screen(window,'PutImage',imgFlankG,locLeft)
        Screen(window,'PutImage',imgFlankG,locRight)

        %Draw Instruction Text
        Screen(window,'DrawText',pracIns,rect(3)*.2,rect(4)*.1,white);

        %Collect a response
        if debug~=1;[rawResponse, RT] = GetRespTimed('1','2','3',2);else rawResponse=randi(2)-1;RT=2*rand(1);end
        Screen(window,'FillRect', black); %Clear image following response (to display feedback)
        resp=rawResponse+1;

        %See the accuracy of that response
        if resp==ruleCR
            respAcc=1;
            cenTex({'Correct!'},window,screenRect,white,black,24)
        else
            respAcc=0;
            cenTex({'Incorrect!'},window,screenRect,white,black,24)
        end
        pause(1*speedup);

        %Fill in data info
        affData{pracTrialI,1}=0;
        affData{pracTrialI,2}=pracTrialI;
        affData{pracTrialI,3}=pracList{pracTrialI,2};
        affData{pracTrialI,4}=pracList{pracTrialI,1};
        affData{pracTrialI,5}=pracList{pracTrialI,4}; %1=Cong, 2=incong;
        affData{pracTrialI,6}=ruleCR;
        affData{pracTrialI,7}=resp;
        affData{pracTrialI,8}=respAcc;
        affData{pracTrialI,9}=RT;

        pracAcc(pracTrialI,1)=respAcc;

        %ITI
        affData{pracTrialI,10}=jitListP(pracTrialI,1);
        pause(jitListP(pracTrialI,1)*speedup) %500ms ITI
    end

    %calculate practice accuracy
    pracAccS=sum(pracAcc(:,1))/length(pracList);
    
    if pracAccS>=.8 || debug==1
        pracEnd=1;
    else
        repeatPracInst={'It looks like you missed quite a few trials.',...
            '',...
            'In order to make sure that you understand that task completely',...
            'we are going to have you do a few more practice trials.',...
            '',...
            'Please remember:' instInsert1 instInsert2 instInsert3,...
            '',...
            'Please answer as quickly as possible without sacrificing accuracy.',...
            '',...
            'Press the SPACEBAR to do more practice.'};
        cenTex(repeatPracInst,window,screenRect,white,black,24)
        if debug~=1
            getResp('space')
            Screen(window,'FillRect',black);
        end
%         getResp('space')
    end
end

%% Get ready for experiment.
beginBlocks={'Great!',...
    '',...
    'You are now ready to begin the trials that count.',...
    'From now on, the response buttons will not be shown',...
    'on the top of the screen.',...
    '',...
    'Please remember:' instInsert1 instInsert2 instInsert3,...
    '',...
    'Please answer as quickly as possible without sacrificing accuracy.',...
    '',...
    'Press the SPACEBAR to begin the experiment.'};
cenTex(beginBlocks,window,screenRect,white,black,24)
if debug~=1
    getResp('space')
    Screen(window,'FillRect',black);
end

cenTex({'Beginning Experiment.'},window,screenRect,white,black,24)
pause(.5)
cenTex({'Beginning Experiment..'},window,screenRect,white,black,24)
pause(.5)
cenTex({'Beginning Experiment...'},window,screenRect,white,black,24)
pause(1)

%% Run experiment
% affData=zeros(length(stimListOrig)*6,10);
for blockI=1:6 %There will be 6 blocks
% for blockI=1:1
    %Shuffle stimuli by row for this block
    stimPerm=randperm(length(stimListOrig));
    stimList=stimListOrig(stimPerm,:);
    
    jitList=.4 + (.6-.4).*rand(length(stimList),1);
    for trialI=1:length(stimList)
        %500 ms fixation before trial
        cenTex({'+'},window,screenRect,white,black,24)
        pause(.5*speedup) 
        Screen(window,'FillRect',black);
        

        
        % Display Stim Image
        %Set the image string name
        imgFlank_Name=[stimDir '/' stimList{trialI,1}];
        imgTarget_Name=[stimDir '/' stimList{trialI,2}];
        %Get the image information
        ruleCR=stimList{trialI,6};


        %Do the actual loading of the image file
        imgTarg=imread(imgTarget_Name,'jpg');
        imgFlank=imread(imgFlank_Name,'jpg');
        %Decide whether or not to greyscale
        imgTargG=rgb2gray(imgTarg);
        imgFlankG=rgb2gray(imgFlank);
        
        [wT, hT, nothing1] = size(imgTarg);
        clear nothing1
        imageHeight=hT/2;
        imageWidth=wT/3.75;
       
        
        %Decide the location for right, left flanker + target
        locTarg = [Xorigin - imageWidth/2, Yorigin-imageHeight/2, Xorigin+imageWidth/2, Yorigin+imageHeight/2];
        locLeft = [Xorigin - imageWidth - imageWidth/2, Yorigin-imageHeight/2, Xorigin-imageWidth/2, Yorigin+imageHeight/2];
        locRight= [Xorigin + imageWidth/2, Yorigin-imageHeight/2, Xorigin+imageWidth+imageWidth/2, Yorigin+imageHeight/2];
        Screen(window,'PutImage',imgTargG,locTarg)
        Screen(window,'PutImage',imgFlankG,locLeft)
        Screen(window,'PutImage',imgFlankG,locRight)
        
        %Collect a response
%         timeRT=0;
%         tic
%         while timeRT<=2
%             timeRT=toc;
        if debug~=1
            [rawResponse, RT] = getRespTimed('1','2','3',2);
        else
            rawResponse=randi(2)-1;
            RT=2*rand(1);
        end
%         end
        Screen(window,'FillRect', black); %Clear image following response (to display feedback)
        resp=rawResponse+1;
%         Screen(window,'FillRect',black);
        
        %See the accuracy of that response
        if resp==ruleCR
            respAcc=1;
        else
            respAcc=0;
        end
        
        %Fill in data info
        affData{(blockI-1)*length(stimList)+trialI+10,1}=blockI;
        affData{(blockI-1)*length(stimList)+trialI+10,2}=trialI;
        affData{(blockI-1)*length(stimList)+trialI+10,3}=stimList{trialI,2};
        affData{(blockI-1)*length(stimList)+trialI+10,4}=stimList{trialI,1};
        affData{(blockI-1)*length(stimList)+trialI+10,5}=stimList{trialI,4}; %1=Cong, 2=incong;
        affData{(blockI-1)*length(stimList)+trialI+10,6}=ruleCR;
        affData{(blockI-1)*length(stimList)+trialI+10,7}=resp;
        affData{(blockI-1)*length(stimList)+trialI+10,8}=respAcc;
        affData{(blockI-1)*length(stimList)+trialI+10,9}=RT;
       
        
        %ITI
        pause(jitList(trialI)*speedup) %500ms ITI
        affData{trialI,10}=jitList(trialI);
    end
end

%Save data
cd Data
save(filename,'affData');
cd ..

%End inst.
% Screen(window,'FillRect',black);
% instructions = {'You have reached the end of this task.',...
%     '',...
%     'Thank you very much for your participation.'};
% cenTex(instructions,window,screenRect,white,black,32) % Print text centered
% pause(5*speedup);
Screen(window,'FillRect',black);

% %clear screen
% Screen('CloseAll')

