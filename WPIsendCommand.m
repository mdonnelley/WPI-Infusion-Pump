function response = WPIsendCommand(command)

% WPIsendCommand('I');      % Infuse
% WPIsendCommand('W');      % Withdraw
% WPIsendCommand('G');      % Go
% WPIsendCommand('H');      % Halt
% WPIsendCommand('S');      % Set units to nl/sec
% WPIsendCommand('M');      % Set units to nl/min
% WPIsendCommand('L1;')     % Set line number
% WPIsendCommand('N');      % Non grouped mode
% WPIsendCommand('P');      % Grouped mode
% WPIsendCommand('D');      % Disabled mode
% WPIsendCommand('TG');     % Syringe type

global WPI;
pause(WPI.pause);
readasync(WPI.serialport);
fprintf(WPI.serialport,command);
response=fgetl(WPI.serialport);
pause(WPI.pause);