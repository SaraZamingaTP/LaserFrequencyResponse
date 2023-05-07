function SigGen=SigGenReset(SigGen, isElecRect)

    %when finish
    SigGen.set('SYSTem:PRESet');                 % instrument reset to default conditions
    SigGen.set('OUTPut:STATe OFF');              %turn off the RF output

    if isElecRect
        SigGen.set('OUTPut2:STATe OFF');             %turn off the LF output
        SigGen.set('SOURce:AM:STATe OFF');           %turn off the source
    end
end
