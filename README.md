# Call Option Pricing Methods using MATLAB

This repository contains an overview of three different methods for pricing European call options:
1. **Black-Scholes Formula** (Analytical Approach)
2. **Crank-Nicolson Method** (Numerical PDE Solver)
3. **Monte Carlo Simulation** (Stochastic Approach)

## 1. Black-Scholes Formula (Analytical Approach)

The price of a European call option using the Black-Scholes formula is given by:

$$ C = S_0 \Phi(d_1) - K e^{-rT} \Phi(d_2) $$

Where:
- \( S_0 \): Initial stock price
- \( K \): Strike price
- \( T \): Time to maturity
- \( r \): Risk-free interest rate
- \( $\Phi(x)$ \): Cumulative distribution function of the standard normal distribution
- \( $\sigma$ \): Volatility of the underlying asset

The terms $d_1$ and $d_2$ are defined as:

$$
\begin{aligned}
d_1 &= \frac{\ln(S_0 / K) + \left(r + \frac{\sigma^2}{2}\right)T}{\sigma \sqrt{T}}, \\
d_2 &= d_1 - \sigma \sqrt{T}
\end{aligned}
$$

## 2. Crank-Nicolson Method (Numerical PDE Solver)

The Black-Scholes partial differential equation (PDE) is:

$$
\frac{\partial V}{\partial t} + \frac{1}{2} \sigma^2 S^2 \frac{\partial^2 V}{\partial S^2} + r S \frac{\partial V}{\partial S} - r V = 0
$$

### Discretized Crank-Nicolson Scheme

The Crank-Nicolson method discretizes the PDE into:

$$
A V^{n+1} = B V^n 
$$

Where:
- $A$ and $B$ are tridiagonal matrices representing the spatial derivative discretization.
- $V^n$ and $V^{n+1}$ are the option values at times $t^n$ and $t^{n+1}$.

This method solves the system iteratively backward in time from $T$ to $t = 0$.

## 3. Monte Carlo Simulation (Stochastic Approach)

The Monte Carlo method simulates the stock price under the **geometric Brownian motion (GBM)** model:

$$
dS_t = r S_t \, dt + \sigma S_t \, dW_t
$$

Where:
- r: Risk-free interest rate.
- $\sigma$: Volatility.
- $W_t$: Standard Brownian motion.

### Discretized GBM Solution

$$
S_{i+1} = S_i \exp\left(\left(r - \frac{\sigma^2}{2}\right)\Delta t + \sigma \sqrt{\Delta t} Z_i\right)
$$

Where:
- $Z_i$: Independent standard normal random variables.

### Option Price Using Monte Carlo

The option price is calculated as the discounted expected payoff:

$$
V \approx e^{-rT} \frac{1}{M} \sum_{i=1}^M \max(S_T^{(i)} - K, 0)
$$

Where:
- M: Number of simulated paths.
- $S_T^{(i)}$: Terminal stock price for the \( i \)-th path.

## Summary of Methods

| **Aspect**          | **Black-Scholes**              | **Crank-Nicolson**              | **Monte Carlo**                 |
|---------------------|--------------------------------|--------------------------------|---------------------------------|
| **Type**           | Analytical solution            | Numerical PDE solver           | Stochastic simulation          |
| **Key Inputs**     | \( S_0, K, T, r, $\sigma$ \)     | \( S_0, K, T, r, $\sigma$, $\Delta S$, $\Delta t$ \) | \( S_0, K, T, r, $\sigma$, M, N \) |
| **Speed**          | Very fast                     | Moderate                       | Slower (depends on simulations)|
| **Accuracy**       | Exact (under assumptions)      | Approximate (grid-dependent)   | Approximate (path-dependent)   |
| **Flexibility**    | Limited (constant volatility)  | Flexible (exotics/features)    | Highly flexible                |
