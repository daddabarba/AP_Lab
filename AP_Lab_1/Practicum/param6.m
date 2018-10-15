 function [par]=param6(I1,t_duration,t_delay,I2,I0)
%function [par]=param6(I1,t_duration,I2,t_delay,I0)

%If not given, the first injection I1 is set to -100uA
if ~exist('I1','var')
   I1 = -1e-5;
   warning ('I1 set to %2.2e',I1); 
end

%If duration is not given it is set to 1 ms
if ~exist('t_duration','var')
    t_duration = 1e-3;
    warning ('t_duration set to %2.2e',t_duration);
end

%if I2 is not given, then the second pulse is set to 0
if ~exist('I2','var')
    I2=0;
    warning ('I2 set to %2.2e',I2);
end

%if delay is not given, then the second pulse comes 20 ms later
if ~exist('t_delay','var')
    t_delay=20e-3;
    warning ('t_delay set to %2.2e',t_delay);
end

%if the 5th parameter is not given, then base current I0 is zero
if ~exist('I0','var')
    I0=0;
    warning ('I0 set to %2.2e',I0);
end




    
    

par.studentname = studentname;
par.task = 6;
par.tsim = [0,0.050];

%Cell capacitance
par.C_m  = 1e-6;

%Conductances
par.Gbar_K =  36e-3;   %Max Conductivity of voltage-dependent K channels (S, Siemens)
par.Gbar_Na = 120e-3; %Max Conductivity of voltage-dependent Na channels (S, Siemens)
par.G_L =     0.3e-3;      %Conductivity of passive Cl channels (S, Siemens)

%Nernst potentials for the ions
par.E_K  = -77e-3; %-72
par.E_Na = +50e-3; %+55
par.E_L  = -55e-3; %-50

%Starting values for the probabilities m, n, h are set
%to those at -65 mV, an approximate resting potential
%with the Gbar_Na, Gbar_K and G_L values. 
par.V_start=-0.065;
[alpha beta tau pinf]=alphabeta(par.V_start);
par.P_start = [pinf]; 

%establish the timing of the pulses
par.t_I1_start = 10e-3;
par.t_I1_end   = par.t_I1_start + t_duration ;
par.t_I2_start = par.t_I1_start + t_delay; 
par.t_I2_end   = par.t_I2_start + t_duration; 
%set current values
par.I0 = I0;
par.I1 = I1;
par.I2 = I2;

%currents should normally be "depolarizing"
if I1>0 || I2>0
    warning('Currents should better be negative')
end