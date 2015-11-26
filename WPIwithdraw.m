function WPIwithdraw(vol)

% WPIwithdraw(25000)

global WPI;

% Check if the withdrawl volume is too large
if(vol > WPI.maximum - WPI.currentVol) vol = WPI.maximum - WPI.currentVol; end

% Withdraw
WPIsendCommand('W');
WPIsetValue('V',vol);
WPIsetValue('C',0);
WPIsendCommand('G');

% Wait for the pump to move
pause(0.25 + vol / WPI.rate)

% Check that the syringe moved correctly
counter = WPIgetValue('C');
if(counter / vol > 0.99),
    WPI.currentVol = WPI.currentVol + vol;
    disp([datestr(now,14),' Withdrawn ', num2str(vol), 'nl, ',num2str(WPI.currentVol),' nl remaining']);
else
    warning([datestr(now,14),' ERROR RESETTING SYRINGE'])
end
