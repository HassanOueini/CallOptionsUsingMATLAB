function V = Eur_Call_LVF_MC(S0, K, T, r, x, M, N)

% Price the European call option of the LVF model by the Monte Carlo method
%
% Input
% S0 – initial stock price
% K – strike price
% T – maturity
% r – risk free interest rate
% x – vector parameters for the LVF σ, [x1, x2, x3]
% M – number of simulated paths
% N – number of time steps, i.e., δt = T /N.
%
% Output
% V – European call option price at t = 0 and S0.
    % Extract parameters from vector x, assuming the first element is volatility

    S0 = 1; K = 1; T = 0.25; r = 0.03; x = [0.2, 0.001, 0.003]; M = 10000;  N = 100;
    sigma = x(1);

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
