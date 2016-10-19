function [PANAS_responses, PANAS_score_pos, PANAS_score_neg] = PANAS(window)

% This is the PANAS (Positive and Negative Affect Schedule) adjective checklist
% 20 questions

%%% Initialize the Screen
% [window, screenRect] = Screen(0,'OpenWindow');
HideCursor;
white = [255 255 255];

% Clear the Screen
Screen(window,'FillRect',0); % clear Screen
% Set font size
Screen(window,'TextSize',32);
Screen(window,'TextFont', 'Verdana');	%	Use Verdana because both Macs and PCs have this.

% Initial instructions
Screen(window,'TextSize',32);
Screen(window,'DrawText','PANAS Instructions:',300,100,white);
Screen(window,'TextSize',24);
Screen(window,'DrawText','This scale consists of a number of words that describe different',25,250,white);
Screen(window,'DrawText','feelings and emotions. Read each item and press the appropriate',25,300,white);
Screen(window,'DrawText','number key. Indicate to what extent you feel this way CURRENTLY.',25,350,white);
Screen(window,'DrawText','Press the spacebar to begin',300,450,white);
if isequal(computer,'PCWIN64')
    Screen(window,'Flip');
end
GetResp('space');

% The questions or symptoms
questions = { ...
        'Interested', ...
        'Distressed', ...
        'Excited', ...
        'Upset', ...
        'Strong', ...
        'Guilty', ...
        'Scared', ...
        'Hostile', ...
        'Enthusiastic', ...
        'Proud', ...
        'Irritable', ...
        'Alert', ...
        'Ashamed', ...
        'Inspired', ...
        'Nervous', ...
        'Determined', ...
        'Attentive', ...
        'Jittery', ...
        'Active', ...
        'Afraid'};
numberOfItems = 20;


% Run the questionnaire (one loop for each question)
for qnum = 1:numberOfItems
    
    currQuest = questions{qnum};
    Qname = ['Question ' num2str(qnum)];
    
    % Display question, get response
    Screen(window,'FillRect',0); % clear Screen
    Screen(window,'TextSize',24);
    Screen(window,'DrawText',Qname,25,100,white);
    Screen(window,'TextSize',32);
    Screen(window,'DrawText',currQuest,100,250,white);
    
    Screen(window,'TextSize',24);
    Screen(window,'DrawText','1',75,400,white);
    Screen(window,'DrawText','Very slightly',10,450,white);
    Screen(window,'DrawText','or not at all',10,480,white);
    
    Screen(window,'TextSize',24);
    Screen(window,'DrawText','2',260,400,white);
    Screen(window,'DrawText','A little',220,450,white);
    
    Screen(window,'TextSize',24);
    Screen(window,'DrawText','3',450,400,white);
    Screen(window,'DrawText','Moderately',375,450,white);
    
    Screen(window,'TextSize',24);
    Screen(window,'DrawText','4',650,400,white);
    Screen(window,'DrawText','Quite a bit',600,450,white);
    
    Screen(window,'TextSize',24);
    Screen(window,'DrawText','5',850,400,white);
    Screen(window,'DrawText','Extremely',800,450,white);
    
    if isequal(computer,'PCWIN64')
        Screen(window,'Flip');
    end
    
    resp(qnum) = GetResp('1!','2@','3#','4$','5%')+1;
    
end

% Tally up scores, get Prom and Prev score
PANAS_responses = resp;
PANAS_score_pos = resp(1) + resp(3) + resp(5) + resp(9) + resp(10) + resp(12) + resp(14) + resp(16) + resp(17) + resp(19);
PANAS_score_neg = resp(2) + resp(4) + resp(6) + resp(7) + resp(8)  + resp(11) + resp(13) + resp(15) + resp(18) + resp(20);

% Screen('closeall');




