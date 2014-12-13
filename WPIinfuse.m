function WPIinfuse(vol, time)

% Deliver 'vol' nl every 'time' seconds
%
% EXAMPLE: WPIinfuse(1350, 30); % Deliver 1350 nl once every 30 seconds (a rate of 45 nl/sec)

% Start pump running
while(1),
    tic;
    WPIbolus(vol);
    pause(time - toc);
end