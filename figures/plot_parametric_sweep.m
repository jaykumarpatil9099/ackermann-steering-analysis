%% plot_parametric_sweep.m
% Wheelbase sensitivity of pure-Ackermann steering geometry. Shows how the
% inner-wheel angle shifts for a given outer-wheel input as wheelbase
% varies — useful when sizing a new platform or scaling between vehicle
% classes (formula vs sedan vs truck).
%
% Writes: ./fig_wheelbase_sweep.png
%
% Run:
%   cd figures
%   plot_parametric_sweep

clear; close all;
addpath('../src');
addpath('..');
parameters;

%% Outer wheel angle sweep
delta_outer_deg = 0:0.05:delta_outer_max_deg;
delta_outer     = deg2rad(delta_outer_deg);

%% Wheelbases to compare (m) — covers FS through GT through truck
L_set = [2.0, 2.8, 3.5, 4.5];

%% Plot
fig = figure('Position', [100 100 880 520], 'Color', 'w');
hold on;
for L_i = L_set
    delta_inner = ackermann_curves(delta_outer, 1.0, L_i, tf);
    plot(delta_outer_deg, rad2deg(delta_inner), 'LineWidth', 1.6, ...
        'DisplayName', sprintf('L = %.1f m', L_i));
end
plot(delta_outer_deg, delta_outer_deg, 'k--', 'LineWidth', 1.0, 'DisplayName', 'Parallel reference');
grid on; box on;
xlabel('Outer wheel steer angle [deg]', 'FontSize', 11);
ylabel('Inner wheel steer angle (pure Ackermann) [deg]', 'FontSize', 11);
title(sprintf('Wheelbase sensitivity of pure Ackermann  (t = %.2f m)', tf), 'FontSize', 12);
legend('Location', 'northwest');
set(gca, 'FontSize', 10);
drawnow;
exportgraphics(fig, 'fig_wheelbase_sweep.png', 'Resolution', 150);
fprintf('Wrote fig_wheelbase_sweep.png\n');
