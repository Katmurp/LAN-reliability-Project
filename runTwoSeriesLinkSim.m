%% Function runSingleLinkSim() % Parameters 
%  K - the number of packets in the application message 
%  p - the probability of failure  
%  N - the number of simulations to run 
% 
% Returns: the average numeric result across the total simulations 
 
function result = runTwoSeriesLinkSim(K, p, N)
    simResults = ones(1, N);

    for i = 1:N
        txAttemptCount = 0;   
        pktSuccessCount = 0;  

        % Loop until all K packets transmitted successfully
        while pktSuccessCount < K
            success = false;

            % Keep trying this packet until it succeeds through both links
            while ~success
                txAttemptCount = txAttemptCount + 1;

                r1 = rand;
                r2 = rand;

                if (r1 > p) && (r2 > p)
                    success = true;  % both links succeeded
                end
            end

            pktSuccessCount = pktSuccessCount + 1;
        end

        simResults(i) = txAttemptCount;
    end

    result = mean(simResults);
end