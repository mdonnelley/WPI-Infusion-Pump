function WPIopen

% Open serial port and logfile

global WPI;

% Setup the serial port
WPI.serialport = serial(WPI.port,'BaudRate',9600,'DataBits',8, 'StopBits', 1, 'FlowControl', 'none');
fopen(WPI.serialport);
WPI.serialport.ReadAsyncMode = 'manual';
disp(['Opened ',WPI.port,' for WPI communication'])

% Setup the log file
WPI.logfileID = fopen(WPI.logfilename,'a+');
fprintf(WPI.logfileID, ['\n\nWPI Infusion Pump Log ',datestr(now,14),'\n\n']);
disp(['Opened log at ',WPI.logfilename])