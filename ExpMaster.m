%% This is the master program for the Acetaminophen Project
% In order to make sure that the timing of all tasks and programs runs
% smoothly and consistently, this script will run through all of the tasks
% for each participant.  Tasks will be timed and occur in a specified
% order.
clear

%Conditions:
    %DM cond: 1 = RB/House -> II/Vehicle
    %DM cond: 2 = II/House -> RB/Vehicle
    %DM cond: 3 = RB/Vehicle -> II/House
    %DM cond: 4 = II/Vehicle -> RB/House
    
    %I may counterbalance the WM tasks, but I am leaning against it.
    %WM cond: 1 = Stroop -> AffectiveFlanker
    %WM cond: 2 = AffectiveFlanker -> Stroop
    

%% Set up randomization
rand('twister',sum(100*clock));

%% Get input for experiment
% Enter subject data
datainputflag = 0;
while datainputflag ~= 1
    initflag = 0;
    while initflag ~= 1
        prompt = {'Subject Number', 'Subject Initials','CondNum','BottleNumber'};
        name = 'Welcome to the experiment';
        defAns = {'9999','test','0','0'};
        options.Resize = 'on';
        options.WindowStyle = 'normal';
        options.Interpreter = 'tex';
        info = inputdlg(prompt,name,1,defAns,options);
        if isempty(info)
            return
        end
        subjectNum = info{1};
        subjectName = info{2};
        condNum=info{3};
        bottleNum=info{4};

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
        
        condNtest = str2double(condNum);
        if isnan(condNtest)
            condCH = 0;
            condCHerr = 'Condition Number needs to be entered as a number';
        else
            condCHerr = '';
            condCH = 1;
        end
        

        if initCH + subCH + condCH == 3
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
            errorText = {initCHerr, subCHerr, condCHerr};
            uiwait(errordlg(errorText, 'Error!'));
        end
    end


    options.Default='No';
    checkinfo = {'Is the following information correct',...
        '',...
        [pinit ' = Subject`s Initials'],...
        [subjectNum ' = Subject Number'],...
        [condNum ' = Condition Number'],...
        [bottleNum ' = Bottle Number'],...
        };
    check = questdlg(checkinfo,'Is this info correct?','Yes','No',options);
    if strcmpi(check,'Yes')
        datainputflag = 1;
    end
end

subjN=str2double(subjectNum);
init=pinit;
bottleN=str2double(bottleNum);

curDir=pwd;



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

beginBlocks={'Welcome to the experiment!',...
    '',...
    'Today, we will ask you to complete a few different tasks.',...
    'Please make sure to read the instructions carefully for each task.',...
    '',...
    'Please press the SPACEBAR to continue.',...
    ''};
cenTex(beginBlocks,window,screenRect,white,black,24)
if debug~=1
    getResp('space')
    Screen(window,'FillRect',black);
end


%First we have some quick screening questions:
    [screenResps,contVar]=ExpScreening(window);
    quest.screenResps=screenResps;

if contVar==1
    %This is the start of the entire experiment
    timeStart=GetSecs;
    
    filenameTempA=['Aceto_' bottleNum '_' subjectNum '_' pinit '_' condNum '_temp.mat'];
    filenameTemp=[curDir '\tempData\' filenameTempA];

    %Create blank data array
    overallData=cell(7,5);
    affRespKeys=randi(3);
    strRespKeys=randi(3);
    % 
    % % %% Affective flanker 1
    %The first task will be the affective flanker
    overallData{1,1}=subjN;
    overallData{1,2}='AffectiveFlanker1';
    overallData{1,3}=GetSecs-timeStart;
    %Run the task
    cd AffectiveFlanker/
    runNum=1;
    [AffFlank1]=AffectiveFlankerTask(debug,subjN,init,runNum,window,affRespKeys,bottleNum);
    cd ..

    % Thanks and transition
    instructions = {'You have reached the end of Flanker task.',...
        'Thank you very much for your participation.',...
        '',...
        'You may now take a short break.',...
        '',...
        'Please press the SPACEBAR when you are ready',...
        'to continue to the next task.'};
    cenTex(instructions,window,screenRect,white,black,32) % Print text
    save(filenameTemp,'overallData');
    if debug~=1
        getResp('space')
        Screen(window,'FillRect',black);
    end

    %% Stroop Task 1
    overallData{2,1}=subjN;
    overallData{2,2}='Stroop1';
    overallData{2,3}=GetSecs-timeStart;
    %Run stroop
    cd Stroop/
    runNum=1;
    [Stroop1]=ComputerizedStroop(debug,subjN,init,runNum,window,strRespKeys, bottleNum);
    % [Stroop1]=ComputerizedStroop(0,subjN,init,runNum,window);
    cd ..

    % Thanks and transition
    instructions = {'You have reached the end of the Stroop task.',...
        'Thank you very much for your participation.',...
        '',...
        'You may now take a short break.',...
        '',...
        'Please press the SPACEBAR when you are ready',...
        'to continue to the next task.'};
    cenTex(instructions,window,screenRect,white,black,32) % Print text
    if debug~=1
        getResp('space')
    end
    save(filenameTemp,'overallData');
    Screen(window,'FillRect',black);

    %% Questionnaires
    overallData{3,1}=subjN;
    overallData{3,2}='Questionnaires';
    overallData{3,3}=GetSecs-timeStart;

    % Thanks and transition
    instructions = {'We are now going to ask you to answer',...
        'some survey questions.',...
        '',...
        'For this section of the experiment, please respond',...
        'using the keyboard and the numbers on the top of the keyboard.',...
        'You do not need to use the number pad.',...
        '',...
        'Please press the SPACEBAR when you are ready',...
        'to begin with the surveys.'};
    cenTex(instructions,window,screenRect,white,black,32) % Print text
    if debug~=1
        getResp('space')
    end
    Screen(window,'FillRect',black);

     cd Questionnaires\
         %Demographics
        [demoResps]=demographics(window);
        quest.Demographics=demoResps;

        %%%%CESD 
        [CESD_output, CESD_score] = CESD(window); 
        quest.CESD_output = CESD_output; 
        quest.CESD_score = CESD_score;

        %MASQ
        [MASQ_Output, MASQ_GDA, MASQ_AA, MASQ_GDD, MASQ_AD, MASQ_total] = apathy(window);
        quest.MASQ_Output=MASQ_Output;
        quest.MASQ_GDA=MASQ_GDA;
        quest.MASQ_AA=MASQ_AA;
        quest.MASQ_GDD=MASQ_GDD;
        quest.MASQ_AD=MASQ_AD;
        quest.MASQ_total=MASQ_total;

        %PANAS
        [PANAS_responses, PANAS_score_pos, PANAS_score_neg] = PANAS(window);
        quest.PANAS_responses=PANAS_responses;
        quest.PANAS_score_pos=PANAS_score_pos;
        quest.PANAS_score_neg=PANAS_score_neg;

    cd ..



    % Thanks and transition
    instructions = {'You have reached the end of the questionniares.',...
        'Thank you very much for your participation.',...
        '',...
        'You may now take a short break.',...
        '',...
        'Please press the SPACEBAR when you are ready',...
        'to continue to the next task.'};
    cenTex(instructions,window,screenRect,white,black,32) % Print text
    save(filenameTemp,'overallData');
    if debug~=1
        getResp('space')
        Screen(window,'FillRect',black);
    end
    %% Affective flanker 2
    %The first task will be the affective flanker
    overallData{4,1}=subjN;
    overallData{4,2}='AffectiveFlanker2';
    overallData{4,3}=GetSecs-timeStart;
    %Run the task
    cd AffectiveFlanker/
    runNum=2;
    [AffFlank2]=AffectiveFlankerTask(debug,subjN,init,runNum,window,affRespKeys, bottleNum);
    cd ..

    % Thanks and transition
    % Thanks and transition
    instructions = {'You have reached the end of the Flanker task.',...
        'Thank you very much for your participation.',...
        '',...
        'You may now take a short break.',...
        '',...
        'Please press the SPACEBAR when you are ready',...
        'to continue to the next task.'};
    cenTex(instructions,window,screenRect,white,black,32) % Print text
    save(filenameTemp,'overallData');
    if debug~=1
        getResp('space')
        Screen(window,'FillRect',black);
    end
    %% Stroop Task 2
    overallData{5,1}=subjN;
    overallData{5,2}='Stroop2';
    overallData{5,3}=GetSecs-timeStart;
    %Run stroop
    cd Stroop/
    runNum=2;
    [Stroop2]=ComputerizedStroop(debug,subjN,init,runNum,window,strRespKeys, bottleNum);
    cd ..


    %% Make sure that an hour has passed from the beginning of the experiment.
    %Run the timer screen if 60 minutes have not passed.
    sinceStart=GetSecs-timeStart; %Seconds since starting
    %If debug, make wait time 1 minute else time less than 60 minutes
    if debug~=1
        effTime=60; %Total minutes between start and next chunk
    else
        effTime=(sinceStart/60)+1; %Total seconds
    end
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

        sinceStartTxt={'You have reached the end of the Stroop task.',...
            'Thank you very much for your participation.',...
            '',...
            'We want you to take a timed break at this time.',...
            'Your next task will begin in' timeRemNow ' minutes'};
        cenTex(sinceStartTxt,window,rect, white, black, 32);
        t1=toc;
        pause(1-t1);
    end
    save(filenameTemp,'overallData');
    Screen(window,'FillRect',black);


    %Transition to category learning tasks
    instructions = {'We are now going to have you do a couple different tasks.',...
        'Thank you very much for your participation.',...
        '',...
        'Please press the SPACEBAR when you are ready to begin!'};
    cenTex(instructions,window,screenRect,white,black,32) % Print text
    if debug~=1
        getResp('space')
        Screen(window,'FillRect',black);
    end


    %% Category Learning Tasks 1 & 2
    condN=str2double(condNum);
    if condN==1
        rule1N=1;
        feature1N=1;
        rule1Name='RB';
        feature1Name='Vehicle';
        rule2N=2;
        feature2N=2;
        rule2Name='II';
        feature2Name='Houses';
    elseif condN==2
        rule1N=2;
        feature1N=1;
        rule1Name='II';
        feature1Name='Vehicle';
        rule2N=1;
        feature2N=2;
        rule2Name='RB';
        feature2Name='Houses';
    elseif condN==3
        rule1N=1;
        feature1N=2;
        rule1Name='RB';
        feature1Name='Houses';
        rule2N=2;
        feature2N=1;
        rule2Name='II';
        feature2Name='Vehicle';
    else
        rule1N=2;
        feature1N=2;
        rule1Name='II';
        feature1Name='Houses';
        rule2N=1;
        feature2N=1;
        rule2Name='RB';
        feature2Name='Vehicle';
    end


    %Cat Task 1
    overallData{6,1}=subjN;
    overallData{6,2}='Cat1';
    overallData{6,3}=GetSecs-timeStart;
    overallData{6,4}=rule1Name;%Rule Type
    overallData{6,5}=feature1Name;%Feature Type

    cd CategoryLearning\
    orderNum=1;
    if rule1N==1
        [rbdata]=Aceto_150_rb(debug, subjN, init, feature1N, rule1N, orderNum,window, bottleNum);
    else
        [iidata]=Aceto_150_ii(debug, subjN, init, feature1N, rule1N, orderNum,window, bottleNum);
    end

    % Thanks and transition
    instructions = {'You have reached the end of this task.',...
        'Thank you very much for your participation.',...
        '',...
        'You may now take a short break.',...
        '',...
        'Please press the SPACEBAR when you are ready',...
        'to continue to the next task.'};
    cenTex(instructions,window,screenRect,white,black,32) % Print text
    save(filenameTemp,'overallData');
    if debug~=1
        getResp('space')
        Screen(window,'FillRect',black);
    end

    %Category Learning Task 2
    overallData{7,1}=subjN;
    overallData{7,2}='Cat2';
    overallData{7,3}=GetSecs-timeStart;
    overallData{7,4}=rule2Name;%Rule Type
    overallData{7,5}=feature2Name;%Feature Type
    orderNum=2;
    if rule2N==1
        [rbdata]=Aceto_150_rb(debug, subjN, init, feature2N, rule2N, orderNum, window, bottleNum);
    else
        [iidata]=Aceto_150_ii(debug, subjN, init, feature2N, rule2N, orderNum, window, bottleNum);
    end
    cd ..
    % Thanks and transition
    instructions = {'You have reached the end of the experiment!',...
        'Thank you very much for your participation.',...
        '',...
        'You may now tell the researcher that you are completely done.',...
        '',...
        'Thanks again for participating, and have a nice day!'};
    cenTex(instructions,window,screenRect,white,black,32) % Print text
    save(filenameTemp,'overallData');
    if debug~=1
        getResp('esc')
        Screen(window,'FillRect',black);
    end

    subjData.protocol=overallData;
    subjData.stroop1=Stroop1;
    subjData.stroop2=Stroop2;
    subjData.affFlank1=AffFlank1;
    subjData.affFlank2=AffFlank2;
    % subjData.quest=questOutput;
    subjData.catRB=rbdata;
    subjData.catII=iidata;
    subjData.quest=quest;

    cd Data\
    filename=['Aceto_' bottleNum '_' subjectNum '_' pinit '_' condNum '.mat'];
    save(filename,'subjData');
end


Screen('CloseAll');