function WPIinfuse

% Deliver 'vol' nl every 'interval' seconds
%
% EXAMPLE: Use WPIinfuse to deliver 1350 nl once every 30 seconds (a rate of 45 nl/sec)

global WPI;

% Start pump running
while(1),
    tic;
    WPIbolus(WPI.volume);
    pause(WPI.interval - toc);
end