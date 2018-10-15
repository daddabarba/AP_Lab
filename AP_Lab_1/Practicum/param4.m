function [par,ode]=param4(V1,t_duration,V2,t_delay,V0)
%excersise 4
%parameters for HH voltage clamp experiment
%
%function [par,ode]=param4(V1,t_duration,V2,t_delay,V0)
%
%you can pass up to 4 parameters: pulse voltage and duration
%postpulse voltage, delay between the starts of the two pulses
%and the resting potential; when resting potential is not given,
%it is set to -65 mV.

par.studentname = studentname;
par.task = 4;
par.tsim = [0,0.050];
%par.tsteps=1000;

%cell properties
par.Gbar_Na = 120e-3; %Max Conductivity of voltage-dependent channels (S, Siemens)
par.Gbar_K  = 36e-3;  
par.E_Na = +0.050;    %Reversal potentials
par.E_K  = -0.080;


if ~exist('V0','var')
    V0 = -0.065;
    warning('Resting potential is %2.2e',V0);
end

if ~exist('V1','var')
    V1 = -0.035; 
    warning ('V1 not given, set to %2.2e',V1)
end

if ~exist('t_duration','var')
    t_duration=20e-3;
    warning('t_duration not given, set to %2.2e',t_duration);    
end

if ~exist('V2','var')
    V2 = V0;
    warning('V2 not given, set to %2.2e',V0);
    end

if ~exist('t_delay','var')
    t_delay=t_duration;
    warning('t_delay not given, set to %2.2e',t_delay);  
    end

t_V1_start=5e-3;

%calculate intial values for probabilities m, n, h
[alpha, beta] = alphabeta (V0);
par.P_start = (1+1e-6*randn).*(alpha./(alpha+beta))';

par.V0       = V0;
par.V1       = V1;
par.V2       = V2;
par.t_V1_start = t_V1_start;                     %Start time (s) for the clamp pulse
par.t_V1_end   = t_V1_start+t_duration;          %End time (s)   for the clamp pulse
par.t_V2_start = t_V1_start+t_delay;
par.t_V2_end   = t_V1_start+t_duration+t_delay;