classdef ZVK < Core.Patterns.VirtualInstrument

    properties
        FrequencySweep=[];
        RealS12=[];
        ImagS12=[];
    end 

	methods

		%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		%	Constructor								%
		%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		function obj = ZVK(varargin)
		%	Constructor of the class
		%
		%	[ input  ]
		%				Argument list, see:
		%					help Core.Patterns.VirtualInstrument
		%	[ output ]
		%				none
		%

			obj = obj@Core.Patterns.VirtualInstrument(	'Brand',			'Rohde&Schwarz', ...
														'Name',				'ZVK', ...
														'Interface',		'GPIB1', ...
														'Address',			'20', ...
														'ForceConnection',	1, ...
														varargin{:} );

        end

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		%	Data Acquisition								%
		%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		vna = VNADataAcquisition(vna);

	end % methods
end