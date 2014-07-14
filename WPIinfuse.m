function WPIinfuse(vol, time)

% WPIinfuse(45, 60)

% Start pump running
while(1),
    tic;
    WPIbolus(vol*time);
    pause(time - toc);
end