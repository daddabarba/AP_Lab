function out = calc1(in)
%excersise 1: RC model cell
%function out = calc1(in)
%Primoz Pirih, Sietse van Netten 2014

if ~exist('in','var')
    in=param1
    warning('No parameter set passed. Using defaults. ');
end

if isfield('in','I_inj')
    error('Deprecated: I_inj is defined as a stimulation parameter.\n Use I_1 instead.'); 
end

%copy the input parameters to the cointainer "out"
out=in;

%make the parameter container "par" visible to the subfunctions
global par; par=in;

%make the timesteps
if isfield(in,'tsteps')
   par.tsim=linspace(in.tsim(1),in.tsim(2),in.tsteps);
else
   par.tsim=in.tsim;
end



%main part of the function: call the solver
tic
[t,V_m] = ode23 (@dVdt,par.tsim,par.V_m_start,odeparam(1e-4,1e-5)); %3d parameter: odeparam
toc

%prepare output

%put the time points and the membrane voltage timecourse into "out"
out.t  =t;
out.V_m=V_m;

%postprocessing
%put the stimulation (I_1) derived (I_c,I_r) parameters into "out"
out.I_inj = I_inj(t,    par);
out.I_c =   I_c  (t,V_m,par);
out.I_r =   I_r    (V_m,par);
out.I_m = out.I_c + out.I_r;

end %main function



%the derivative function dV/dt this function is called by ODE23
%it further calls the I_1 function
function y = dVdt(t,V_m); global par
         y = -1./par.C_m .* (I_inj(t,par) + V_m / par.R_m);
end

%current pulse
function y = I_inj(t,par)
    if ~isfield (par,'tvlist')
        y = par.I1 .* (t > par.t_I1_start & t < par.t_I1_end);
    %we use the time/value list provided in the parameters
    else y = pwl (t,par.tvlist);
    end
end

%these functions are used in post-processing only
%resistive current is calculated directly as V_m/R_m
function y = I_r(V_m,par)
         y = V_m / par.R_m;
end

%capacitive current is calculated based on the Hirschhof law of current sum
function y = I_c(t,V_m,par)
         y = -(I_inj(t,par) + I_r(V_m,par)); 
end