function V = Eur_Call_MC(S0, K, T, r, sigma, M, N)

% Price the European call option of the LVF model by the Monte Carlo method
%
% Input
% S0 – initial stock price
% K – strike price
% T – maturity
% r – risk free interest rate
% sigma - volitality 
% M – number of simulated paths
% N – number of time steps, i.e., δt = T /N.

    % Time step
    dt = T / N;

    % Initialize matrix to store simulated paths
    S = zeros(M, N+1);
    S(:, 1) = S0;  % Set initial asset price

    % Random increments: standard normal random variables
    dW = sqrt(dt) * randn(M, N);

    % Simulate M paths, each with N steps
    for i = 2:N+1
        S(:, i) = S(:, i-1) .* exp((r - 0.5 * sigma^2) * dt + sigma * dW(:, i-1));
    end

    % Compute payoffs for the call option at maturity
    callPayoffs = max(S(:, end) - K, 0);

    % Discount payoffs to present value
    V = exp(-r * T) * mean(callPayoffs);
end