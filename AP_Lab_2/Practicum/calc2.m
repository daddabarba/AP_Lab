function out = calc2(in)
%excersise 2: RC model cell
%function out = calc2(in)
%Primoz Pirih, Sietse van Netten 2014

%if no parameters have been passed ...
if ~exist('in','var')
    in=param2
    warning('No parameter set passed. Using defaults.');
end

%make the container "par" visible to the subfunctions
%copy the input parameters to the cointainer "out"
global par; 
par=in;
out=in;

%make the timesteps
if isfield(in,'tsteps')
   t=linspace(in.tsim(1),in.tsim(2),in.tsteps);
else
   t=in.tsim;
end

%main part of the function: call the solver and measure time
tic
[t,V_m] = ode23 (@dVdt,t,par.V_m_start,odeparam(1e-4,1e-5)); %add odeparam as the 3d param
toc

%postprocessing
%put the time points and the membrane voltage timecourse into out
out.t  =t;
out.V_m=V_m;

%put the stimulation (I_pulse) derived (I_c,I_Na,I_K) parameters into "out"
out.I_inj = I_pulse(t,    par);
out.I_c =   I_c  (t,V_m,par);
out.I_Na =  I_Na (  V_m,par);
out.I_K  =  I_K  (  V_m,par);

end %main function

%function called by the ODE solver: time derivative of the membrane voltage
function dy = dVdt(t,V_m); global par
         dy = -1 ./ par.C_m .* ( ...
                                     I_pulse(t,par) + ...
                    par.G_Na .*  (V_m-par.E_Na) + ...
                    par.G_K .*   (V_m-par.E_K) );
end

%current pulse
function y = I_pulse(t,par)
    if ~isfield (par,'tvlist')
        y = par.I1 .* (t > par.t_I1_start & t < par.t_I1_end);
    %we use the time/value list provided in the parameters
    else y = pwl (t,par.tvlist);
    end
end

%derived parameters (only used for post processing)

%sodium current
function y = I_Na(V_m,par)
         y = par.G_Na .* (V_m-par.E_Na);
end

%potassium current
function y = I_K(V_m,par) 
         y = par.G_K .* (V_m-par.E_K);    
end                

%capacitive current is the negative of the sum of pulse, Na and K currents
function y = I_c(t,V_m,par)
         y = -(I_pulse(t,par) + I_Na(V_m,par) + I_K(V_m,par)); 
end