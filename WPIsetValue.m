function WPIsetValue(parameter,value)

% WPIsetValue('V',volume);      % Set volume
% WPIsetValue('C',counter);     % Set counter
% WPIsetValue('R',rate);        % Set rate

if(ischar(parameter) & isnumeric(value)),
    if(strcmp(parameter,'V') | strcmp(parameter,'C') | strcmp(parameter,'R')),
        str = num2str(fix(value));
        WPIsendCommand(parameter);
        for i=1:length(str),
            WPIsendCommand(str(i));
        end
        WPIsendCommand('.');
        response = WPIsendCommand(';');
        if(str2num(response(2:length(response))) ~= value) warning('Incorrect response returned from controller!'); end
    else
        warning('Parameter must be V, C or R');
    end
else
    warning('Incorrect use of function: WPIsetValue(parameter,value)');
end