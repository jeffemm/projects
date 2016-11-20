
%% Motor Model Parameters
% Motor: Mabuchi RS-540SH
%   Voltage: 9.6V
%   No Load Speed: 23400 r/min (2450.4 rad/s)
%   Rated Load Current: 8.2A
%   Rated Load Speed: 20000 r/min
%   Rated Load: 19.6mN m
%   No Load Current: 2.4A
%
%  Estimated From Characteristic Curves
%   Peak Efficiency: 71% @ 20000 r/min
%   Peak Power: 131.5W @ 12000 r/min
%   Stall Current: 57.4A
%   Ki = (215e-3)/(57.4) =  0.0037Nm/A
%   Kv = (9.6 - 2.4*0.1672)/(23400) = 3.9316e-4 V/(r/min) = 0.0038 V/(rad/s)
%   Stall Current: 57.4A
%
%  Calculations
%   R = 9.6V/57.4A = 0.1672 Ohms
%
% No information on friction, rotational inertia, or inductance
% SWAG for Kfr, KfrOffset, Im, Lm below given results that are no
% ridiculous.
%
%  *For Lm from 10e-6 to 500e-6 only minor change in step response
%
% Total Mass: 160g (based on internet research)
% Dimensions:
%       D: 35.8mm
%       L: 50.0mm
%
% Estimated rotor inertia:
%   I = 1/2 mr^2
%  Assumptions:
%       rotor mass: 60% of total mass
%       rotor diameter: 60% of outside diameter
%
%
% No Load:
%    TqFric = Ki * Inl
%    OmnlKv = Vin - Inl * R
%
% at Ki = 0.0037, no load
%   TqFric = 0.0037 * 2.4A = 0.0089Nm
%   

m_motor = 160.0/1000;
l_motor = 50.0/1000;
d_motor = 35.8/1000;

m_rotor = m_motor * 0.60;
r_rotor = d_motor * 0.60/2;

Vdc_nom = 9.6;
I_stall = 57.4;
Tq_stall = 215e-3;
I_nl = 2.4;
Om_nl = 23400*2*pi/60;
R_winding = Vdc_nom/I_stall;


Ki = (Tq_stall/I_stall); % Nm/A
Kv = (Vdc_nom - (I_nl*R_winding))/Om_nl; % V/(rad/s)

KfrOffset = 0.0001;
Kfr = ((Ki*I_nl) - KfrOffset)/(Om_nl^2); %based on calculated no load I*Ki and Omega
J_rotor = m_rotor * r_rotor^2/2;
L_winding = 30e-6;
Vdc = 9.6;


I_initial = I_nl; % No load at 9.6V
Om_initial = Om_nl; % No load at 9.6V
