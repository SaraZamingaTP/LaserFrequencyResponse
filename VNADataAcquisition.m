function vna = VNADataAcquisition(vna)

    %save frequency vector
    x0 = vna.get('TRAC:STIM? CH1DATA');
    %save y data as real and imaginary part of S21
    y0 = vna.get('TRAC? CH1DATA');
    
    x1 = cell2mat(textscan(x0,'%f','Delimiter',','))';
    even=linspace(2,3202,1601);
    odd=linspace(1,3201,1601);
    y1 = cell2mat(textscan(y0,'%f','Delimiter',','))';
    vna.FrequencySweep=x1';
    vna.RealS12 = y1(odd)';
    vna.ImagS12= y1(even)';
    

end 