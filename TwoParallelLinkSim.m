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
        
        simResults(kIndex, pIndex) = runTwoParallelLinkSim(K, p, N);
        
        % A packet fails only if BOTH links fail -> p_effective = p^2
        % Expected transmissions per packet = 1 / (1 - p^2)
        % Total expected = K / (1 - p^2)
        calcResults(kIndex, pIndex) = K / (1 - p^2);
    end
    
    % Plot for each K
    figure;
    semilogy(p_values, calcResults(kIndex,:), '-', 'Color', colors(kIndex,:), 'LineWidth', 1.5); hold on;
    semilogy(p_values, simResults(kIndex,:), 'o', 'Color', colors(kIndex,:), 'MarkerSize', 6);
    xlabel('Packet Failure Probability (p)');
    ylabel('Average Number of Transmissions');
    title(sprintf('Two Parallel Link Network Simulation (K = %d)', K));
    legend('Calculated', 'Simulated', 'Location', 'northwest');
    grid on;
end

% Combined plot for all K
figure;
for kIndex = 1:length(K_values)
    semilogy(p_values, calcResults(kIndex,:), '-', 'Color', colors(kIndex,:), 'LineWidth', 1.5); hold on;
    semilogy(p_values, simResults(kIndex,:), 'o', 'Color', colors(kIndex,:), 'MarkerSize', 6);
end

xlabel('Packet Failure Probability (p)');
ylabel('Average Number of Transmissions');
title('Two Parallel Link Network - All K Values');
legendEntries = arrayfun(@(K) sprintf('K = %d', K), K_values, 'UniformOutput', false);
legend(legendEntries, 'Location', 'northwest');

grid on;
