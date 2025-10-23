function result = runCustomCompoundNetworkSim(K, p1, p2, p3, N)

    simResults = zeros(1, N);

    for i = 1:N
        totalTransmissions = 0;
        for packet = 1:K
            success = false;
            transmissions = 0;

            % compound transmission continues until successful
            while ~success
                transmissions = transmissions + 1;

                link1_success = rand() > p1;
                link2_success = rand() > p2;
                parallel_success = link1_success || link2_success;

                link3_success = rand() > p3;

                success = parallel_success && link3_success;
            end

            totalTransmissions = totalTransmissions + transmissions;
        end
        simResults(i) = totalTransmissions;
    end

    result = mean(simResults);

end
