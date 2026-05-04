function delta_inner = ackermann_curves(delta_outer, k_ackermann, L, t)
%ACKERMANN_CURVES  Inner wheel angle for a given outer-wheel angle and Ackermann fraction.
%
%   delta_inner = ACKERMANN_CURVES(delta_outer, k_ackermann, L, t)
%
%   Inputs:
%     delta_outer  - outer-wheel steer angle [rad]
%     k_ackermann  - Ackermann fraction [-]
%                       1.0 = pure (100%) Ackermann
%                       0.0 = parallel steering
%                      -1.0 = "100% anti-Ackermann" (mirror of pure
%                              across the parallel reference)
%     L            - wheelbase [m]
%     t            - track width [m]
%
%   Output:
%     delta_inner  - inner-wheel steer angle [rad]
%
%   Math:
%     Pure Ackermann inner-wheel angle (zero slip in low-speed turn):
%        delta_inner_pure = atan( L / ( L/tan(delta_outer) - t ) )
%
%     General parametrisation:
%        delta_inner = delta_outer + k_ackermann * (delta_inner_pure - delta_outer)
%
%   Sign convention: positive angles for a left turn (inner = left wheel).

    % atan handles the limit delta_outer -> 0 (gives delta_inner_pure -> 0)
    delta_inner_pure = atan( L ./ ( L ./ tan(delta_outer) - t ) );
    delta_inner      = delta_outer + k_ackermann .* (delta_inner_pure - delta_outer);
end
