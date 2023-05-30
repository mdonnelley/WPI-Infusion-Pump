function WPIclose

% Close serial port and logfile

global WPI;

% If there is already a COM port associated with matlab then close it
out = instrfind;
if(~isempty(out)), fclose(out); end

% If there are open files then close them
fclose('all');
disp(['Closed ',WPI.port,' and ',WPI.logfilename])