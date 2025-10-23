%% Simulate Single Link Network
% Task 1 - Compare simulated vs. calculated average transmissions

clear; clc; close all;

K_values = [1, 5, 15, 50, 100];
N = 1000;                        % number of simulations
p_values = 0:0.05:0.9;           % range of failure probabilities
colors = lines(length(K_values)); % distinct colors for plotting

simResults = zeros(length(K_values), length(p_values));
calcResults = zeros(length(K_values), length(p_values));

for kIndex = 1:length(K_values)
    K = K_values(kIndex);
    
    for pIndex = 1:length(p_values)
        p = p_values(pIndex);
        
        % Run simulation using provided function
        simResults(kIndex, pIndex) = runSingleLinkSim(K, p, N);
        
        % calculated result:
        % Expected transmissions per packet = 1 / (1 - p)
        % Total expected = K * (1 / (1 - p))
        calcResults(kIndex, pIndex) = K / (1 - p);
    end
    
    % Plot for each individual
    figure;
    semilogy(p_values, calcResults(kIndex,:), '-', 'Color', colors(kIndex,:), 'LineWidth', 1.5); hold on;
    semilogy(p_values, simResults(kIndex,:), 'o', 'Color', colors(kIndex,:), 'MarkerSize', 6);
    xlabel('Packet Failure Probability (p)');
    ylabel('Average Number of Transmissions');
    title(sprintf('Single Link Network Simulation (K = %d)', K));
    legend('Calculated', 'Simulated', 'Location', 'northwest');
    grid on;
end

% Plot w all
figure;
for kIndex = 1:length(K_values)
    semilogy(p_values, calcResults(kIndex,:), '-', 'Color', colors(kIndex,:), 'LineWidth', 1.5); hold on;
    semilogy(p_values, simResults(kIndex,:), 'o', 'Color', colors(kIndex,:), 'MarkerSize', 6);
end

xlabel('Packet Failure Probability (p)');
ylabel('Average Number of Transmissions');
title('All K Values - Calculated vs Simulated');
legendEntries = arrayfun(@(K) sprintf('K = %d', K), K_values, 'UniformOutput', false);
legend(legendEntries, 'Location', 'northwest');
grid on;