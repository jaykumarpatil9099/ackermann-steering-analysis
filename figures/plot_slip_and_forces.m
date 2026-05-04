%% plot_slip_and_forces.m
% Plots tyre slip angles and resulting lateral forces under three steering
% geometries (pure / parallel / anti-Ackermann) for a kinematic low-speed
% turn.
%
% Writes: ./fig_slip_angles.png
%         ./fig_lateral_forces.png
%
% Run:
%   cd figures
%   plot_slip_and_forces

clear; close all;
addpath('../src');
addpath('..');
parameters;

%% Outer wheel angle sweep (avoid 0 to keep R well-defined)
delta_outer_deg = 0.5:0.05:delta_outer_max_deg;
delta_outer     = deg2rad(delta_outer_deg);

geoms    = {'Pure Ackermann (k = 1)', 'Parallel (k = 0)', 'Anti-Ackermann (k = -1)'};
k_values = [ 1.0,   0.0,  -1.0];
colors   = { [0.00 0.45 0.74], [0.85 0.33 0.10], [0.47 0.67 0.19] };

%% Plot 1 — slip angles per tyre
fig1 = figure('Position', [100 100 1000 460], 'Color', 'w');

subplot(1, 2, 1); hold on;
for i = 1:numel(k_values)
    delta_inner            = ackermann_curves(delta_outer, k_values(i), L, tf);
    [slip_inner, ~]        = slip_angle_calc(delta_inner, delta_outer, L, tf);
    plot(delta_outer_deg, rad2deg(slip_inner), 'LineWidth', 1.8, ...
        'Color', colors{i}, 'DisplayName', geoms{i});
end
grid on; box on;
xlabel('Outer wheel steer angle [deg]', 'FontSize', 11);
ylabel('Inner tyre slip angle [deg]', 'FontSize', 11);
title('Inner front-tyre slip', 'FontSize', 12);
legend('Location', 'best'); set(gca, 'FontSize', 10);

subplot(1, 2, 2); hold on;
for i = 1:numel(k_values)
    delta_inner             = ackermann_curves(delta_outer, k_values(i), L, tf);
    [~, slip_outer]         = slip_angle_calc(delta_inner, delta_outer, L, tf);
    plot(delta_outer_deg, rad2deg(slip_outer), 'LineWidth', 1.8, ...
        'Color', colors{i}, 'DisplayName', geoms{i});
end
grid on; box on;
xlabel('Outer wheel steer angle [deg]', 'FontSize', 11);
ylabel('Outer tyre slip angle [deg]', 'FontSize', 11);
title('Outer front-tyre slip', 'FontSize', 12);
legend('Location', 'best'); set(gca, 'FontSize', 10);

drawnow;
exportgraphics(fig1, 'fig_slip_angles.png', 'Resolution', 150);
fprintf('Wrote fig_slip_angles.png\n');

%% Plot 2 — total front-axle lateral force (linear tyre)
fig2 = figure('Position', [100 100 880 520], 'Color', 'w');
hold on;
for i = 1:numel(k_values)
    delta_inner               = ackermann_curves(delta_outer, k_values(i), L, tf);
    [slip_inner, slip_outer]  = slip_angle_calc(delta_inner, delta_outer, L, tf);
    Fy_inner = tyre_lateral_force(slip_inner, C_alpha);
    Fy_outer = tyre_lateral_force(slip_outer, C_alpha);
    Fy_total = abs(Fy_inner) + abs(Fy_outer);
    plot(delta_outer_deg, Fy_total / 1000, 'LineWidth', 1.8, ...
        'Color', colors{i}, 'DisplayName', geoms{i});
end
grid on; box on;
xlabel('Outer wheel steer angle [deg]', 'FontSize', 11);
ylabel('Total front-axle |F_y| [kN]', 'FontSize', 11);
title(sprintf('Total front-axle lateral force  (linear tyre, C_\\alpha = %.0f kN/rad)', C_alpha/1000), 'FontSize', 12);
legend('Location', 'best');
set(gca, 'FontSize', 10);
drawnow;
exportgraphics(fig2, 'fig_lateral_forces.png', 'Resolution', 150);
fprintf('Wrote fig_lateral_forces.png\n');
