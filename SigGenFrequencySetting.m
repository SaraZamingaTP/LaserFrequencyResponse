function SigGen=SigGenFrequencySetting(SigGen, Frequency)
    
    SetFreqStr=convertStringsToChars(strcat('SOURce:FREQuency'," ",num2str(Frequency(FreqIndex)),'MHz')); 
    SigGen.set(SetFreqStr); 
    pause(0.02);

    freq_SigGen=str2double(regexprep(SigGen.get('SOURce:FREQuency?'), '\n', ''));
    fprintf('Frequency of %s: %.1f MHz\n', string(SigGen.id), freq_SigGen*1e-6); 
  
end