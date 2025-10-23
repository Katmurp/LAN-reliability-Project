%% Simulate Single Link Network
% Task 1 - Compare simulated vs. calculated average transmissions

clear; clc; close all;

K_values = [1, 5, 10];
N = 1000;
p_range = 0.01:0.05:0.99;

% Define each figure's static probabilities (p1, p2, p3)
cases = {
    [0.10, 0.60, NaN],  % Figure 1
    [0.60, 0.10, NaN],  % Figure 2
    [0.10, NaN, 0.60],  % Figure 3
    [0.60, NaN, 0.10],  % Figure 4
    [NaN, 0.10, 0.60],  % Figure 5
    [NaN, 0.60, 0.10]   % Figure 6
};

for c = 1:length(cases)
    fixed = cases{c};
    figure;
    hold on;
    colors = lines(length(K_values));

    for kIndex = 1:length(K_values)
        K = K_values(kIndex);
        avgTrans = zeros(size(p_range));

        for pIndex = 1:length(p_range)
            p_vals = fixed;
            % Replace NaN with the variable probability (the 1%-99% one)
            p_vals(isnan(p_vals)) = p_range(pIndex);

            avgTrans(pIndex) = runCustomCompoundNetworkSim(K, p_vals(1), p_vals(2), p_vals(3), N);
        end

        plot(p_range, avgTrans, '-', 'Color', colors(kIndex,:), 'LineWidth', 1.5);
        plot(p_range, avgTrans, 'o', 'Color', colors(kIndex,:), 'MarkerSize', 4);
    end

    set(gca, 'YScale', 'log');
    xlabel('Variable Link Failure Probability (p)');
    ylabel('Average Number of Transmissions');
    title(sprintf('Compound Network - Figure %d', c));
    legend(arrayfun(@(K) sprintf('K = %d', K), K_values, 'UniformOutput', false), 'Location', 'northwest');
    grid on;
end