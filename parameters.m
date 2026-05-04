%% parameters.m
% Vehicle parameters used by the Ackermann steering analysis.
% Defaults describe a formula-class car, consistent with the 14-DoF model
% in the vehicle-dynamics-models-matlab-simulink repo.

%% Geometry
L  = 3.5;     % Wheelbase [m]
tf = 1.75;    % Front track width [m]
SR = 20;      % Steering ratio [deg/deg] (steering wheel : road wheel)

%% Tyre — linear model
% Cornering stiffness per tyre, at expected operating load.
C_alpha = 50e3;   % [N/rad]

%% Operating range used by the plotting scripts
delta_outer_max_deg = 20;          % Max outer-wheel steer angle to evaluate [deg]
