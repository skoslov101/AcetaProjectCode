function [CESD_output, CESD_score] = CESD(window)

%%% Initialize the screen
% [window, screenRect] = Screen(0,'OpenWindow');
HideCursor;
white = [255 255 255];

% Clear the screen
Screen(window,'FillRect',0); % clear Screen
% Set font size
Screen(window,'TextSize',18);
Screen(window,'TextFont', 'Verdana');	%	Use Verdana because both Macs and PCs have this.

% Initial instructions
Screen(window,'TextSize',18);
Screen(window,'DrawText','CESD Instructions:',300,100,white);
Screen(window,'TextSize',18);
Screen(window,'DrawText','We will be showing you a list of ways you might have felt or behaved. Please',25,200,white);
Screen(window,'DrawText','indicate how often you have felt this way during the last week by pressing the',25,250,white);
Screen(window,'DrawText','number corresponding to the statements that best describes you.',25,300,white);
Screen(window,'DrawText','Please answer every statement, even if you are not completely sure which answer is right for you.',25,400,white);
Screen(window,'DrawText','Press the spacebar to begin.',300,500,white);
        if isequal(computer,'PCWIN64')
            Screen(window,'Flip');
        end

GetResp('space');

% The questions or symptoms
questions = { ...
        'I was bothered by things that usually do not bother me', ...
        'I did not feel like eating; my appetite was poor', ...
        'I felt that I could not shake off the blues even with help from my family or friends', ...
        'I felt that I was just as good as other people', ...
        'I had trouble keeping my mind on what I was doing', ...
        'I felt depressed', ...
        'I felt that everything I did was an effort', ...
        'I felt hopeful about the future', ...
        'I thought my life had been a failure', ...
        'I felt fearful', ...
        'My sleep was restless', ...
        'I was happy', ...
        'I talked less than usual', ...
        'I felt lonely', ...
        'People were unfriendly', ...
        'I enjoyed life', ...
        'I had crying spells', ...
        'I felt sad', ...
        'I felt that people dislike me', ...
        'I could not get "going"',};

% Run the questionnaire (one loop for each question)
for qnum = 1:20
    
    currQuest = questions{qnum};
    Qname = ['Question ' num2str(qnum)];
    
    % Display question, get response
    Screen(window,'FillRect',0); % clear Screen
    Screen(window,'TextSize',20);
    Screen(window,'DrawText',Qname,25,100,white);
    Screen(window,'TextSize',20);
    Screen(window,'DrawText',currQuest,100,250,white);
    
    Screen(window,'TextSize',20);
    Screen(window,'DrawText','1-Rarely or none of the time (less than 1 day).',300,400,white);
    Screen(window,'DrawText','2-Some or a little of the time (1-2 days).',300,450,white);
    Screen(window,'DrawText','3-Occassionally or a moderate amount of time (3-4 days).',300,500,white);
    Screen(window,'DrawText','4-Most or all of the time (5-7 days).',300,550,white);
 
        if isequal(computer,'PCWIN64')
            Screen(window,'Flip');
        end

    resp(qnum) = GetResp('1!','2@','3#','4$');
    
end

% Tally up scores, questions 4 8 12 and 16 are scored reversed. 
CESD_output = resp;
CESD_score = resp(1) + resp(2) + resp(3) + resp(5) + resp(6) + resp(7) +...
resp(9)+ resp(10) + resp(11) + resp(13) + resp(14) + resp(15) + 3-resp(4) + ...
3-resp(8) + 3-resp(12) + 3-resp(16) + resp(17) + resp(18) + resp(19) + resp(20);
% Screen('closeall');




