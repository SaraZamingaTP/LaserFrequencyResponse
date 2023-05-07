function LaserFrequencyResponse( ...
    isElecRect, isESA, isVNA, ...
    FrequencySweep, LaserCurrent, DetectorVoltage, isDataSave, StrName, isPlotting)

    % function allowing to perform the acquisition and post-processing of
    % the data to measure the frequency response of a laser when under
    % DIRECT modulation 

    %Three methods are available:
    % 1) ELECTRICAL RECTIFICATION: need of external signal generator +
    % lock-in amplifier
    % 2) ESA: need of ESA + external signal generator
    % 3) VNA: need of VNA and detector  

    %  FrequencySweep: Column vector

    global VISAMng; VISAMng.setBufferLength(1E8);

    %% initialization of the instruments: 
    % communication establishing, resetting and parameters setting

    try

        if isElecRect || isESA %inizialization of Signal Generator
        SigGen = SMIQ06B; 

            SigGen=SigGenInizialization(SigGen, ...
                isElecRect, isESA);

        end

        if isElecRect %inizialization of lock-in amplifier
            LockAmp = SR865A;
            LockAmp = LockInAmpInit(LockAmp);

        end 
        
        if isVNA
            vna = ZVK;
        end
        
        isDataAcquisition=true;

    catch ME %catch the presence of errors

        disp('Error occurred\n!');
        disp(ME.message);

        isDataAcquisition=false;

    end
   
    %% Data acquisition 
    % in case of successful initialization, the data acquisition begins 

    if isDataAcquisition

        if isElecRect || isESA
    
            NbrFreq=length(FrequencySweep);

            for FrequencyIndex=1:NbrFreq

                SigGen=SigGenFrequencySetting(SigGen, Frequency);

                if isElectRect
                    LockAmp = LockInAmpDataAcquisition(LockAmp);
                    R(FrequencyIndex,1)=LockAmp.R;  
                    theta(FrequencyIndex,1)=LockAmp.theta;
                end
            end


            if isElecRect
                IntensitydBm=20*log10(R./((0.001*10*1e6)^0.5));

                %save data into a structure 
                Response = struct('Frequency',FrequencySweep, 'Intensity', ...
                    IntensitydBm, 'LaserCurrent', LaserCurrent);
            end

            %what about ESA? 

        end 

        if isVNA

            vna = VNADataAcquisition(vna);
            %compute the intensity starting from S21
            AbsoluteS12=20*log10(sqrt(vna.RealS12.^2+vna.ImagS12.^2));

            %save data into a structure: for VNA, information on the 4
            %bias current of the laser and the bias voltage of the detector
            %might be useful
            Response = struct('Frequency',FrequencySweep/1e9, 'Intensity', AbsoluteS12, ...
            'LaserCurrent', LaserCurrent, 'DetectorVoltage', DetectorVoltage);

        end

        if isDataSave %save the data for post-processing 

            %save data in apposite folder
            if isElecRect
                cd Data\ElectricalRectification\
            elseif isESA
                cd Data\ESA\
            elseif isVNA
                cd Data\VNA\
            end

            datetime_now = datetime;
            datetime_now.Format = 'yyyy-MM-dd_hh-mm-ss_';
            %the info on the laser current are in the structure itself
            filename=strcat(datetime_now,StrName, '.mat');
            save(filename,'Response'); %save the structure Response into the file

            %after data saving, cd to main project folder 
            cd \\zfs-b232.enst.fr\szaminga\Desktop\PhD\LaserFrequencyResponse\
        end
    end

    %% Plot of the acquired data
    % The data are plot when acquisition is done 
    if isPlotting

        if isElecRect
            cd Data\ElectricalRectification\
        elseif isESA
            cd Data\ESA\
        elseif isVNA
            cd Data\VNA\
        end

        % use the dir function to find all files that match the pattern
        FileList = dir(fullfile(pwd, '*.mat'));

        for FileIndex=length(FileList):-1:1

            if isESA % file .DAT 
                opts=FSUImporOptionsData();
                TRACE = table2array(readtable(FileList(FileIndex).name, opts));
                Response = struct('Frequency',[], 'Intensity', []);
            
                %find 5 MHz
                find_5MHz=find(TRACE(:,1)<=5000000, 1, 'last');
                %analyze points >=5 MHz
                Response.Frequency=TRACE(find_5MHz:end,1)*1e-6;
                Response.Intensity=TRACE(find_5MHz:end,2);
            end

            if isElecRect || isVNA %% file .mat 
                filename = fullfile(pwd, FileList(FileIndex).name);
                load(filename);
            end

            DisplayStr=strcat(num2str(Response.LaserCurrent), ' mA');
            pl(FileIndex)=semilogx(Response.Frequency, Response.Intensity-max(Response.Intensity), ...
            'LineStyle','-','LineWidth',2,'DisplayName', DisplayStr);
            hold on
        end

        %% function to set the parameters for a good plot
        isLegend=true;
        PlotInput=pl;
        XLabelStr='Frequency (GHz)'; 
        YLabelStr='Norm. intensity response (dB)'; 
        isXLim=false; 
        isYLim=false;
        XLimit=[]; YLimit=[];
        
        grid on
        %- 3 dB BW
        yline(-3,'--','-3 dB','Color',rgb('darkslategrey'),...
            'LineWidth',2, 'fontsize',30,'interpreter','latex');
        PlotParams(isLegend, PlotInput, isXLim, isYLim, XLimit, YLimit, ...
            XLabelStr, YLabelStr);

    end 
         
end
