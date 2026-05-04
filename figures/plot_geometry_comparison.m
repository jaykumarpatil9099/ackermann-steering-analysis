%% plot_geometry_comparison.m
% Compares the inner-vs-outer wheel angle relationship for three steering
% geometries: pure Ackermann (k=1), parallel (k=0), anti-Ackermann (k=-1).
% Also plots each geometry's deviation from the pure-Ackermann reference.
%
% Writes: ./fig_inner_vs_outer.png
%         ./fig_deviation_from_ideal.png
%
% Run:
%   cd figures
%   plot_geometry_comparison

clear; close all;
addpath('../src');
addpath('..');                          % loads parameters.m
parameters;

%% Outer wheel angle sweep
delta_outer_deg = 0:0.05:delta_outer_max_deg;
delta_outer     = deg2rad(delta_outer_deg);

%% Three geometries
delta_inner_pure     = ackermann_curves(delta_outer,  1.0, L, tf);
delta_inner_parallel = ackermann_curves(delta_outer,  0.0, L, tf);
delta_inner_anti     = ackermann_curves(delta_outer, -1.0, L, tf);

%% Plot 1 — inner vs outer
fig1 = figure('Position', [100 100 880 520], 'Color', 'w');
plot(delta_outer_deg, rad2deg(delta_inner_pure),     'LineWidth', 1.8, 'DisplayName', 'Pure Ackermann (k = 1)'); hold on;
plot(delta_outer_deg, rad2deg(delta_inner_parallel), 'LineWidth', 1.8, 'DisplayName', 'Parallel (k = 0)');
plot(delta_outer_deg, rad2deg(delta_inner_anti),     'LineWidth', 1.8, 'DisplayName', 'Anti-Ackermann (k = -1)');
plot(delta_outer_deg, delta_outer_deg, 'k--', 'LineWidth', 1.0, 'DisplayName', '\delta_{inner} = \delta_{outer}');
grid on; box on;
xlabel('Outer wheel steer angle [deg]', 'FontSize', 11);
ylabel('Inner wheel steer angle [deg]', 'FontSize', 11);
title(sprintf('Steering geometry comparison  (L = %.1f m, t = %.2f m)', L, tf), 'FontSize', 12);
legend('Location', 'northwest');
set(gca, 'FontSize', 10);
drawnow;
exportgraphics(fig1, 'fig_inner_vs_outer.png', 'Resolution', 150);
fprintf('Wrote fig_inner_vs_outer.png\n');

%% Plot 2 — deviation of each geometry from pure Ackermann
fig2 = figure('Position', [100 100 880 520], 'Color', 'w');
plot(delta_outer_deg, rad2deg(delta_inner_parallel - delta_inner_pure), 'LineWidth', 1.8, 'DisplayName', 'Parallel'); hold on;
plot(delta_outer_deg, rad2deg(delta_inner_anti     - delta_inner_pure), 'LineWidth', 1.8, 'DisplayName', 'Anti-Ackermann');
plot(delta_outer_deg, zeros(size(delta_outer_deg)), 'k--', 'LineWidth', 1.0, 'DisplayName', 'Pure Ackermann (reference)');
grid on; box on;
xlabel('Outer wheel steer angle [deg]', 'FontSize', 11);
ylabel('Inner-angle deviation from pure Ackermann [deg]', 'FontSize', 11);
title('Inner-wheel-angle deviation across geometries', 'FontSize', 12);
legend('Location', 'best');
set(gca, 'FontSize', 10);
drawnow;
exportgraphics(fig2, 'fig_deviation_from_ideal.png', 'Resolution', 150);
fprintf('Wrote fig_deviation_from_ideal.png\n');
