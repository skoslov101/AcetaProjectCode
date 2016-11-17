function [rbdata] = Aceto_150_rb(debug, subjN, init, featNum, ruleNum, orderNum, window, bottleNum)

%% Experiment Parameter List/Cheatsheet
%Features
    %1= Trucks
    %2= Houses
    %3= Planets (I think this one is not the best/harder than others)
    %4= Insects
    %5= Flowers
    %6= Dragons
    %7= Dragons-10dim

%Conditions
    %1= RB Unidimensional

%% Set up the experiment parameters
if debug==1;speedup=1/100;else speedup=1;end % Speed up delays if in debug mode

% % Open window if window doesn't exist
% if ~exist('window','var')
%     [window, screenRect] = Screen(0,'OpenWindow');
%     HideCursor;
% else
%     [window, screenRect]=Screen(0,'OpenWindow'); 
% end


maxTrials=150;
% ruleCount=10;
% numRules=2;

% dims=Shuffle([1,2,3,4]); %Enter the number of dimensions
% dRule1=dims(1); %Use the first number of that shuffled list for the first rule dimension
% dRule2=dims(2); %Use the second number of that same shuffled list for the second rule dimension



% Specify color values
white = [255 255 255];
gray = [128 128 128];
black = [0 0 0];
green = [0 255/2 0];

% Define screen parameters
%When this experiment was created, experiment computers were 1280 x 1024
% rect = screenRect;
% Xorigin = (rect(3)-rect(1))/2; %X Center of screen
% Yorigin = (rect(4)-rect(2))/2; %Y Center of screen
rect = get( 0, 'Screensize' ); 
screenRect=get(0,'Screensize');
Xorigin = rect(3)/2; %X Center of screen
Yorigin = rect(4)/2; %Y Center of screen
xSize = rect(3); %length of the x-dim of the screen
ySize = rect(4); %length of the y-dim of the screen

%Set penWidth for drawing lines and objects
penWidth=.01*xSize;

%% -----------------------------------------------------------------------
%% Set the parameter for screen objects
%% -----------------------------------------------------------------------
%% Set the parameter for screen objects
%Set the box for the point meter
% pointX1=.75*xSize; %Right edge of the point meter
% pointX2=.9*xSize; %Left edge of the point meter
% pointY1= .1*ySize; %Top of the point meter
% pointY2=.9*ySize; %Bottom of the point meter
% rewLine=; %count up to 10 correct decisions in a row
% pointYMid=.7*ySize; %This is where points will start to fill up from for the 10 correct in a row count.
% points=(.8*ySize)/10; %Amount of pixels that should fill up everytime there is a correct response.
% pixXAdjust=.02*xSize;
% pixYAdjust=.02*ySize;
% lineX1=pointX1-pixXAdjust;
% lineX2=pointX2+pixXAdjust;
% pointMY1=pointY2;


%Set the text for the point meter
SCREEN(window,'TextSize',32);
textAdjust = .04*xSize;
% zX1=pointX2+textAdjust;
% zY1=pointY2;
% zY2=pointY1;
% numCorr=0;
% Screen(window,'DrawText',mat2str(numCorr),zX1,zY1,black);
% Screen(window,'DrawText',mat2str(ruleCount),zX1,zY2,black);

%Blink Stuff
% blinkAdj=(.01*xSize)+.0016*xSize; %Makes the blinking look nice inside of the point meter

%% Set up the image display box
%This will be slightly to the left of center of the screen.
imgX1=.1*xSize;
imgX2=.9*xSize;
imgY1=.2*ySize;
imgY2=.8*ySize;

cenImgX=.5*xSize;
cenImgY=.5*ySize;
%Set up text for those same things
%Upper text
SCREEN(window,'TextSize',32);
texX1=imgX1;
texY1=.15*ySize;
%Lower text
texX2=imgX1;
texY2=.85*ySize;

% Screen(window,'DrawText',imgText1,texX1,texY1,black);
% Screen(window,'DrawText',imgText2,texX2,texY2,black);



%% Load and Randomize Stimuli
if featNum==1
    %Load Image Info
    imgF='S:\Experiments\AcetoProject\CategoryLearning\TruckStim\';
    allImages=ls('TruckStim');
    imgText1='Which Maker made this vehicle?';
    imgText2='(S) = Maker 1              (L) = Maker 2';
elseif featNum==2
    imgF='S:\Experiments\AcetoProject\CategoryLearning\HouseStim\';
    allImages=ls('HouseStim');
    imgText1='Which neighborhood is this house from?';
    imgText2='(S) = Neighborhood 1         (L) = Neighborhood 2';
end
% elseif featNum==3
%     imgF='S:\Experiments\BinCat_MATLAB\PlanetStim\';
%     allImages=ls('PlanetStim');
%     imgText1='Which galaxy is the planet from?';
%     imgText2='(S) = Andromeda Galaxy        (L) = Starburst Galaxy';
% elseif featNum==4
%     imgF='S:\Experiments\BinCat_MATLAB\InsectStim\';
%     allImages=ls('InsectStim');
%     imgText1='Which species is the insect from?';
%     imgText2='(S) = Species 1        (L) = Species 2';
% elseif featNum==5
%     imgF='S:\Experiments\BinCat_MATLAB\FlowerStim\';
%     allImages=ls('FlowerStim');
%     imgText1='Which florist is the flower from?';
%     imgText2='(S) = Florist 1        (L) = Florist 2';
% elseif featNum==6
%     imgF='S:\Experiments\BinCat_MATLAB\DragonStim\';
%     allImages=ls('DragonStim');
%     imgText1='Which species is the dragon from?';
%     imgText2='(S) = Species 1        (L) = Species 2';
% else
%     imgF='S:\Experiments\BinCat_MATLAB\AnimalStims_2\';
%     allImages=ls('AnimalStims_2');
%     imgText1='Which species is the dragon from?';
%     imgText2='(S) = Species 1        (L) = Species 2';
% end

%Next make the list good for a Matlab array to use and draw from.
cd(imgF);
stimObj=dir('*.jpg');

for stimI=1:size(stimObj,1)
    stims{stimI,1}=stimObj(stimI).name;
end

cd ..
% 
% %Next make the list good for a Matlab array to use and draw from.
% [rowS,colS]=size(allImages);
% 
% n=3;
% for i=1:(rowS-2);
%     stims{i,1}=strtrim(allImages(n,:));
%     n=n+1;
% end
% %Delete extraneous things from the array
% delThumbs=find(strcmpi('Thumbs.db', stims(:,:))==1);
% if isempty(delThumbs)==0
%     stims(delThumbs)=[];
% end
% 
% delDS=find(strcmpi('.DS_Store',stims(:,:))==1);
% if isempty(delDS)==0
%     stims(delDS)=[];
% end

%Randomize the stimulus order to start out
stims=Shuffle(stims);
% clear i
% clear n

sCats=Shuffle([1,2]);
%Assign Category Labels for RB categories
if ruleNum==1 %Uni Rule Switching
    ruleDimension=1;
    for i=1:length(stims)
        %Rule for dim 1
        if strcmpi(stims{i,1}(1),'0')==1
            stims{i,2}=sCats(1);
        else
            stims{i,2}=sCats(2);
        end
        %Rule for dim 2
        if strcmpi(stims{i,1}(2),'0')==1
            stims{i,3}=sCats(1);
        else
            stims{i,3}=sCats(2);
        end
        %Rule for dim 3
        if strcmpi(stims{i,1}(3),'0')==1
            stims{i,4}=sCats(1);
        else
            stims{i,4}=sCats(2);
        end
        %Rule for dim 4
        if strcmpi(stims{i,1}(4),'0')==1
            stims{i,5}=sCats(1);
        else
            stims{i,5}=sCats(2);
        end
    end
end

%I want to use the same "random" order of rules for every subject.  So I'm
%going to randomize once and have it stay in this order for the entire run.
% The most rules possible is 15.
ruleNums=[3,1,2,4,2,3,4,1,4,2,3,1,2,1,3,4];


%% Present Instructions
%Present the correct instructions for each surface feature
if featNum==1
    instructions = {'Welcome!',...
        'Recently a new shipment of construction vehicles has been mixed up',...
        'at the dealership.  As the newest employee at the dealership,',...
        'it is your job to separate the construction vehicles by maker',...
        'to ensure that the costumers can find what they need.',...
        '',...
        'Please do your best to get sort each vehicle by maker.',...
        'The success of the dealership is in your hands!',...
        '',...
        'Press the SPACE BAR to continue with the instructions.'};
    cenTex(instructions,window,screenRect,white,black,24) % Print text centered
    if debug~=1;getResp('space');end; % Wait for user to press 'space bar'; 


    instructions = {'After you sort the items you will be told',...
        'whether your response was ''Correct'' or ''Incorrect''',...
        '',...
        'If you feel that the vehicle was made by maker 1, press the ''s'' key.',...
        'If you feel that the vehicle was made by maker 2, press the ''l'' key.',...
        '',...
        'At first you may be guessing, but as you go along',...
        'your accuracy should improve!',...
        '',...
        'Press the SPACE BAR to continue.'};

    cenTex(instructions,window,screenRect,white,black,24) % Print text centered
    if debug~=1;getResp('space');end; % Wait for user to press 'space bar';
    Screen(window,'FillRect',white);
elseif featNum==2
    instructions = {'Welcome!',...
        'Recently the plans for several homes were mixed',...
        'up at the developer''s office.',...
        '',...
        'As the newest employee at the development company,',...
        'it is your job to separate the homes by neighborhood',...
        'to ensure that the customers can find what they need.',...
        '',...
        '',...
        'Please do your best to get sort each home by neighborhood.',...
        'The success of the development company is in your hands!',...
        '',...
        'Press the SPACE BAR to continue with the instructions.'};
    cenTex(instructions,window,screenRect,white,black,24) % Print text centered
    if debug~=1;getResp('space');end; % Wait for user to press 'space bar'; 


    instructions = {'After you sort the items you will be told',...
        'whether your response was ''Correct'' or ''Incorrect''',...
        '',...
        'If you feel that the house belongs to neighborhood 1, press the ''s'' key.',...
        'If you feel that the house belongs in neighborhood 2, press the ''l'' key.',...
        '',...
        'At first you may be guessing, but as you go along',...
        'your accuracy should improve!',...
        '',...
        'Press the SPACE BAR to continue.'};

    cenTex(instructions,window,screenRect,white,black,24) % Print text centered
    if debug~=1;getResp('space');end; % Wait for user to press 'space bar';
    Screen(window,'FillRect',white);
end

%% -----------------------------------------------------------------------
%% Begin Experiment
%% -----------------------------------------------------------------------
%% Display the point meter and image box
% Screen(window,'FrameRect',black,[pointX1 pointY1 pointX2 pointY2],penWidth); %Draw point bar
% Screen(window,'DrawLine',black,lineX1, pointYMid, lineX2, pointYMid, (penWidth/2));
Screen(window,'FrameRect',black,[imgX1 imgY1 imgX2 imgY2], penWidth); %Draw point bar
%Image Text/Question
Screen(window,'TextSize',32);
Screen(window,'DrawText',imgText1,texX1,texY1,black);
Screen(window,'DrawText',imgText2,texX2,texY2,black);
%Point Meter Text
% Screen(window,'TextSize', 32);
% Screen(window,'DrawText',mat2str(numCorr),zX1,zY1,black);
% Screen(window,'DrawText',mat2str(ruleCount),zX1,zY2,black);
%Display Screen Elements
% % Display the point meter and image box
% Screen(window,'FrameRect',black,[pointX1 pointY1 pointX2 pointY2],penWidth); %Draw point bar
% Screen(window,'FrameRect',black,[imgX1 imgY1 imgX2 imgY2], penWidth); %Draw point bar
pause(1) %Pause 1s between instructions and the first stimulus

%Set up initial experiment params
trialN=0;
stimN=0;
ruleN=1;
countN=0;




%Start the first trial
for i=1:150
% for i=1:30
    if i==1
        Screen(window,'FillRect',white);

        %Clear Screen and Redisplay elements in case of mishaps
        % Display the point meter and image box
%         Screen(window,'FrameRect',black,[pointX1 pointY1 pointX2 pointY2],penWidth); %Draw point bar
        Screen(window,'FrameRect',black,[imgX1 imgY1 imgX2 imgY2], penWidth); %Draw point bar
        %Image Text/Question
        Screen(window,'TextSize',32);
        Screen(window,'DrawText',imgText1,texX1,texY1,black); %Question above the image
        Screen(window,'DrawText',imgText2,texX2,texY2,black); %Question below the image
        %Point Meter Text
%         Screen(window,'TextSize', 32);
%         Screen(window,'FillRect',black,[(pointX1+blinkAdj) (pointY2-blinkAdj) (pointX2-blinkAdj) pointMY1]);
%         Screen(window,'DrawText',mat2str(numCorr),zX1,pointMY1,black);
%         Screen(window,'DrawText',mat2str(ruleCount),zX1,pointY1,black);
    end
    
    stimN=stimN+1; %Use this to cycle through stims, without replacement, but without needing to delete anything from a list
    trialN=trialN+1; %Use this to cycle through trials
    
    %% Display Stim Image
    %Set the image string name
    imgName=stims{stimN,1};
    imgStr=[imgF imgName];
    %Get the image information
    ruleCR=stims{stimN,ruleNums(ruleN)+1};

    
    %Do the actual loading of the image file
    img=imread(imgStr,'jpg');
    [w, h, null] = size(img);
    hs = h/3;
    ws = w/3;
    %Place the image on the screen
    loc = [cenImgX - ws, cenImgY-hs, cenImgX+ws, cenImgY+hs];
    Screen(window,'PutImage',img,loc)
    
    %Collect a response
    %if debug~=1;[rawResponse, RT] = getResp('s','l');else rawResponse=randi(2)-1;RT=2*rand(1);end
    if debug~=1
        [rawResponse, RT] = getResp('s','l');
    else
        
        rawResponse=ruleCR-1;
        RT=2*rand(1);
    end
    Screen(window,'FillRect', white, loc); %Clear image following response (to display feedback)
    resp=rawResponse+1;
    
%     if ruleNum==1
%         ruleCR=rule1CR;
%         ruleDimension=dRule1;
%     else
%         ruleCR=rule2CR;
%         ruleDimension=dRule2;
%     end
    
    %Display Feedback
    if resp==ruleCR
        acc=1;
        countN=countN+1;
        Screen(window,'DrawText','Correct',(cenImgX-(textAdjust)),cenImgY,black);
        if countN>=10
            ruleN=ruleN+1;
        end
    else
        acc=0;
        countN=0;
        Screen(window,'DrawText','Incorrect',(cenImgX-(textAdjust)),cenImgY,black);
    end
    pause(1*speedup);
    
%     if acc==1
%         Screen(window,'DrawText',mat2str(numCorr),zX1,pointMY1, white); %Erase the old correct in a row number
%         numCorr=numCorr+1;
%         pointMY1=pointMY1-points;
%         Screen(window,'DrawText',mat2str(numCorr),zX1,pointMY1,black);
%         Screen(window,'FillRect',black,[(pointX1+blinkAdj) (pointY2-blinkAdj) (pointX2-blinkAdj) (pointMY1+blinkAdj)]);
%         pause(.2)
%         Screen(window,'FillRect',white,[(pointX1+blinkAdj) (pointY2-blinkAdj) (pointX2-blinkAdj) (pointMY1+blinkAdj)]);
%         pause(.2)
%         Screen(window,'FillRect',black,[(pointX1+blinkAdj) (pointY2-blinkAdj) (pointX2-blinkAdj) (pointMY1+blinkAdj)]);
%         pause(.6) %pause for feedback
%         Screen(window,'FillRect', white, loc); %Clear feedback
%     else
%         Screen(window,'DrawText',mat2str(numCorr),zX1,pointMY1, white); %Erase the old correct in a row number
%         Screen(window,'FillRect',white,[(pointX1+blinkAdj) (pointY2-blinkAdj) (pointX2-blinkAdj) (pointMY1-blinkAdj)]); %Erase the progress bar
%         pointMY1=pointY2;
%         numCorr=0;
%         Screen(window,'DrawText',mat2str(numCorr),zX1,pointMY1, black); %Draw the new number correct (0)
%         pause(1);
%         Screen(window,'FillRect', white, loc); %Clear Feedback
%     end
    
    %Check to see if rule goal has been reached, and if so, end
    %loop/experiment
%     if countN==10
%         ruleN=ruleN+1;
%     end
    
    % Calculations to recycle stimuli list
    if rem(trialN,16)==0
        stims=stims(randperm(length(stims)),:);
        stimN=0;
    end
    
    rbdata{i,1}=i; %Trial Number
    rbdata{i,2}=imgName; %Stimulus
    rbdata{i,3}=ruleCR; %Correct response on that trial
    rbdata{i,4}=resp; %Response
    rbdata{i,5}=RT; %Response Time
    rbdata{i,6}=acc; %Accuracy on that trial
%     rbdata{i,7}=ruleN; %How many rules have been successfully completed
    rbdata{i,7}=countN; %How many trials in a row correct at this point
    if countN>=10
        countN=0;
    end
    rbdata{i,8}=ruleDimension; %Which dimension was important for categorization during that trial
    rbdata{i,9}=ruleNums(ruleN); %Which rule is the subject on
    rbdata{i,10}=ruleN; %How many rules solved
%     rbdata{i,10}=rule1CR; %First rule CR for looking at perseverative errors when finding second rule

%     if countN==10
%         countN=0;
% %         ruleN=ruleN+1;
%         numCorr=0;
%         %Blink Green for hitting the goal and then start over
%         Screen(window,'FillRect',black,[(pointX1+blinkAdj) (pointY2-blinkAdj) (pointX2-blinkAdj) (pointMY1+blinkAdj)]);
%         Screen(window,'DrawText','Great Job!',(cenImgX-(textAdjust)),cenImgY,black);
%         pause(.2)
%         Screen(window,'FillRect',green,[(pointX1+blinkAdj) (pointY2-blinkAdj) (pointX2-blinkAdj) (pointMY1+blinkAdj)]);
%         Screen(window,'FillRect', white, loc); %Clear Feedback
%         pause(.2)
%         Screen(window,'DrawText','Great Job!',(cenImgX-(textAdjust)),cenImgY,black);
%         Screen(window,'FillRect',black,[(pointX1+blinkAdj) (pointY2-blinkAdj) (pointX2-blinkAdj) (pointMY1+blinkAdj)]);
%         pause(.2)
%         Screen(window,'FillRect', white, loc); %Clear Feedback
%         Screen(window,'FillRect',green,[(pointX1+blinkAdj) (pointY2-blinkAdj) (pointX2-blinkAdj) (pointMY1+blinkAdj)]);
%         pause(.2)
%         Screen(window,'DrawText','Great Job!',(cenImgX-(textAdjust)),cenImgY,black);
%         Screen(window,'FillRect',black,[(pointX1+blinkAdj) (pointY2-blinkAdj) (pointX2-blinkAdj) (pointMY1+blinkAdj)]);
%         pause(.2)
%         Screen(window,'FillRect',green,[(pointX1+blinkAdj) (pointY2-blinkAdj) (pointX2-blinkAdj) (pointMY1+blinkAdj)]);
%         pause(3)
%         Screen(window,'FillRect',white,[(pointX1+blinkAdj) (pointY2-blinkAdj) (pointX2-blinkAdj) (pointMY1+blinkAdj)]);
%         pointMY1=pointY2;
%     end
    
%     if ruleN>=numRules
%         break
%     end
       
    %Clear Screen and Redisplay elements in case of mishaps
    % Display the point meter and image box
%     Screen(window,'FrameRect',black,[pointX1 pointY1 pointX2 pointY2],penWidth); %Draw point bar
    Screen(window,'FrameRect',black,[imgX1 imgY1 imgX2 imgY2], penWidth); %Draw image box
    %Image Text/Question
    Screen(window,'TextSize',32);
    Screen(window,'DrawText',imgText1,texX1,texY1,black); %Question above the image
    Screen(window,'DrawText',imgText2,texX2,texY2,black); %Question below the image
    pause(.5*speedup)
    %Point Meter Text
%     Screen(window,'TextSize', 32);
%     Screen(window,'FillRect',black,[(pointX1+blinkAdj) (pointY2-blinkAdj) (pointX2-blinkAdj) pointMY1]);
%     Screen(window,'DrawText',mat2str(numCorr),zX1,pointMY1,black);
%     Screen(window,'DrawText',mat2str(ruleCount),zX1,pointY1,black);
end

cenTex({'+'},window,screenRect,white,black,24) % Print text centered
pause(1)
Screen(window,'FillRect',black);
% instructions = {'You have reached the end of the experiment.',...
%     '',...
%     'Thank you very much for your participation.',...
%     '',...
%     'We would like to just ask you a question about how you .'};
% cenTex(instructions,window,screenRect,white,black,32) % Print text centered


%     cenTex3({''},window,screenRect,colors.black,white,32) % Display fixation cross
% if debug==1
%     FlushEvents('keyDown');
%     quest1 = {'You are done with the task!',...
%     '',...
%     'During this task, what strategy did you use to categorize the images?',...
%     '',...
%     'Please do your best to summarize any strategies you employed at different times: ',...
%     '',...
%     '',...
%     ''};
%     [Response,string]=getTextResponses_2(window, quest1,Xorigin-Xorigin/1.2,Yorigin, white, black,screenRect);
% end
% 
% rbdata{151,1}=Response;


%% Store the data
filename=['Cat_rb_' bottleNum '_' mat2str(subjN) '_' init '_' mat2str(orderNum) '.mat'];
cd Data
save(filename,'rbdata');
cd ..
%% This is where the responses are collected.

% FlushEvents('keyDown');
% msg='What strategy did you use?: ';
% string = GetEchoString_newLine(window,msg,15,200,white,black);
% rbdata{151,1}=string;

% 
% instructions = {'You have reached the end of the experiment.',...
%     '',...
%     'Thank you very much for your participation.',...
%     '',...
%     'Please tell the experimenter that you are done.'};
% cenTex(instructions,window,screenRect,white,black,32) % Print text centered
% 
% getResp('Esc'); % Wait for experimenter to press 'Esc'
%Say thanks and end the experiment
% Screen('CloseAll');

%Fill the remaining rows of 'data' in with zeros for easier analysis later?



