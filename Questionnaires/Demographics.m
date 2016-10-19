function [demoResps] = Demographics(window)
%% Demographics for Aceto Project

%%% Initialize the Screen
% [window, screenRect] = Screen(0,'OpenWindow');
HideCursor;
white = [255 255 255];

% Clear the Screen
Screen(window,'FillRect',0); % clear Screen
% Set font size
Screen(window,'TextSize',32);
Screen(window,'TextFont', 'Verdana');	%	Use Verdana because both Macs and PCs have this.
screenRect= get( 0, 'Screensize' ); 

% Specify color values
white = [255 255 255];
black = [0 0 0];


openInst={'The following are some demographic questions that we would like',...
    'for you to answer.',...
    '',...
    'If you do not feel comfortable answering any of the following questions',...
    'press ENTER to skip the question.',...
    '',...
    'Please press the SPACEBAR to proceed to the demographics questionniare.'};
cenTex(openInst,window,screenRect,white,black,32) % Print text
getResp('space');
Screen(window,'FillRect',black);

%Age
msg={'Please enter your age'};
FlushEvents('keyDown');
demoResps.age=GetEchoString_newLine(window,msg,15,200,white,black);
Screen(window,'FillRect',black);

%Gender
msg={'Please select a gender',...
    '',...
    'Press ''M'' for male',...
    'Press ''F'' for female',...
    'Press ''O'' for other'};
cenTex(msg,window,screenRect,white,black,32) % Print text
gender=getResp('m','f','o','return');
if gender==0
    demoResps.gender='m';
elseif gender==1
    demoResps.gender='f';
elseif gender==2
    demoResps.gender='o';
else
    demoResps.gender='';
end

%Handidness
msg={'Please select your dominant hand',...
    '',...
    'Press ''R'' if you are right handed.',...
    'Press ''L'' if you are left handed.'};
cenTex(msg,window,screenRect,white,black,32) % Print text
hand=getResp('r','l','return');
if hand==0
    demoResps.hand='r';
elseif hand==1
    demoResps.hand='l';
else
    demoResps.hand='';
end

%Race-1
msg={'Please select the race that most applies to you:',...
    '',...
    'Press ''A''                 for American Indian/Alaskan',...
    '',...
    'Press ''S''                                               for Asian',...
    '',...
    'Press ''P''                                for Pacific Islander',...
    '',...
    'Press ''B''                   for Black/African American',...
    '',...
    'Press ''W''                                           for White',...
    '',...
    'Press ''M''                        for More than one race'};
cenTex(msg,window,screenRect,white,black,32) % Print text
race=getResp('a','s','p','b','w','m','return');
if race==0
    demoResps.race='AmericanIndian_Alaskan';
elseif race==1
    demoResps.race='Asian';
elseif race==2
    demoResps.race='PacificIslander';
elseif race==3
    demoResps.race='Black_AfricanAmerican';
elseif race==4
    demoResps.race='White';
elseif race==5
    demoResps.race='MoreThanOne';
else
    demoResps.race='';
end

%Race-2
msg={'Are you of Hispanic orogin, regardless of race?',...
    '',...
    'Please press ''Y'' if yes or press ''N'' if no.'};
cenTex(msg,window,screenRect,white,black,32) % Print text
hisp=getResp('y','n','return');
if hisp==0
    demoResps.hispanic='y';
elseif hand==1
    demoResps.hispanic='n';
else
    demoResps.hispanic='';
end

%English first language
msg={'Is English your first language?',...
    '',...
    'If the answer is YES, press ''Y''',...
    'If the answer is NO, press ''N'''};
cenTex(msg,window,screenRect,white,black,32) % Print text
Eng=getResp('y','n','return');
if Eng==0
    demoResps.English='y';
elseif Eng==1
    demoResps.English='n';
else
    demoResps.English='';
end

%Vision
msg={'Do you have normal (or corrected to normal) vision?',...
    '',...
    'Please press ''Y'' if yes or press ''N'' if no.'};
cenTex(msg,window,screenRect,white,black,32) % Print text
Vis=getResp('y','n','return');
if Vis==0
    demoResps.Vision='y';
elseif Vis==1
    demoResps.Vision='n';
else
    demoResps.Vision='';
end

%ColorBlind
msg={'Are you colorblind?',...
    '',...
    'Please press ''Y'' if yes or press ''N'' if no.'};
cenTex(msg,window,screenRect,white,black,32) % Print text
Vis2=getResp('y','n','return');
if Vis2==0
    demoResps.Colorblind='y';
elseif Vis2==1
    demoResps.Colorblind='n';
else
    demoResps.Colorblind='';
end

%Hearing
msg={'Do you have normal (or corrected to normal) hearing?',...
    '',...
    'Please press ''Y'' if yes or press ''N'' if no.'};
cenTex(msg,window,screenRect,white,black,32) % Print text
Hear=getResp('y','n','return');
if Hear==0
    demoResps.Hearing='y';
elseif Hear==1
    demoResps.Hearing='n';
else
    demoResps.Hearing='';
end
Screen(window,'FillRect',black);

FlushEvents('keyDown');
msg={'Please enter the number of years of education',...
    'that you have completed.  Start with the first year',...
    'of formal education, e.g. kindergarten =1.'};
demoResps.yoe=GetEchoString_newLine(window,msg,15,200,white,black);
Screen(window,'FillRect',black);

endMsg={'Thanks for completing the demographics questionnaire!',...
    '',...
    'Please press the SPACEBAR to continue with the experiment.'};
cenTex(endMsg,window,screenRect,white,black,32) % Print text
getResp('space')
Screen(window,'FillRect',black);


