
%QUESTION 2.A)
disp("QUESTION 2.A)");

%Set body tempreature
T = 310; %K

%Set Na charge
z = 1;

%Set normal Na external concentration in blood
Na_ext = 140e-3;    %M
Na_int = 5e-3;      %M

%i) Compute Nernst potential for normal blood condition
normal_Nerst = nernst(z, Na_ext, Na_int, T);
disp("The normal Nernst potential of Na in the blood is " ...
    + normal_Nerst + " V");

%Set hypernatremia Na external concentration in blood
Na_ext = 160e-3;    %M

%i) Compute Nernst potential for normal blood condition
hypernatremia_Nerst = nernst(z, Na_ext, Na_int, T);
disp("The Nernst potential of Na in the blood with hypernatremia is " ...
    + hypernatremia_Nerst + " V");

%Set hyponatremia Na external concentration in blood
Na_ext = 120e-3;    %M

%i) Compute Nernst potential for normal blood condition
hyponatremia_Nerst = nernst(z, Na_ext, Na_int, T);
disp("The Nernst potential of Na in the blood with hyponatremia is " ...
    + hyponatremia_Nerst + " V");


%QUESTION 2.C)
disp("QUESTION 2.C)");

%Compute and plot simulation result with defualt parameters
data = calc2();
plotresult(data);

%Save plot
print(gcf,'Plots/q23_defPlot.png','-dpng','-r300');

%Get start and end index of impulse
impulse_idxs = find(data.I_inj<0);

start_i = impulse_idxs(1);
end_i = impulse_idxs(length(impulse_idxs));

%Print voltage value at equilibriums
disp("Without injection current, the equilibrium value is " ...
    + data.V_m(start_i) + " V");
disp("With injection current, the equilibrium value is " ...
    + data.V_m(end_i) + " V");

%QUESTION 2.D)
disp("QUESTION 2.D)");

%Compute Injection current such that the equilibrium voltage is V_m = 0
pars = param2();

I0 = pars.E_Na * pars.G_Na;

%Display result
disp("With an injection current of " + I0 + ...
    " A, the equilibrium state is V_m = 0 V");

%Compute and plot resulting simulations
plotresult(calc2(param2(I0)));

%Save plot
print(gcf,'Plots/q24_rest0.png','-dpng','-r300');


%QUESITION 2.E)
disp("QUESTION 2.E)");

%Set default I_inj
I_inj = -1e-7;      %A

%Set new G_Na
G_Na_temp = 2e-6;   %S

%Compute and plot simulation result with defualt parameters
data = calc2(param2(I_inj, 0, G_Na_temp));
plotresult(data);

%Save plot
print(gcf,'Plots/q23_GNa2.png','-dpng','-r300');

%Get start and end index of impulse
impulse_idxs = find(data.I_inj<0);

start_i = impulse_idxs(1);

%Print voltage value at equilibriums
disp("Without injection current, and G_Na = " + G_Na_temp + ...
    ", the equilibrium value is " + data.V_m(start_i) + " V");

%Set new G_Na
G_Na_temp = 0.5e-6;   %S

%Compute and plot simulation result with defualt parameters
data = calc2(param2(I_inj, 0, G_Na_temp));
plotresult(data);

%Save plot
print(gcf,'Plots/q23_GNa05.png','-dpng','-r300');

%Get start and end index of impulse
impulse_idxs = find(data.I_inj<0);

start_i = impulse_idxs(1);

%Print voltage value at equilibriums
disp("Without injection current, and G_Na = " + G_Na_temp + ...
    ", the equilibrium value is " + data.V_m(start_i) + " V");

%QUESITION 2.F)
disp("QUESTION 2.F)");

%Set default I_inj
I_inj = -1e-7;      %A

%Set new G_Na
G_Na_temp = 0;      %S

%Compute and plot simulation result with defualt parameters
data = calc2(param2(I_inj, 0, G_Na_temp));
plotresult(data);

%Save plot
print(gcf,'Plots/q23_GNa0.png','-dpng','-r300');

%Get start and end index of impulse
impulse_idxs = find(data.I_inj<0);

start_i = impulse_idxs(1);

%Print voltage value at equilibriums
disp("Without injection current, and G_Na = " + G_Na_temp + ...
    ", the equilibrium value is " + data.V_m(start_i) + " V");