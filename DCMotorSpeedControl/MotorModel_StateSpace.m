
% Generate state space model for motor model
%
% J_rotor - inertia of the rotating part of the motor (kgm^2)
% L_winidng - inductance of motor windings (Henries)
% R_winding - resistance of motor windings (Ohms)
% Ki - motor torque constant (Nm/A)
% Kv - motor speed constant (V/(rad/s))
% Kfg - friction coefficeint, gain value from Simulink Doulomb & Viscous Friction block
% Kfo - friction coefficeint, offset value from Simulink Doulomb & Viscous Friction block
%
%  Inputs
% ---------------------------------------------
%   u1 - applied voltage (Volts)
%   u2 - load torque (Nm)

%  States
% ---------------------------------------------
%   x1 - theta, angular position (radians)
%   x2 - omega, angular velocity (rad/s)
%   x3 - current (Amp)
%   x4 - 1 (for friction offset)
%
%  Outputs
% ---------------------------------------------
%   y1 - current, x3 (Amp)
%   y2 - omega, x2 (rad/s)
%   y3 - theta, x1 (radians)
%

A_mtr = [ 0 1 0 0;
          0 -Kfg/J_rotor Ki/J_rotor -Kfo/J_rotor;
          0 -Kv/L_winding -R_winding/L_winding 0;
          0 0 0 0 ];
B_mtr = [ 0 0;
          0 1/J_rotor;
          1/L_winding 0;
          0 0 ];

C_mtr = [ 0 0 1 0;
          0 1 0 0;
          1 0 0 0 ];
D_mtr = [ 0 0; 0 0; 0 0 ];

sys_mtr = ss(A_mtr, B_mtr, C_mtr, D_mtr, ...
    'InputName', {'V'; 'T'}, ...
    'OutputName',{'I'; 'Om'; 'Theta'} );
H_mtr = tf(sys_mtr);
figure;
stepplot(H_mtr);
figure;
bodeplot(sys_mtr);


