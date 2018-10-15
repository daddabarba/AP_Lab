
%Initialize figure count and size
fig_cnt = 1;
fig_size = [0.2 0.2 0.8 0.8];

%Initialize font sizes
label_font_size = 24;
title_font_size = 24;

%QUESTION G)
disp("QUESTION G)");

%Default I_app
I_app = 0;

%Get Nernst potentials of sodium and potassium
pars = param2();

E_Na = pars.E_Na;
E_K = pars.E_K;

%Set ratios (G_Na/G_K) tested
r = [1/9, 1/4, 1, 4, 9];

%Compoute fractional conductances with respect to ratios
fracG = getFractionalConductance(r);

%Compute membrane potentials for fractional conductances
V_rs = restVF(fracG, E_Na, E_K);

%Display results
for i = 1:length(r)
   disp("With G_Na/G_K = " + r(i) + " V_r = " + V_rs(i) + ...
       " V [fractional conductance G_K/(G_Na+G_K) = " + fracG(i) +"]");
end

%Plot V_r as a function of fractional conductance
figure('name',int2str(fig_cnt),...
    'units','normalized','outerposition',fig_size);
fig_cnt = fig_cnt + 1;

x = 0:0.01:1;

plot(x, restVF(x, E_Na, E_K), 'LineWidth', 3);

%Plot V_r of ratios on plot
hold on;

plot(fracG, V_rs, '.', 'Markers', 36);

hold off;

%Set plot captions
title("Membrane potential in function of fractional conductance " + ...
    " G_K/(G_K+G_N_a)", 'FontSize', title_font_size);

xlabel("fractional conductance", 'FontSize', label_font_size);
ylabel("Membrane potential (V)", 'FontSize', label_font_size);

legend({"Membrane potantial", "Evaluation at given ratios"}, ...
    'FontSize', label_font_size);

%Set plot syle
setPlotStyle();

%Save plot
print(gcf,'Plots/q31_VFractional.png','-dpng','-r300');

%Plot V_r as a function of conductances ratio G_Na/G_K
figure('name',int2str(fig_cnt),...
    'units','normalized','outerposition',fig_size);
fig_cnt = fig_cnt + 1;

x = min(r):0.01:max(r);

plot(x, restVR(x, E_Na, E_K), 'LineWidth', 3);

%Plot V_r of ratios on plot
hold on;

plot(r, V_rs, '.', 'Markers', 36);

hold off;

%Set plot captions
title("Membrane potential in function of conductances ratio " + ...
    " G_N_a/G_K", 'FontSize', title_font_size);

xlabel("conductances ratio", 'FontSize', label_font_size);
ylabel("Membrane potential (V)", 'FontSize', label_font_size);

legend({"Membrane potantial", "Evaluation at given ratios"}, ...
    'FontSize', label_font_size, 'Location', 'southeast');

%Set plot syle
setPlotStyle();

%Save plot
print(gcf,'Plots/q31_VRatio.png','-dpng','-r300');

%FUNCTIONS

%Define Vr as a function of G_K/(G_K + G_Na) = f
function V_r = restVF(f, E_Na, E_K)
    V_r = (1-f)*E_Na + f*E_K;
end

%Define Vr as a function of G_Na/G_K = r
function V_r = restVR(r, E_Na, E_K)
    V_r = (r./(1+r))*E_Na + (1./(1+r))*E_K;
end

%Define G_K/(G_K + G_Na) in function of r = G_Na/G_K
function x = getFractionalConductance(r)
    x = 1./(1+r);
end