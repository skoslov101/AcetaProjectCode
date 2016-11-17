function [] = cenTex_stroop(txt,window,screenRect,txtcolor,bgcolor,txtsize, respBut)

% CenTex accepts a cell array containing lines of text and prints
% each line, centered on the screen. CenTex will simply fill the background
% with 'bgcolor' and write text in 'txtcolor' according to the 'screenRect'
% variable, which is found using [window, screenRect] =
% Screen(0,'OpenWindow');
%
% 'txt' MUST be in cell array format -- If only one line of text, define
% 'txt' as 'txt={'YOUR TEXT HERE'};
black=[0 0 0];

% Find center of window using 'screenRect'
Xorigin = (screenRect(3)-screenRect(1))/2;
Yorigin = (screenRect(4)-screenRect(2))/2;

Screen(window,'FillRect', bgcolor); % Fill background with backcolor

if respBut==1
    instHere='(7) - RED                (8) - BLUE                (9) - GREEN';
elseif respBut==2
    instHere='(7) - GREEN                (8) - RED                (9) - BLUE';
else
    instHere='(7) - BLUE                (8) - GREEN                (9) - RED';
end

% Write 'txt'
strLength=length(txt); % Determine length of string for centering purposes
for i = 1:strLength % Cycle through character string
    Screen(window,'TextSize',txtsize);
    TextWidth=Screen(window,'TextWidth',txt{i});
    TextHeight= txtsize; % Height of text body, giving 5 pixel buffer between each line of text
    Screen(window,'DrawText',txt{i},Xorigin-TextWidth/2,Yorigin+TextHeight/2,txtcolor);
end

Screen(window,'TextSize',32);
Screen(window,'DrawText',instHere,screenRect(3)*.25,screenRect(2)+100,black);
