function [slip_inner, slip_outer, R] = slip_angle_calc(delta_inner, delta_outer, L, t)
%SLIP_ANGLE_CALC  Front-tyre slip angles for a low-speed kinematic turn.
%
%   [slip_inner, slip_outer, R] = SLIP_ANGLE_CALC(delta_inner, delta_outer, L, t)
%
%   Computes the slip angle developed by each front tyre when the
%   vehicle is steered with given inner and outer wheel angles. The
%   instantaneous turn radius R is taken from the mean front-axle steer
%   angle (the bicycle-model interpretation of front-axle steering).
%
%   Inputs:
%     delta_inner, delta_outer  - actual wheel steer angles [rad]
%     L, t                      - wheelbase, front track width [m]
%
%   Outputs:
%     slip_inner, slip_outer    - tyre slip angles [rad]
%                                  (= actual angle - ideal angle for R)
%     R                         - vehicle path radius [m]
%
%   For pure Ackermann input (delta_inner = pure Ackermann result),
%   both slip outputs are essentially zero (sub-degree numerical residual
%   from the bicycle-model R approximation).

    delta_avg = (delta_inner + delta_outer) / 2;
    R         = L ./ tan(delta_avg);

    delta_inner_ideal = atan( L ./ (R - t/2) );
    delta_outer_ideal = atan( L ./ (R + t/2) );

    slip_inner = delta_inner - delta_inner_ideal;
    slip_outer = delta_outer - delta_outer_ideal;
end
