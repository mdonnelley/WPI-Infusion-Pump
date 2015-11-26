function WPIsetup(currentVol)

% Perform WPI setup
%
% EXAMPLE: WPIsetup(35000); % Perform setup with syringe position set to 35 ul initially

global WPI;

% Set WPI parameters
WPI.currentVol = currentVol;    % Initial volume in syringe
WPI.volume = 1500;              % Deliver 1500 nl in each infusion
WPI.interval = 30;              % Deliver every 30 seconds
WPI.rate = 4000;                % Delivery and withdrawl rate (nl/sec)
WPI.port = 'COM11';             % Get this from Windows Device Manager
WPI.channel = 1;                % Set to whichever line used
WPI.syringe = 'G';              % G type = 100 ul Hamilton syringe
WPI.minimum = 20000;            % Minimum syringe volume before refill (nl)
WPI.maximum = 95000;            % Maximum syringe vol: Set based on syringe type (nl)
WPI.pause = 0.01;               % Pause for serial commands (sec)
WPI.logfilename = 'C:\Users\S8 Data Acquisition\Desktop\WPI Infusion Pump.log';

% Close then open any open COM ports and log files
WPIclose;
WPIopen;

% Configure the WPI controller
WPIsendCommand(['L',num2str(WPI.channel),';']); % Select channel
WPIsendCommand('S');                            % Select units nl/sec
WPIsendCommand(['T',WPI.syringe]);              % Select syringe size
WPIsendCommand('N');                            % Set ungrouped mode
WPIsetValue('R',WPI.rate);                      % Set rate

disp('Configuration complete!')

% % Load the syringe
% WPI.currentVol = currentVol;
% disp('Loading syringe ...')
% if(WPI.currentVol < WPI.maximum), WPIwithdraw(WPI.maximum - WPI.currentVol); end