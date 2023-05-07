classdef SMIQ06B < Core.Patterns.VirtualInstrument
    properties
        isElecRect=true;
        isESA=false;
    end

	methods

		%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		%	Constructor								%
		%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		function obj = SMIQ06B(varargin)
		%	Constructor of the class
			obj = obj@Core.Patterns.VirtualInstrument(	'Brand',			'Rohde&Schwarz', ...
														'Name',				'SMIQ06B', ...
														'Interface',		'GPIB0', ...
														'Address',			'28', ...
														'ForceConnection',	1, ...
														varargin{:} );
        end

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		%	Reset 								%
		%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        obj=SigGenReset(obj, isElecRect);

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		%	Initialization 								%
		%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        obj=SigGenInizialization(obj, isElecRect, isESA);

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		%	Set Frequency 								%
		%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        obj=SigGenFrequencySetting(obj, Frequency);

     end
%     
end