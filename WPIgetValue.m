function response = WPIgetValue(parameter)

% volume = WPIgetValue('V');        % Get volume
% counter = WPIgetValue('C');       % Get counter
% rate = WPIgetValue('R');          % Get rate
% mode = WPIgetValue('M');          % Get mode
% type = WPIgetValue('S');          % Get syringe type
% direction = WPIgetValue('D');     % Get direction
% units = WPIgetValue('U');         % Get units
% state = WPIgetValue('G');         % Get state

if(ischar(parameter)),
    if(strcmp(parameter,'V') | strcmp(parameter,'C') | strcmp(parameter,'R')),
        response = WPIsendCommand(['?',parameter]);
        response = str2num(response(3:length(response)));
    elseif(strcmp(parameter,'M') | strcmp(parameter,'S') | strcmp(parameter,'D') | strcmp(parameter,'U') | strcmp(parameter,'G')),
        response = WPIsendCommand(['?',parameter]);
        response = response(3);
    else
        warning('Parameter must be V,C,R,M,S,D,U,G');
    end
else
    warning('Incorrect use of function: response = WPIgetValue(parameter)');
end