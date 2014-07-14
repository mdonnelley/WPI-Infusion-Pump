function WPIbolus(vol)

% WPIbolus(25000)

global WPI;

% Check that the bolus volume is not too large
if(vol > WPI.maximum - WPI.minimum) vol = WPI.maximum - WPI.minimum; end

% If the volume in the syringe is insufficient then withdraw
if(WPI.currentVol < WPI.minimum - vol) WPIwithdraw(WPI.maximum - WPI.currentVol); end

% Infuse
WPIsendCommand('I');
WPIsetValue('V',vol);
WPIsetValue('C',0);
WPIsendCommand('G');
disp([datestr(now,14),' Delivering ',num2str(vol),'nl'])

% Wait for the pump to move
pause(0.25 + vol / WPI.rate)

% Check that the syringe moved correctly
counter = WPIgetValue('C');
if(counter / vol > 0.99),
    str = [datestr(now,14),' Delivered ',num2str(counter),'nl successfully'];
    disp(str)
    fprintf(WPI.logfileID, [str,'\n']);
else
    str = [datestr(now,14),' ERROR: Only ' num2str(counter), 'nl delivered!'];
    warning(str)
    fprintf(WPI.logfileID, [str,'\n']);
end

% Adjust the current volume
WPI.currentVol = WPI.currentVol - vol;