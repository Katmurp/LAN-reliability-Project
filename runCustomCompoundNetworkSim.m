%% Function runSingleLinkSim() % Parameters 
%  K - the number of packets in the application message 
%  p - the probability of failure  
%  N - the number of simulations to run 
% 
% Returns: the average numeric result across the total simulations 
 
function result = runCustomCompoundNetworkSim(K, p1, p2, p3, N)

    simResults = zeros(1, N);

    for i = 1:N
        totalTransmissions = 0;
        for packet = 1:K
            success = false;
            transmissions = 0;

            % Each compound transmission continues until successful
            while ~success
                transmissions = transmissions + 1;

                % simulate the compound network structure:
                % (two parallel links) in series with one link
                %
                % For simplicity:
                % success = ( (parallel success between link1 & link2) ) AND (link3 success)
                %
                % Link1 and Link2 form parallel portion; Link3 is series.

                link1_success = rand() > p1;
                link2_success = rand() > p2;
                parallel_success = link1_success || link2_success;

                link3_success = rand() > p3;

                % Successful if both parallel portion and link3 succeed
                success = parallel_success && link3_success;
            end

            totalTransmissions = totalTransmissions + transmissions;
        end
        simResults(i) = totalTransmissions;
    end

    % Return the average number of transmissions across simulations
    result = mean(simResults);
end