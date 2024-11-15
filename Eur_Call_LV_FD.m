function V0 = Eur_Call_LV_FD(S0, K, T, r, x, Smax, M, N)
%
% Price the European call option of the LVF model by the explicit finite difference method.
% 
% Input
% S0 – initial stock price
% K – strike price
% T – maturity
% r – risk free interest rate
% x – vector parameters for the LVF σ, [x1, x2, x3]
% Smax – upper bound of the stock price
% M – number of stock price difference, i.e., δS = Smax/M
% N – number of time steps, i.e., δt = T /N.
%
% Output
% V0 – European call option price at t = 0 and S0.


    % Grid spacing
% Derived parameters
dS = Smax / M;  % Stock price step size
dt = T / N;     % Time step size

% Stock price grid
S = linspace(0, Smax, M+1)';

% Volatility function
sigma = @(S) max(0, x(1) + x(2)*S + x(3)*S.^2);

% Payoff at maturity (European call)
V = max(S - K, 0);

% Explicit finite difference method
for j = N:-1:1  % Step backwards in time
    V_new = V;
    for i = 2:M  % Exclude boundary points
        sigma_sq = sigma(S(i))^2;
        a = 0.5 * dt * (sigma_sq * i^2 - r * i);
        b = 1 - dt * (sigma_sq * i^2 + r);
        c = 0.5 * dt * (sigma_sq * i^2 + r * i);
        V_new(i) = a * V(i-1) + b * V(i) + c * V(i+1);
    end
    % Boundary conditions
    V_new(1) = 0;  % At S = 0, call value is 0
    V_new(M+1) = Smax - K * exp(-r * (T - (N-j+1)*dt));  % At Smax, linear payoff approximation
    V = V_new;
end

% Interpolate to find the price at S0
V0 = interp1(S, V, S0, 'linear');