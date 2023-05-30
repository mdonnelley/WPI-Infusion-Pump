function WPIsetup(currentVol, port, syringe)

% Perform WPI setup
%
% EXAMPLE: WPIsetup(145000, 'COM5', 'H') % Perform setup with 250 ul syringe position set to 145 ul initially

clc;
global WPI;

WPI.syringe = syringe;
WPI.port = port;        % Get this from Windows Device Manager
WPI.channel = 1;        % Set to whichever line used
WPI.pause = 0.01;       % Pause for serial commands (sec)
WPI.logfilename = 'C:\Users\Imaging\Documents\WPI Infusion Pump.log';
WPI.currentVol = currentVol;

% Syringe definitions
switch (WPI.syringe)
    case 'A'                    
        WPI.volume = 500;       % 0.5 ul syringe
        WPI.rate = 20;          % Max delivery and withdrawl rate (nl/sec)
    case 'B'                    
        WPI.volume = 1000;      % 1 ul syringe
        WPI.rate = 40;          % Max delivery and withdrawl rate (nl/sec)
    case 'C'                    
        WPI.volume = 5000;      % 5 ul syringe
        WPI.rate = 202;         % Max delivery and withdrawl rate (nl/sec)
    case 'D'                    
        WPI.volume = 10000;     % 10 ul syringe
        WPI.rate = 406;         % Max delivery and withdrawl rate (nl/sec)
    case 'E'                    
        WPI.volume = 25000;     % 25 ul syringe
        WPI.rate = 1022;        % Max delivery and withdrawl rate (nl/sec)
    case 'F'                    
        WPI.volume = 50000;     % 50 ul syringe
        WPI.rate = 2035;        % Max delivery and withdrawl rate (nl/sec)
    case 'G'                    
        WPI.volume = 100000;    % 100 ul syringe
        WPI.rate = 4088;        % Max delivery and withdrawl rate (nl/sec)
    case 'H'                    
        WPI.volume = 250000;    % 250 ul syringe
        WPI.rate = 9999;        % Max delivery and withdrawl rate (nl/sec)
    case 'I'                    
        WPI.volume = 500000;    % 500 ul syringe
        WPI.rate = 9999;        % Max delivery and withdrawl rate (nl/sec)
    case 'J'                    
        WPI.volume = 1000000;   % 1 ml syringe
        WPI.rate = 9999;        % Max delivery and withdrawl rate (nl/sec)
    otherwise
        error('Syringe Type not defined')
end

WPI.minimum = WPI.volume*0.01;  % Minimum syringe volume before refill (nl)
WPI.maximum = WPI.volume*0.99;  % Maximum syringe vol (nl)

% Close any open COM ports and log files
WPIcleanup;

% Setup the serial port
WPI.serialport = serial(WPI.port,'BaudRate',9600,'DataBits',8, 'StopBits', 1, 'FlowControl', 'none');
fopen(WPI.serialport);
WPI.serialport.ReadAsyncMode = 'manual';
%WPI.serialport = serialport(WPI.port, 9600,'DataBits',8, 'StopBits', 1, 'FlowControl', 'none'); % For new serial protocol
disp(['Opened ',WPI.port,' for WPI communication'])

% Setup the log file
WPI.logfileID = fopen(WPI.logfilename,'a+');
fprintf(WPI.logfileID, ['\n\nWPI Infusion Pump Log ',datestr(now,31),'\n\n']);
disp(['Opened log at ',WPI.logfilename])

% Configure the syringe pump
WPIsendCommand(['L',num2str(WPI.channel),';']); % Select channel
WPIsendCommand('S');                            % Select units nl/sec
WPIsendCommand(['T',WPI.syringe]);              % Select syringe size
WPIsendCommand('N');                            % Set ungrouped mode
WPIsetValue('R',WPI.rate);                      % Set rate

% Reload the syringe
% if(WPI.currentVol < WPI.maximum), WPIwithdraw(WPI.maximum - WPI.currentVol); end