%% Simulate Single Link Network

clear; clc; close all;

K_values = [1, 5, 15, 50, 100];
N = 1000;                        % number of simulations
p_values = 0:0.05:0.9;           % range of failure probabilities
colors = lines(length(K_values));

simResults = zeros(length(K_values), length(p_values));
calcResults = zeros(length(K_values), length(p_values));

for kIndex = 1:length(K_values)
    K = K_values(kIndex);
    
    for pIndex = 1:length(p_values)
        p = p_values(pIndex);

        % Run simulation
        simResults(kIndex, pIndex) = runCompoundNetworkSim(K, p, N);

        % --- Calculated result ---
        % Failure of one branch = 2p - p^2
        % Failure of both branches = (2p - p^2)^2
        % Success per packet = 1 - (2p - p^2)^2
        % Expected transmissions = K / (1 - (2p - p^2)^2)
        calcResults(kIndex, pIndex) = K / (1 - (2*p - p^2)^2);
    end
    
    % Plot for each individual K
    figure;
    semilogy(p_values, calcResults(kIndex,:), '-', 'Color', colors(kIndex,:), 'LineWidth', 1.5); hold on;
    semilogy(p_values, simResults(kIndex,:), 'o', 'Color', colors(kIndex,:), 'MarkerSize', 6);
    xlabel('Packet Failure Probability (p)');
    ylabel('Average Number of Transmissions');
    title(sprintf('Compound Network Simulation (K = %d)', K));
    legend('Calculated', 'Simulated', 'Location', 'northwest');
    grid on;
end

% Combined plot for all K values
figure;
for kIndex = 1:length(K_values)
    semilogy(p_values, calcResults(kIndex,:), '-', 'Color', colors(kIndex,:), 'LineWidth', 1.5); hold on;
    semilogy(p_values, simResults(kIndex,:), 'o', 'Color', colors(kIndex,:), 'MarkerSize', 6);
end

xlabel('Packet Failure Probability (p)');
ylabel('Average Number of Transmissions');
title('Compound Network - All K Values');
legend(arrayfun(@(K) sprintf('K = %d', K), K_values, 'UniformOutput', false), 'Location', 'northwest');

grid on;
