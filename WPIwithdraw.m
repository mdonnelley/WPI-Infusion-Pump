function WPIwithdraw(varargin)

% WPIwithdraw(25000)

global WPI;

switch nargin,
    case 1
        vol = varargin{1};
        rate = WPI.rate;
    case 2
        vol = varargin{1};
        rate = varargin{2};
        if rate > WPI.rate,
            rate = WPI.rate;
        end
    otherwise
        error('Function takes either 1 or 2 parameters')
end

% Check if the withdrawl volume is too large for the syringe position
if(vol > WPI.maximum - WPI.currentVol) vol = WPI.maximum - WPI.currentVol; end

% Calculate the number of infusions required
withdrawls = ceil(vol / 99999);
vol = round(vol / withdrawls);

disp([datestr(now,31),' Configuring pump'])
WPIsendCommand('W');
WPIsetValue('V',vol);
WPIsetValue('R',rate);

% Withdraw
for i = 1:withdrawls,

    WPIsetValue('C',0);
    WPIsendCommand('G');
    disp([datestr(now,31),' Withdrawal started'])

    % Wait for the pump to move
    pause(0.25 + vol / rate)

    % Check that the syringe moved correctly
    counter = WPIgetValue('C');
    if(counter / vol > 0.99),
        disp([datestr(now,31),' Withdrawn ', num2str(vol), 'nl at ',num2str(rate), ' nl/sec'])
    else
        warning([datestr(now,31),' ERROR RESETTING SYRINGE'])
    end

    % Adjust the current volume
    WPI.currentVol = WPI.currentVol + vol;
    str = [datestr(now,31),' Volume remaining ',num2str(WPI.currentVol),' nl (', num2str(WPI.maximum - WPI.currentVol), ' nl to capacity)'];
    disp(str)

end