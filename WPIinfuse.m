function WPIinfuse(vol, time)

% Deliver 'vol' nl every 'time' seconds
%
% EXAMPLE: WPIinfuse(2700, 60); % Deliver 2700 nl once every 60 seconds (a rate of 45 nl/sec)

% Start pump running
while(1),
    tic;
    WPIbolus(vol);
    pause(time - toc);
end