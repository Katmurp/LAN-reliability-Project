%% Function runSingleLinkSim() % Parameters 
%  K - the number of packets in the application message 
%  p - the probability of failure  
%  N - the number of simulations to run 
% 
% Returns: the average numeric result across the total simulations 
 
function result = runCompoundNetworkSim(K, p, N)
    simResults = ones(1, N);

    for i = 1:N
        txAttemptCount = 0;
        pktSuccessCount = 0;

        % Loop until all K packets are transmitted successfully
        while pktSuccessCount < K
            success = false;

            % Keep trying this packet until it succeeds
            while ~success
                txAttemptCount = txAttemptCount + 1;

                % --- Top branch (two series links)
                topLink1 = rand > p;
                topLink2 = rand > p;
                topSuccess = topLink1 && topLink2;

                % --- Bottom branch (two series links)
                bottomLink1 = rand > p;
                bottomLink2 = rand > p;
                bottomSuccess = bottomLink1 && bottomLink2;

                % Packet succeeds if at least one branch works
                if topSuccess || bottomSuccess
                    success = true;
                end
            end

            pktSuccessCount = pktSuccessCount + 1;
        end

        simResults(i) = txAttemptCount;
    end

    result = mean(simResults);
end