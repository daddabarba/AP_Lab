addpath("./AdditionalFunction/");
%%
%QEUSTION A
disp("QUESTION A");

r = calc6;
plotresult(r);

min_V = min(r.V_m);
max_V = max(r.V_m);

disp("The Nernst potentials are E_Na = " + r.E_Na + ...
    " V and E_K = " + r.E_K + " V");
disp("The minimum voltage is " + min_V + " V");
disp("The maximum voltage is " + max_V + " V");

%%
%QEUSTION B
wait();
disp("QUESTION B");

%Slope form plot
slope = (-0.0644 + 0.06515)/(0.01008 - 0.01);

%Slope from differential equation

r = calc6;

slope_diff = -(1/r.C_m)*...
    (r.G_K(1)*(r.V_m(1) - r.E_K) + ...
    r.G_Na(1)*(r.V_m(1) - r.E_Na) + ...
    r.G_L*(r.V_m(1) - r.E_L) + ...
    r.I1);

%Display results
disp("Slope approximated from plot is " +slope);
disp("Slope from differential equation is " +slope_diff);

%%
%QEUSTION C
wait();
disp("QUESTION C");

%Set current amplitudes
Is = -1*(0:(3e-4/100):3e-4);

%Init measurements
tMax = zeros(1,length(Is));

for i = 1:length(Is)
    
    %Get current
    I = Is(i);
    
    %Run simulation
    r = calc6(param6(I, 1e-4));
    
    %Find time to get to max value
    [V,t] = max(r.V_m);
    
    %Convert to seconds
    tMax(i) = r.t(t);
    
    %Check if action potental occurred (Voltage increases after end of pulse)
    if( abs(r.t_I1_end - tMax(i))< 1e-4 )
        tMax(i) = 0;
    end

end


%Plot second peak amplitude as a function of delay
plot(Is, tMax*1000, 'o-');

hold on;
plot(xlim, [tMax(length(tMax))*1000 tMax(length(tMax))*1000])
hold off;

disp("Last tMax: " + tMax(length(tMax))*1000);
disp("Highest tMax: " + max(tMax)*1000);

%Set plot captions
title({"Time at maximum voltage as a function of pulse amplitude"});

ylabel("Time (ms)");
xlabel("I_{inj} (A)");

x_lim = xlim;
y_lim = ylim;
text(x_lim(1),y_lim(2),studentname);

%Set plot style
setPlotStyle();


%%
%QEUSTION D
wait();
disp("QUESTION D");

%Set current amplitudes
Is = (-2.3e-6):(1e-8):(-2.2e-6);

%Init measurements
minI = 0;

for i = 1:length(Is)
    
    %Get current
    I = Is(i);
    
    %Run simulation
    r = calc6(param6(I, 3e-2));
    
    %Find time to get to max value
    [V,t] = max(r.V_m);
    
    %Convert to seconds
    tMax(i) = r.t(t);
    
    %Check if action potental occurred (Voltage increases after end of pulse)
    if( V>0)
        minI = I;
    end

end

disp(" rheobase current: " + minI + " A");

wait();
plotresult(calc6(param6(minI, 3e-2)));
wait();
plotresult(calc6(param6(minI - 1e-6, 3e-2)));
wait();
plotresult(calc6(param6(minI + 1e-6, 3e-2)));

%Set current amplitudes
durations = 7.2e-3:1e-5:7.3e-3;

%Init measurements
minDuration = 0;

for i = 1:length(durations)
    
    %Get current
    duration = durations(i);
    
    %Run simulation
    r = calc6(param6(minI, duration));
    
    %Find time to get to max value
    [V,t] = max(r.V_m);
    
    
    %Convert to seconds
    tMax(i) = r.t(t);
    
    %Check if action potental occurred (Voltage increases after end of pulse)
    if( V>0)
        minDuration = duration;
        break;
    end

end

disp("Minimum duration: " + minDuration);
wait();
plotresult(calc6(param6(minI, minDuration)));

%%
%QEUSTION E
wait();
disp("QUESTION E");

factors = [1 2 3];

for f = factors
   plotresult(calc6(param6(0,0,0,0,minI*f)));
   wait();
end

%%
%QEUSTION F
wait();
disp("QUESTION F");

figure(1);

%Set amplitudes
Is = 10*minI:(-9*minI/3):minI;

%Set pulse duration vlaues
durations = [3.5e-3, 6e-3];

%Initialize legend names
lgd = cell(1,length(Is)*length(durations));

cnt = 1;

for duration = durations
   
    for I = Is
       %Run simulation
       r = calc6(param6(I, duration));

       %Plot results
       plot3(r.V_m, r.m, r.h, 'LineWidth', 3);

       hold on;
       
       lgd{cnt} = "I=" + I*1e6 + "uA, t=" + duration*1000 + " ms";
       cnt = cnt + 1;
    end
end

hold off;

%Set plot captions

title({"(V,m,h) trajectories for different stimulus amplitudes", ...
    "and different durations of the stimulus pulse"});

xlabel("Voltage (V)");
ylabel("m");
zlabel("h");

legend(lgd);

%Set plot style
setPlotStyle();

view(5,15);

%%
%QEUSTION G
wait();
disp("QUESTION G");

%Set delay values
refPeriod = 14.13e-3; %ms

plotresult(calc6(param6(-100e-6,0.1e-3,refPeriod - 2e-3,-100e-6)));

%%
%QEUSTION H
wait();
disp("QUESTION H");

%Set delay values
refPeriod = 14.13e-3; %ms

plotresult(calc6(param6(-1e-3,0.1e-3,4e-3,-1e-3)));
wait();
plotresult(calc6(param6(-1e-3,0.1e-3,6e-3,-1e-3)));


