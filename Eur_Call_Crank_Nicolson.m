function V = Eur_Call_Crank_Nicolson(S0, K, T, r, sigma, M, N)
    % Price a European call option using the Crank-Nicolson method
    %
    % Input:
    % S0 – initial stock price
    % K – strike price
    % T – maturity
    % r – risk-free interest rate
    % sigma – volatility
    % M – number of asset price steps
    % N – number of time steps
    %
    % Output:
    % V – European call option price at t = 0 and S0

    % Parameters
    Smax = 2 * S0;                % Maximum stock price
    dS = Smax / M;                % Stock price step
    dt = T / N;                   % Time step
    S = linspace(0, Smax, M+1)';  % Stock price grid

    % Terminal condition: max(S-K, 0)
    V = max(S - K, 0);

    % Crank-Nicolson coefficients
    j = (0:M)';  % Index for the stock price steps
    alpha = 0.25 * dt * (sigma^2 * j(2:end-1).^2 - r * j(2:end-1));
    beta = -0.5 * dt * (sigma^2 * j(2:end-1).^2 + r);
    gamma = 0.25 * dt * (sigma^2 * j(2:end-1).^2 + r * j(2:end-1));

    % Tridiagonal matrix coefficients
    A = diag(1 - beta) + diag(-alpha(2:end), 1) + diag(-gamma(1:end-1), -1);
    B = diag(1 + beta) + diag(alpha(2:end), 1) + diag(gamma(1:end-1), -1);

    % Time stepping
    for t = N:-1:1
        % Solve linear system: A*V_new = B*V_old
        V(2:end-1) = A \ (B * V(2:end-1));
    end

    % Interpolation to find the price at S0
    V = interp1(S, V, S0, 'linear');
end
