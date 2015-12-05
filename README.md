A work in progress for importing and plotting .bin files from APM.
Comments/suggestions/improvements appreciated :).  As well as bug reports.

It would be really cool if someone could make a .exe or something of the code from the MissionPlanner project (https://github.com/diydrones/MissionPlanner/blob/master/Log/MatLab.cs) to convert the .bin to .mat way more quickly that could be called from MATLAB.

Matt Anderson 2015

=======
Usage
- Use << convert_bin_to_mat_APM(file) >> to convert the .bin file from the APM/Pixhawk into a .mat file.  This will automatically clean the data up using clean_PX4_file as well.  Warning as the importing process is a bit slow.
- Plot the data using plot_PX4_file

If you really want the data and cannot wait for the conversion, this is much faster
- Convert the .bin to a MATLAB file using MissionPlanner.  Flight Data > DataFlash Logs > Create Matlab File
- Convert the resulting .mat file using convert_MP_mat(file).  A new .mat file will be created with -new added.
- Plot the data using plot_PX4_file

======
plot_google_map function from Zohar Bar-Yehuda at http://www.mathworks.com/matlabcentral/fileexchange/27627-zoharby-plot-google-map


