function [resp,contVar] = ExpScreening(window)
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


openInst={'We would like to ask you some quick questions before starting the experiment.',...
    '',...
    'It is important that you answer the questions honestly.',...
    '',...
    'Please press the SPACEBAR to proceed to the questions.'};
cenTex(openInst,window,screenRect,white,black,32) % Print text
getResp('space');
Screen(window,'FillRect',black);

questions = { ...
        'Are you currently pregnant?', ...
        'Do you have a history of seizures, epilepsy, or neurocognitive impairment?', ...
        'Are you currently taking any drugs containing acetaminophen? (Nyquil, Sudafed, etc...)', ...
        'Have you ever had a liver disorder?', ...
        'Do you have an allergic reaction to acetaminophen?', ...
        'Do you have a history of alcohol dependence?',...
        'Are you currently taking anti-seizure or anti-tuberculosis drugs?',...
        'Have you had anything to eat in the past 3 hours?',...
        'Have you have 2 drinks or more since yesterday afternoon?'};
    
    % Run the questionnaire (one loop for each question)
for qnum = 1:length(questions)
    
    currQuest = questions{qnum};
    Qname = ['Question ' num2str(qnum)];
    
    % Display question, get response
    Screen(window,'FillRect',0); % clear Screen
    Screen(window,'TextSize',20);
    Screen(window,'DrawText',Qname,25,100,white);
    Screen(window,'TextSize',20);
    Screen(window,'DrawText',currQuest,100,250,white);
    
    Screen(window,'TextSize',20);
    Screen(window,'DrawText','1 - Yes',300,400,white);
    Screen(window,'DrawText','2 - No',300,450,white);
    
    resp(qnum) = GetResp('1!','2@');
    
end

eligSum=sum(resp(1:7));
reschSum=sum(resp(8:9));

if eligSum<7
    contVar=1;
    taskInst={'Please let the researcher know that you are ready to begin the experiment.',...
    '',...
    'For the researcher:',...
    'This subject will be in condition 5'};
    cenTex(taskInst,window,screenRect,white,black,32) % Print text
    getResp('return');
    Screen(window,'FillRect',black);
elseif reschSum<2
    contVar=0;
    thisInst={'Due to either eating or drinking after the allowed times,',...
        'you are not eligible to participate in the study at this time.',...
        '',...
        'Please see the researcher to reschedule or cancel your',...
        'participation in this study.'};
    cenTex(thisInst,window,screenRect,white,black,32) % Print text
    getResp('return');
    Screen(window,'FillRect',black);
else
    contVar=1;
    thisInst={'Please let the researcher know that you are ready',...
        'to begin the experiment'};
    cenTex(thisInst,window,screenRect,white,black,32) % Print text
    getResp('return');
    Screen(window,'FillRect',black);
end
    
% cenText({'Click to allow the participant to begin the task!'});
% getResp('return');
% Screen(window,'FillRect',black);
    