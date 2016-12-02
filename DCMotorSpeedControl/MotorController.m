
% Load the motor model characterization data
MotorModel_Mabuchi_RS_540;

% Create the state space model and the transfer function
MotorModel_StateSpace_LinearSISO;

% Name the inputs/outputs for building the block diagram
H_mtr.InputName = 'u';
H_mtr.OutputName = 'y';


% Proportional term in V/(rad/s)
Kp_mtr = 100*Kv; 

C = pidstd(Kp_mtr);

C.InputName = 'e';
C.OutputName = 'u';

% Build the block diagram of the feeback control system
Sum = sumblk('e = r - y');
T = connect(H_mtr,C,Sum, 'r', 'y');


figure;
step_opts = stepDataOptions('StepAmplitude', 2000);
stepplot(T, step_opts);


figure;
bodeplot(T);

figure;
margin(T);

figure;
pzplot(T);

