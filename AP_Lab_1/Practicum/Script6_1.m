%% for convience, since copying code from pdf needs manual formatting
%single pulses 7.5, 3.75 and 15 uA, always 1 ms;
r1=calc6(param6( -7.50e-6, 1e-3));
r2=calc6(param6( -3.75e-6, 1e-3));
r3=calc6(param6(-15.00e-6, 1e-3));
%doble pulses with 15 or 20 ms delay, with 7.5 or 15 uA
r4=calc6(param6(-7.50e-6, 1e-3, 15e-3, -7.5e-6));
r5=calc6(param6(-7.49e-6, 1e-3, 20e-3, -7.5e-6));
r6=calc6(param6(-7.51e-6, 1e-3, 15e-3, -15e-6));
%plot single pulses above
figure(1); clf; subplot(221); plot(r1.t,r1.V_m, r2.t,r2.V_m, r3.t,r3.V_m);
title ('Single pulse simulation'); ylabel('V_m (V)');
subplot(223); plot(r1.t,r1.I_inj, r2.t,r2.I_inj, r3.t,r3.I_inj); 
legend('I_{inj}=-7.5uA','I_{inj}=-3.75uA','I_{inj}=-15uA'); ylabel('I_{inj} (A)'); xlabel('Time (s)');
%plot double pulses below
subplot(222); plot(r4.t,r4.V_m, r5.t,r5.V_m, r6.t,r6.V_m);
title('Double 1ms pulse simulation, first pulse: I_{inj1}=7.5uA');
subplot(224); plot(r4.t,r4.I_inj, r5.t,r5.I_inj, r6.t,r6.I_inj);
xlabel('Time (s)'); legend('t_d=15ms, I_{inj2}=7.5uA','t_d=20ms, I_{inj2}=7.5uA', ...
    't_d=15ms, I_{inj2}=15uA');
text(0,0,studentname) %signature