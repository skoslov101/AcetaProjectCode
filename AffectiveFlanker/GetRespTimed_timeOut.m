function varargout = GetRespTimed_timeOut(varargin)

%function varargout = GetResp(varargin)
%	If no variables are supplied as input, then no variables are supplied as output.
%		The function simply returns [RT].
%	If characters are supplied as input then the output is [Response, RT]
%		E.g.  For GetResp('z', 'x', 'n'), Response is
%			0 if 'z' was pressed, 
%			1 if 'x' is pressed, or
%			2 if 'n' is pressed.
%		E.g.  For GetResp('x', 'n', ... N), Response is 
%			0 if 'x' was pressed,
%			1 if 'n' was pressed, or
%			N-1 if character N is pressed.
%	Regardless of the input, if the escape sequence is detected, then Response is set to -1.
%		The escape sequence (defined in EscapeSequence.m) is usually to
%		press "Q", release, then press "P" within 500 msec of the release of "Q".

% modified to terminate after time_terminate seconds
% 03-29-07
% bdg
%
%****************************************************
%   returns -2 if time elapsed without a key press
%****************************************************
%
%
% examples:
% 
% [raw_response, rt] = getRespTimed(2)              --> will wait for any key, then terminate after 2 seconds
% [raw_response, rt] = getRespTimed('Z','/?',5)     --> will wait for Z or /?, then terminate after 5 seconds
% [raw_response, rt] = getRespTimed                 --> DO NOT DO THIS! IT WILL SPLODE.
%

time_terminate = varargin{length(varargin)};

if(length(varargin)==1)
    anyKeyBool = 1;
else
    anyKeyBool = 0;
end

for i = 1:length(varargin)-1
    varargin_keys{i} = varargin{i};
end

beginTime = GetSecs;
responded = 0;
time_spanned = 0;
while ~responded
    [keyIsDown,secs,keyCode] = KbCheck;
    lastKey = keyCode;
    while keyIsDown, [keyIsDown,secs,keyCode] = KbCheck; end;
    while ~keyIsDown && (time_spanned < time_terminate)
        time_spanned = GetSecs-beginTime;
        [keyIsDown,secs,keyCode] = KbCheck;
        lastKey = keyCode;
    end
    key = KbName(lastKey);
    if EscapeSequence(key)
        responded = 1;
        varargout = {-1, GetSecs-beginTime};
    elseif anyKeyBool
        responded = 1;
        if length(key) == 0
            varargout = {-2, GetSecs-beginTime};
        else
            varargout = {key, GetSecs-beginTime};
        end
    elseif length(key) == 0        
        responded = 1;
        varargout = {-2,time_terminate};
    else
        for i = 1:length(varargin_keys)
            if isequal(upper(key), upper(varargin_keys{i}))
                responded = 1;
                varargout = {i-1, GetSecs-beginTime};
            end
        end
    end
end
        
[keyIsDown,secs,keyCode] = KbCheck;
while keyIsDown, [keyIsDown,secs,keyCode] = KbCheck; end;