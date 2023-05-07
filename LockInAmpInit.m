function isLockInInit = LockInAmpInit(LockAmp)

    try 
        fprintf('Initialization:\n %s%s \n', string(LockAmp.id), string(LockAmp.Address));
        LockAmp.set('*RST'); %reset to default configuration
        %set the input
        LockAmp.set('IVMD VOLT');           %set the signal input to voltage
        LockAmp.set('ISRC A');              %set the voltage input mode to A (single-ended)
        LockAmp.set('ICPL AC');             %set the voltage input coupling to DC
        %DC coupling is required for frequencies below 160 mHz
        %since we represent the LF of AM modulation, DC coupling is required
        
        %The shields should be grounded if the signal source is floating: is the
        %signal source floating in our case? I think so?
        LockAmp.set('IGND GROund');         %set the voltage input shields 
        LockAmp.set('IRNG 4');                %set the voltage input range 
        LockAmp.set('ICUR 1MEG');           %set the current input gain (to 1 µA)
        LockAmp.set('SCAL 8');              %set the sensitivity 500 µV
        LockAmp.set('OFLT 12');             %set the time constant to 30 s
        
        LockAmp.set('RSRC EXT');              %set the external source
        %set the output channel 
        LockAmp.set('COUT OCH1, RTHeta');           %set CH1 to R
        LockAmp.set('COUT OCH2, RTHeta');           %set CH2 to Theta

        isLockInInit=true;

    catch ME

        isLockInInit=false;
        disp('Error occurred\n!');
        disp(ME.message);

    end
        
end