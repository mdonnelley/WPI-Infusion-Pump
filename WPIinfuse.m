function WPIinfuse(vol, time)

% Deliver 'vol' nl every 'time' seconds
%
% Typical dosing for rats and mice is 0.1 ul/g/min when using a 1:10
% dilution of 64.8 mg/ml Nembutal. This dose is equivalent to 6.48
% ug/g/min Nembutal.
%
% For a 27 gram mouse the dose rate is 2.7 ul/min, or 2700 nl/min. To
% deliver this in 30 sec blocks use the command:
%
% WPIinfuse(1350, 30); 
% 

% Start pump running
while(1),
    tic;
    WPIbolus(vol);
    pause(time - toc);
end