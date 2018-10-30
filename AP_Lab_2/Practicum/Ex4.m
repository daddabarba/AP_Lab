addpath("./AdditionalFunction/");
%%
%QEUSTION A
disp("QUESTION A");

plotresult(calc4);
%%
%QEUSTION B
wait();
disp("QUESTION B");

plotresult(calc4(param4()));

n_start = 0.3177;
n_end = 0.7284;

p_start = n_start^4;
p_end = n_end^4;

disp("n_start = " + n_start + " -> p_start = n_start^4 = " + p_start);
disp("n_end = " + n_end + " -> p_end = n_end^4 = " + p_end);

%%
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

%%
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

%%
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


%Compare taus at -V = -65mV
V = -0.065; %mV
tau_65 = taus(:,Vs == V);
disp("tau_n(-65mV) = " + tau_65(1) + ...
    ", tau_m(-65mV) = " + tau_65(2) + ...
    ", and tau_h(-65mV) = " + tau_65(3));

%Plot results
plot(Vs.*1000,taus.*1000, 'LineWidth', 3);

%Plot V = -65mV
hold on;

plot([V V].*1000,ylim, 'LineWidth', 3);

hold off;

%Set plot captions
title({"Time constants of gating probabilities", ...
    "as a function of Voltage"});

xlabel("Volatge (mV)");
ylabel("Time constant (ms)");

legend("tau_n", "tau_m", "tau_h", "-65 mV");

x_lim = xlim;
y_lim = ylim;
text(x_lim(1),y_lim(2),studentname);

%Set plot style
setPlotStyle();

%%
%QUESTION F
wait();
disp("QUESTION F");

plotresult(calc4(param4()));

%%
%QUESTION H
wait();
disp("QUESTION H");

%Set voltages values to test
Vs = -0.05:0.016:0.03;

%Run simulations
for i = 1:length(Vs)
    
   %Get current voltage
   V = Vs(i);
   
   %run simulation
   r = calc4(param4(V));
   
   %Plot results
   figure(1);
   
   hold on;
   plot(r.t,r.G_Na, 'LineWidth', 3);
   hold off;
   
   figure(2);
   hold on;
   plot(r.t,r.I_Na, 'LineWidth', 3);
   hold off;
   
end

figure(1);

%Set plot captions
title({"Sodium conductance as a function of time", ...
    "for different Voltage amplitudes"});

ylabel("Conductance (S)");
xlabel("Time (s)");

legend(strcat(string(Vs*1000), {' mV'}));

x_lim = xlim;
y_lim = ylim;
text(x_lim(1),y_lim(2),studentname);

%Set plot style
setPlotStyle();

figure(2);

%Set plot captions
title({"Sodium current as a function of time", ...
    "for different Voltage amplitudes"});

ylabel("Current (A)");
xlabel("Time (s)");

legend(strcat(string(Vs*1000), {' mV'}));

x_lim = xlim;
y_lim = ylim;
text(x_lim(1),y_lim(2),studentname);

%Set plot style
setPlotStyle();

%%
%QUESTION I
wait();
disp("QUESTION I");

%Set voltages values to test
Vs = -0.05:0.016:0.03;

%Run simulations
for i = 1:length(Vs)
    
   %Get current voltage
   V = Vs(i);
   
   %run simulation
   r = calc4(param4(V));
   
   %Plot results
   figure(1);
   
   hold on;
   plot(r.t,r.G_K, 'LineWidth', 3);
   hold off;
   
   figure(2);
   hold on;
   plot(r.t,r.I_K, 'LineWidth', 3);
   hold off;
   
end

figure(1);

%Set plot captions
title({"Potassium conductance as a function of time", ...
    "for different Voltage amplitudes"});

ylabel("Conductance (S)");
xlabel("Time (s)");

legend(strcat(string(Vs*1000), {' mV'}));

x_lim = xlim;
y_lim = ylim;
text(x_lim(1),y_lim(2),studentname);

%Set plot style
setPlotStyle();

figure(2);

%Set plot captions
title({"Potassium current as a function of time", ...
    "for different Voltage amplitudes"});

ylabel("Current (A)");
xlabel("Time (s)");

legend(strcat(string(Vs*1000), {' mV'}));

x_lim = xlim;
y_lim = ylim;
text(x_lim(1),y_lim(2),studentname);

%Set plot style
setPlotStyle();

%%
%QUESTION I
wait();
disp("QUESTION I");

%Set values of V1
V1s = [-100, -50, 0]*1e-3;

%Set V2 value
p = param4;
V2 = p.E_Na;

for V1 = V1s
   
    %Run simulation
    plotresult(calc4(param4(V1,0.01,V2,0.01)));
    wait();
end
