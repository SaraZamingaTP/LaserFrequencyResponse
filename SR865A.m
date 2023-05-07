classdef SR865A < Core.Patterns.VirtualInstrument

    properties
        R=[];
        theta=[];
    end 
    
	methods

		%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		%	Constructor								%
		%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		function obj = SR865A(varargin)
		%	Constructor of the class
		%
		%	[ input  ]
		%				Argument list, see:
		%					help Core.Patterns.VirtualInstrument
		%	[ output ]
		%				none
		%

			obj = obj@Core.Patterns.VirtualInstrument(	'Brand',			'Stanford_Research_Systems', ...
														'Name',				'SR865A', ...
														'Interface',		'GPIB0', ...
														'Address',			'4', ...
														'ForceConnection',	1, ...
														varargin{:} );

        end

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		%	Initialization								%
		%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		obj = LockInAmpInit(obj);

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		%	parameters setting					
		%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        LockAmp = LockInAmpDataAcquisition(LockAmp)

    end
end