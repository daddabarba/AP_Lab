addpath("./AdditionalFunction/");
%{
%QEUSTION B
disp("QUESTION B");

plotresult(calc4(param4()));

n_start = 0.3177;
n_end = 0.7284;

p_start = n_start^4;
p_end = n_end^4;

disp("n_start = " + n_start + " -> p_start = n_start^4 = " + p_start);
disp("n_end = " + n_end + " -> p_end = n_end^4 = " + p_end);

%QUESTION C
wait();
disp("QUESTION C");

%Run simulation and plot
plotresult(calc4(param4()));
hold on;

%Value of n when t=tau
n_mid = (n_end - n_start)/2 + n_start;

%Plot mid life line
plot(xlim,[n_mid n_mid]);

hold off;

%QUESTION D
wait();
disp("QUESTION D");

%Compute alpha and beta for the two voltages
[alpha_1, beta_1, tau_1, ~] = alphabeta(-0.035);
[alpha_2, beta_2, tau_2, ~] = alphabeta(-0.065);

%Get values only for n
alpha_n_1 = alpha_1(1);
beta_n_1 = beta_1(1);
tau_n_1 = tau_1(1);

alpha_n_2 = alpha_2(1);
beta_n_2 = beta_2(1);
tau_n_2 = tau_2(1);

%Display results
disp("For V=-35 mV, we have alpha_n = " + alpha_n_1 +...
    ", beata_n = " + beta_n_1 + ", and tau_n = " + tau_n_1);
disp("For V=-65 mV, we have alpha_n = " + alpha_n_2 +...
    ", beata_n = " + beta_n_2 + ", and tau_n = " + tau_n_2);

%}
%QUESTION E
wait();
disp("QUESTION E");

%Set voltage intervals
Vs = -0.2:0.001:0.2;

%Initialize result vetor
taus = zeros(3,length(Vs));

%Compute time constants
for i = 1:length(Vs)
    
   %Get current voltage
   V = Vs(i);
   
   %Compute results
   disp("Computing time constants with V=" + V);
   [~,~,tau,~] = alphabeta(V);
   
   %Store results
   taus(:,i) = tau;
   
end

%Plot results
plot(Vs.*1000,taus.*1000);

%Set plot captions
title({"Time constants of gating probabilities", ...
    "as a function of Voltage"});

xlabel("Volatge (mV)");
ylabel("Time constant (ms)");

legend("tau_n", "tau_m", "tau_h");

%Set plot style
setPlotStyle();

%Compare taus at -V = -65mV
V = -0.065; %mV
tau_65 = taus(:,Vs == V);
disp("tau_n(-65mV) = " + tau_65(1) + ...
    ", tau_m(-65mV) = " + tau_65(2) + ...
    ", and tau_h(-65mV) = " + tau_65(3));

%Plot V = -65mV
hold on;

plot([V V].*1000,ylim);

hold off;


%QUESTION F
wait();
disp("QUESTION F");

plotresult(calc4(param4()));