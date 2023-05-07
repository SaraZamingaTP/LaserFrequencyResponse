function SigGen=SigGenInizialization(SigGen, ...
    isElecRect, isESA)

    %in case of Electrical Rectification, we need AM modulation (RF + LF
    %output) 
    %in case of ESA, we need only the RF output 
    % Frequency: vector defining the frequency sweep for RF

    %% Signal Generator Initialization
    SigGen.set('*RST');
    SigGen.set('*CLS');             %instrument reset
    SigGen.set('SYSTem:PRESet');    %instrument reset to default conditions

    fprintf('%s RESET\n!', string(SigGen.id));
    % RF modulation settings - ESA and Electrical Rectification
    SigGen.set('SOURce:FREQuency 5MHz'); 
    SigGen.set('SOURce:POWer -20');                                 
    SigGen.set('OUTPut:AMODe AUTO');            %set the operating mode of the attenuator for RF source 

    if isElecRect %AM modulation: ElecRect only
        SigGen.set('SOURce:AM:SOURce INT');                    %set internal source
        SigGen.set('SOURce:AM:INTernal:FREQuency 1kHz');       %set the LF modulation frequency
        SigGen.set('SOURce:AM:DEpth 90PCT'); 
    end 

    %print the error message from the SigGen
    resp = string(SigGen.get('SYSTem:ERRor?'));             %get the error string
    resp_new = extractBetween(resp,1,strlength(resp)-1);    %eliminate the final newline command 

    if  strcmp(resp_new, string('0,"No error"')) == 1

        SigGen.set('OUTPut:STATe ON');   %turn on the RF output

        if isElecRect
            SigGen.set('OUTPut2:STATe ON');  %turn on the LF output
            SigGen.set('SOURce:AM:STATe ON'); %turn on the AM source
        end
    
        fprintf('AM Parameters correctly set\n');       %print message
 
    else
        
        fprintf('Errors list:\n');

        while strcmp(resp_new,string('0,"No error"')) ~= 1
            fprintf(resp_new);
            fprintf('\n');
            resp = string(SigGen.get('SYSTem:ERRor?')); 
            resp_new = extractBetween(resp,1,strlength(resp)-1); 
        end 

    end 
    
    
end

       