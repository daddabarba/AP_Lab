function [par]= param7 (I1,t_duration,t_delay,I2,I0)
%function [par]= param7 (I1,t_duration,t_delay,I2,I0)
% The units in this exercise are:
%  Voltage V, E        [mV]     because V = I/G [uA/mS] = [mV]
%  conductance G       [mS/cm^2]
%  capacitance C       [uF/cm^2]
%  current I           [uA/cm^2]
%  time, time const.   [ms]      because tau=C/G [uF/mS] = [ms]

par.studentname = studentname;
par.task = 7;
par.tsim=[0,200]; %ms
%par.tsteps=1000;

par.Gbar_Ca = 4.4;  %range 4.4 to 5.5
par.Gbar_K  =   8;  %range 8-15
par.G_L     =   2;  %range 0-4  %unit mS/cm2
par.C_m     =  20;  %range 5-20 %unit uF/cm2
par.taubar_w = 20;  %range 5 - 25 ms

%mV
par.E_Ca = 120;
par.E_K = -84; 
par.E_L = -60;  %-60
par.V_1 = -0;    %-1.2
par.V_2 = 18;   %18
par.V_3 = -0;    %2.0
par.V_4 = 30;

%comment to use voltage dependent tau_w
par.tau_w    = par.taubar_w;

%Starting values for the model state vector
%par.P_start = [par.E_K 0]; %Starting values

t_fistpulsestarts = 10;

%
if ~exist('I1','var')
        I1=200;               %Default value of the injected current (pA)
        warning('I1: injected current not defined, set to %2.2e nA/cm2',I1);
end
if ~exist('t_duration','var')
        t_duration = 10;
        warning('t_duration: stimulus duration not defined, set to %2.2e ms',t_duration);
end
if ~exist('I0','var')
        I0 = 0;
        warning('I0: DC current offset not defined, set to %2.2e ms',I0);
end
if ~exist('t_delay','var')
    t_delay=50;
    warning('t_delay: stimulus delay not defined, set to %2.2e ms',t_delay);
end
if ~exist('I2','var')
    I2=0;
    warning('I2: second stimulus amplitude set to: %2.2e nA/cm2',I2);
end

%establish the timing of the pulses
par.t_I1_start = t_fistpulsestarts;
par.t_I1_end   = par.t_I1_start + t_duration ;
par.t_I2_start = par.t_I1_start + t_delay; 
par.t_I2_end   = par.t_I2_start + t_duration; 

%set current values
par.I0 = I0;
par.I1 = I1;
par.I2 = I2;

%we calculate the stable point via an external function
par.P_start = ml_stablepoint (par,I0);
end