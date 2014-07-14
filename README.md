WPI-Infusion-Pump
=================

Serial code to interface to the WPI micro infusion pump

This Matlab code is designed to control the WPI Micro4 Controller to actuate a UMP2 Microsyringe Injector.

The code primarily uses four Matlab functions (all volumes in nanolitres):

WPIsetup(INITIAL_VOL);
WPIbolus(BOLUS_VOL)
WPIinfuse(VOL_PER_PERIOD, TIME_PERIOD)
WPIcleanup;
