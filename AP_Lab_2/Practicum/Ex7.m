addpath("./AdditionalFunction");
%%
%QUESTION A
disp("QUESTION A");

%Plot default graph
plotresult(calc7(param7));

%%
%QUESTION B
disp("QUESTION B");

%Set current amplitudes
Is = 0:20:200;

%Init result vector
maxV = zeros(1,length(Is));

for i = 1:length(Is)
   %Get current
   I = Is(i);
   
   %Run simulation
   r = calc7(param7(I));
   
   %Store maximum voltage
   maxV(i) = max(r.V);
end

%Plot second peak amplitude as a function of delay
plot(Is,maxV, 'o-');

%Set plot captions
title({"Peak voltage from second injected impulse", ...
    "with respect to injected current amplitude"});

xlabel("Stimulus Amplitude (\muA/cm^2)");
ylabel("peak voltage (mV)");

x_lim = xlim;
y_lim = ylim;
text(x_lim(1),y_lim(2),studentname);

%Set plot style
setPlotStyle();

%%
%QUESTION C
wait();
disp("QUESTION C");

%Below threshold simulation
disp("Below threshold simulation");
I1 = 120; %muA/cm^2
plotresult(calc7(param7(I1)));

%Above threshold simulation
wait();
disp("Above threshold simulation");
I1 = 160; %muA/cm^2
plotresult(calc7(param7(I1)));

%%
%QUESTION D
wait();
disp("QUESTION D");

%Set pulses amplitude during pulse and at rest
I = 300; %muA/cm^2
I0 = 0; %A/cm^2

%Set pulses duration
t = 5; %ms

%Set pulses delays (to be plotted)
delays = [100 50 40 30 15];

%Phase plot of some delays delays
for i = 1:length(delays)
    
    %Get delay time
    delay = delays(i);
   
    %Run simulation
    disp("Running two current pulses of 300 uA/cm^2. with " + ...
        delay + "ms delay");
    
    sim = calc7(param7(I, t, delay, I, I0));
    plotresult(sim);
    
    wait();
    
end

%Set pulses delays (to be tested)
delays = 10:5:100;

%Initialize array of peaks in function of delay
peaks = zeros(1, length(delays));

%Test delays
for i = 1:length(delays)
    
    %Get delay time
    delay = delays(i);
   
    %Run simulation
    disp("Running two current pulses of 300 uA/cm^2. with " + ...
        delay + "ms delay");
    
    sim = calc7(param7(I, t, delay, I, I0));
    
    %Get peaks values
    [v_peaks, t_peaks] = getPeak(sim.V);
    
    %Store resutls
    peaks(i) = v_peaks(t_peaks == max(t_peaks));
    
end

%Plot second peak amplitude as a function of delay
plot(delays, peaks, 'o-');

%Set plot captions
title({"Peak voltage from second injected impulse", ...
    "with respect to impulses delay"});

xlabel("delay (ms)");
ylabel("peak voltage (mV)");

x_lim = xlim;
y_lim = ylim;
text(x_lim(1),y_lim(2)-2,studentname);

%Set plot style
setPlotStyle();

%%
%QUESTION E
wait();
disp("QUESTION E");

T = 39; %ms
%Below threshold delay
disp("response with 2 300 uA/cm^2 pulses with delay " + (T-1) + " ms");
plotresult(calc7(param7(I, t, T-1, I, I0)));

%Above threshold delay
wait();
disp("response with 2 300 uA/cm^2 pulses with delay " + (T) + " ms");
plotresult(calc7(param7(I, t, T, I, I0)));

%%
%QUESTION F
wait();
disp("QUESTION F");

%P_start chosen values
P_starts = [-70 1e-5; ...
    -80 0.5; ...
    -40 0.5; ...
    60 0.2; ...
    20 0.15];

%Run simulations with P_start values
%Test delays
for i = 1:size(P_starts, 1)
    
    %Get P_start
    P_start = P_starts(i,:);
   
    %Run simulation
    disp("Running simulation with starting state V=" + ...
        P_start(1) + " w=" + P_start(2));
    
    plotresult7(0, P_start, 2000);
    
    wait();
end

%%
%QUESTION G
wait();
disp("QUESTION G");

%I0 values
I0s = 0:50:300; %muA/cm^2

%Loop over values
for I0 = I0s
    
    %Run simulation
    disp("Running simulation with I0=" + I0);
    plotresult7(I0, [], 6000);
    
    wait();
    
end

%Set threshold
T_min = 118;
T_max = 251;

%Show threshold value
disp("Running simulation with I0=" + (T_min-1) + "(before threshold interval)");
plotresult7(T_min-1, [], 6000);

wait();
disp("Running simulation with I0=" + T_min + "(in threshold interval)");
plotresult7(T_min, [], 6000);
wait();

disp("Running simulation with I0=" + T_max + "(in threshold interval)");
plotresult7(T_max, [], 6000);
wait();

disp("Running simulation with I0=" + (T_max + 1) + "(after threshold interval)");
plotresult7(T_max+1, [], 6000);

%%
%QUESTION H
wait();
disp("QUESTION H");

%Run simulation with given parameters
p = param7(10,5,0,0,150);
r = calc7(p);
plotresult(r);

%Compute eigenvalues
J = getJacobian(r.V(1),r.w(1),p);
lambda = eig(J);

disp("The Jacobian matrix is: ");
disp(J);
disp("The eigenvalues are: ");
disp(lambda);

%%
%QUESTION I
wait();
disp("QUESTION I");

%Set I0 values to test out
I0s = 118:1:251;

%Initialize result vector
frequencies = zeros(1,length(I0s));

for i = 1:length(I0s)
    
    %Get current I0
    I0 = I0s(i);
    
    %Run simulation with given parameters
    disp("Running simulation with I0=" + I0);
    r = plotresult7(I0, [], 6000);
    
    %Compute and store frequency
    frequencies(i) = getFrequency(r.V,r.t);
end

close all;

%Plot potential frequency as a function of I0
plot(I0s, frequencies, 'o-');

%Set plot captions
title({"Frequency of membrane voltage", ...
    "with respect to injected current amplitude"});

xlabel("Injected current amplitude ({\mu}A/cm^2)");
ylabel("voltage frequency (mHz = 1/ms)");

x_lim = xlim;
y_lim = ylim;

hold on;
text(x_lim(1),y_lim(2),studentname);
hold off;

%Set plot style
setPlotStyle();

%%