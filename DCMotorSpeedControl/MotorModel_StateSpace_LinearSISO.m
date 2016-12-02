
% Generate state space model for motor model
%   - SISO: voltage to velocity
%   - with linear coulomb and viscous friction
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

%  States
% ---------------------------------------------
%   x1 - theta, angular position (radians)
%   x2 - omega, angular velocity (rad/s)
%   x3 - current (Amp)
%   x4 - 1 (for friction offset)
%
%  Outputs
% ---------------------------------------------
%   y1 - omega, x2 (rad/s)
%

A_mtr = [ 0 1 0;
          0 -Kfg/J_rotor Ki/J_rotor;
          0 -Kv/L_winding -R_winding/L_winding ];
B_mtr = [ 0;
          0;
          1/L_winding ];

C_mtr = [ 0 1 0 ];
D_mtr = [ 0; ];


sys_mtr = ss(A_mtr, B_mtr, C_mtr, D_mtr, ...
    'InputName', {'V' }, ...
    'OutputName',{'Om'} );
H_mtr = tf(sys_mtr);


if( 0 )
    figure;
    step_opts = stepDataOptions('StepAmplitude', 9.6);
    stepplot(H_mtr, step_opts);
end


if( 0 )
    figure;
    bodeplot(sys_mtr);
end

if( 0 )
    figure;
    pzplot(H_mtr);
end


