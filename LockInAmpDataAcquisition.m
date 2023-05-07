function [R, theta] = LockInAmpDataAcquisition(LockAmp)

    % Read data from the instrument
    DataStr = strsplit(LockAmp.get('SNAP? 2,3'), ','); %query R,theta (2,3) values to SR865A 
    % strsplit separates the data R and theta in two different cells
      
    % Convert the data to a number in dB units
    R = str2double(DataStr(1)); %absolute value
    theta =str2double(DataStr(2)); %Phase value: no need to represent it

end