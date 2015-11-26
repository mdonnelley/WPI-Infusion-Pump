function WPIbolus(vol)

% Deliver a 'vol' nl bolus
%
% EXAMPLE: WPIbolus(25000); % Deliver a 25 ul bolus

global WPI;

% Check that the bolus volume is not too large, otherwise set to max
if(vol > WPI.maximum - WPI.minimum) vol = WPI.maximum - WPI.minimum; end

% If the volume in the syringe is insufficient then withdraw
if(WPI.currentVol - vol < WPI.minimum) 
    disp('Insufficient volume remaining in syringe. Reloading ...')
    WPIwithdraw(WPI.maximum - WPI.currentVol);
end

% Infuse
WPIsendCommand('I');
WPIsetValue('V',vol);
WPIsetValue('C',0);
WPIsendCommand('G');

% Wait for the pump to move
pause(0.25 + vol / WPI.rate)

% Check that the syringe moved correctly
counter = WPIgetValue('C');
if(counter / vol > 0.99),
    WPI.currentVol = WPI.currentVol - vol;
    str = [datestr(now,14),' Delivered ',num2str(counter),'nl, ',num2str(WPI.currentVol),' nl remaining'];
    disp(str)
    fprintf(WPI.logfileID, [str,'\n']);
else
    str = [datestr(now,14),' ERROR: Only ' num2str(counter), 'nl delivered!'];
    warning(str)
    fprintf(WPI.logfileID, [str,'\n']);
end