
%% Motor Model Parameters
% Motor: Mabuchi RS-540SH
%   Voltage: 9.6V
%   No Load Speed: 23400 r/min
%   Rated Load Current: 8.2A
%   Rated Load Speed: 20000 r/min
%   Rated Load: 19.6mN m
%   No Load Current: 2.4A
%
%  Estimated From Characteristic Curves
%   Peak Efficiency: 71% @ 20000 r/min
%   Stall Current: 57.4A
%   Ki = (225e-3)/(57.4-2.4) =  0.0041Nm/A
%   Kv = (9.6)/(23400) = 4.1026 V/(r/min) = 0.0039 V/(rad/s)
%   Stall Current: 57.4A
%
%  Calculations
%   R = 9.6V/57.4A = 0.1672 Ohms
%
% No information on friction, rotational inertia, or inductance
% SWAG for Kfr, KfrOffset, Im, Lm below given results that are no
% ridiculous.
%


Ki = 0.0041; % Nm/A
Kv = 0.0039; % V/(rad/s)
Kfr = 5.0e-6;
KfrOffset = 1.0e-6;
Im = 5e-6;
Rm = 0.1672;
Lm = 1e-5;
Vdc = 9.6;
