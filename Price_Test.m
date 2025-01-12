%File to test out different parameters. 
S0 = 100; 
K = 100; 
T = 1; 
r = 0.05; 
sigma = 0.2; 
M = 200;
N = 1000;

%Using blsprice
[Call, Put] = blsprice(S0, K, r, T, sigma);
fprintf('Exact Call Option Value using blsprice: %f\n', Call);

%Using Monte Carlo method
OptionValue = Eur_Call_MC(S0, K, T, r, sigma, M, N);
fprintf("Call option value using Monte Carlo is %f\n", OptionValue);

%Using Crank-Nicolson method
V = Eur_Call_Crank_Nicolson(S0, K, T, r, sigma, M, N);
fprintf("Call option value using Crank-Nicolson is %f\n", V);