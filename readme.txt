Folder for the data acquisition and post-processing of the data concerning 
the Laser frequency response:

- LaserFrequencyResponse.m: main function for 
		a) Instrument initialization
		b) Instrument parameter settings
		c) Data Acquisition
		d) Plot representation

- SMIQ06B.m: signal generator class with relative methods to
		a) Reset
		b) Initialize
		c) Parameters setting

- SR865A.m lock-in amplifier class 
- ZVK.m: VNA class
- FSU.m: ESA class

-PlotParams.m: function to set the parameters for a good plot

-Data: folder with acquired results, with subfolders related to the method used