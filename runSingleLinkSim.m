function result = runSingleLinkSim(K,p,N) 
 
    simResults = ones(1,N); % a place to store the result of each simulation 
       for i=1:N 
            txAttemptCount = 0; % transmission count 
            pktSuccessCount = 0; % number of packets that have made it across 
         
            while pktSuccessCount < K 
                 
                r = rand;             
                txAttemptCount = txAttemptCount + 1; 
             
                % while packet transmissions is not successful (r < p)             
                while r < p 
                    r = rand; % transmit again, generate new success check value r                 
                    txAttemptCount = txAttemptCount + 1; % count additional attempt             
                end          
                pktSuccessCount = pktSuccessCount + 1; 
            end      
            simResults(i) = txAttemptCount; 
        end  
    result = mean(simResults);

end
