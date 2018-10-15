function [ alpha, beta, tau, pinf ] = alphabeta(V)
%function [ alpha, beta, tau, pinf ] = alphabeta(V)
%calculates transition rates,
%time constants,
%and steady state gating probability
%for Hodgkin-Huxley type channels. 
%
%voltage V is passed in volts (not milivolts)
%return variables have row 1: n; row 2: m; row 3: h
%
%this function is being used by calc4 and calc5
%but it can also be used to plot the respective variables,
%e.g.
%
%V=linspace(-0.1,0.1,100); [alpha beta tau pinf]=alphabeta(V); plot(V,tau);
%

%convert voltages (in V) to mV above resting potential (-65 mV);
u=(V*1000)+65;
u(u==10)=10.001; %poor man's taylor approximation ;-)
u(u==25)=25.001; %poor man's taylor approximation ;-)

alpha_n = 0.01.*(10-u)./(exp(1-u/10)-1);
beta_n  = 0.125.*exp(-u/80);
alpha_m = 0.1.*(25-u)./(exp(2.5-u/10)-1);
beta_m  = 4.*exp(-u/18);
alpha_h = 0.07.*exp(-u/20);   %0.700 or %0.070!!!
beta_h  = 1./(exp(3-0.1*u)+1);

%we return the rates with units (1/s)
alpha = [alpha_n; alpha_m ; alpha_h]*1000;
beta  = [beta_n ; beta_m  ; beta_h ]*1000;
tau   = 1./(alpha+beta);
pinf  = alpha.*tau;

end

