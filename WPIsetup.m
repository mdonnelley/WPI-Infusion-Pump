function WPIsetup(currentVol)

% WPIsetup(WPI.currentVol);

clc;
global WPI;

WPI.rate =4000;         % Delivery and withdrawl rate (nl/sec)
WPI.port = 'COM4';      % Get this from Windows Device Manager
WPI.channel = 1;        % Set to whichever line used
WPI.syringe = 'G';      % 100 ul Hamilton syringe
WPI.minimum = 30000;    % Minimum syringe volume before refill (nl)
WPI.maximum = 95000;    % Maximum syringe vol: Set based on syringe type (nl)
WPI.pause = 0.01;       % Pause for serial commands (sec)
WPI.logfilename = 'C:\Users\Martin Donnelley\Desktop\WPI Infusion Pump.log';

% Close any open COM ports and log files
WPIcleanup;

% Setup the serial port
WPI.serialport = serial(WPI.port,'BaudRate',9600,'DataBits',8, 'StopBits', 1, 'FlowControl', 'none');
fopen(WPI.serialport);
WPI.serialport.ReadAsyncMode = 'manual';
disp(['Opened ',WPI.port,' for WPI communication'])

% Setup the log file
WPI.logfileID = fopen(WPI.logfilename,'a+');
fprintf(WPI.logfileID, ['\n\nWPI Infusion Pump Log ',datestr(now,14),'\n\n']);
disp(['Opened log at ',WPI.logfilename])

% Configure the syringe pump
WPIsendCommand(['L',num2str(WPI.channel),';']); % Select channel
WPIsendCommand('S');                            % Select units nl/sec
WPIsendCommand(['T',WPI.syringe]);              % Select syringe size
WPIsendCommand('N');                            % Set ungrouped mode
WPIsetValue('R',WPI.rate);                      % Set rate

% Reload the syringe
WPI.currentVol = currentVol;
if(WPI.currentVol < WPI.maximum), WPIwithdraw(WPI.maximum - WPI.currentVol); end