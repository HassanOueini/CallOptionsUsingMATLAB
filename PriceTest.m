%Price test
S0 = 1; K = 1; T = 0.25; r = 0.03; x = [0.2, 0.001, 0.003]; M = 10000; N = 100; 

V = Eur_Call_LVF_MC(S0, K, T, r, x, M, N);
fprintf('The option price using Monte Carlo is %f\n', V)

S0 = 1; K = 1; T = 0.25; r = 0.03; x = [0.2, 0.001, 0.003]; M = 30; N = 100; Smax = 3;

V0 = Eur_Call_LV_FD(S0, K, T, r, x, Smax, M, N);
fprintf('The option price using Finite difference is %f\n', V0)

