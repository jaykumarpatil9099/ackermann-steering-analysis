function Fy = tyre_lateral_force(slip_angle, C_alpha)
%TYRE_LATERAL_FORCE  Linear-tyre lateral force from slip angle.
%
%   Fy = TYRE_LATERAL_FORCE(slip_angle, C_alpha)
%
%   Linear tyre model:  Fy = -C_alpha * slip_angle
%
%   Sign convention follows SAE / ISO: positive slip angle (wheel pointed
%   left of velocity vector) generates negative lateral force.
%
%   Valid in the small-slip regime (typically slip_angle < ~3 deg). For
%   larger slip angles a non-linear model (e.g. Pacejka Magic Formula)
%   is required.

    Fy = -C_alpha .* slip_angle;
end
