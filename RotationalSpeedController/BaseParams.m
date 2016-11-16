
% Plant physical parameters
K_fr = 0.05; % friction coefficient
I = 0.01; % inertia

% State space model of plant (inertia with viscous friction)
Aplant = [0 1; 0 -K_fr/I];
Bplant = [0; 1/I];
Cplant = [0 1];
Dplant = [0];
G2 = ss(Aplant,Bplant,Cplant,Dplant);

% Transfer Function of Actuator (simple filter of torque actuator)
Nact = [1];
Dact = [0.001 1];
G1 = tf(Nact, Dact);

% Controller: PI
% Kp and Ki from pidTuner
Kp = 4.0289;
Ki = 26.5841;
Ci = tf(10, [1 0]);
Cp = tf(20, 1);
C = parallel(Ci, Cp);

% Ideal Sensor Model
S = tf([1], [1]);

% Open Loop Model
H = G2*G1*C;

% Closed Loop Model
T = feedback(H, S);
