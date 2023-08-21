function WPIbolus(varargin)

% Deliver a 'vol' nl bolus
%
% EXAMPLE: WPIbolus(25000); % Deliver a 25 ul bolus a max infusion rate
% EXAMPLE: WPIbolus(25000, 1000); % Deliver a 25 ul bolus at 1 ul/sec

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

% Check if the infusion volume is too large for the syringe position
if(vol > WPI.maximum - WPI.minimum) error(['Maximum delivery volume is ' num2str(WPI.maximum - WPI.minimum), ' nl for this syringe!']); end

% If the volume in the syringe is insufficient then withdraw / error
% if(WPI.currentVol - vol < WPI.minimum) WPIwithdraw(WPI.maximum - WPI.currentVol); end
if(WPI.currentVol - vol < WPI.minimum) error('Insufficient volume remaining in syringe'); end

% Calculate the number of infusions required
infusions = ceil(vol / 99999);
vol = round(vol / infusions);

disp([datestr(now,31),' Configuring pump'])
WPIsendCommand('I');
WPIsetValue('V',vol);
WPIsetValue('R',rate);

% Infuse
for i = 1:infusions,

    WPIsetValue('C',0);
    WPIsendCommand('G');
    disp([datestr(now,31),' Delivery started'])

    % Wait for the pump to move
    pause(0.25 + vol / rate)

    % Check that the syringe moved correctly
    counter = WPIgetValue('C');
    if(counter / vol > 0.99),
        disp([datestr(now,31),' Delivered ',num2str(counter),' nl at ',num2str(rate), ' nl/sec'])
    else
        warning([datestr(now,31),' ERROR: Only ' num2str(counter), ' nl delivered!'])
    end
    fprintf(WPI.logfileID, [str,'\n']);

    % Adjust the current volume
    WPI.currentVol = WPI.currentVol - vol;
    disp([datestr(now,31),' Volume remaining ',num2str(WPI.currentVol),' nl'])

end