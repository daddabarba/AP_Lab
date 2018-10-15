function out = calc6(in)
%excersise 6: Hodgkin-Huxley neuron with current pulse stimulation
%function out = calc4(in)
%Primoz Pirih, Sietse van Netten 2014on
 
if ~exist('in','var')
    warning('no parameters have been passed. Using defaults.')
    in=param6
end
 
%make the input parameters visible inside this function
global par; 
par=in;
out=in;

%make the timesteps
if isfield(in,'tsteps')
   t=linspace(in.tsim(1),in.tsim(2),in.tsteps);
else
   t=in.tsim;
end

%adjust the timestep according to the stimulus length
%therefore, using 1 ms stimuli will be somewhat faster than 0.1 ms
stimdur=(par.t_I1_end-par.t_I1_start);
tstep=abs(stimdur)/2;
if stimdur==0
   tstep=1e-3; %there is likely no stimulus
end
%call to the integration function
tic

[t,P] = ode23(@dPdt,t,[par.P_start ; par.V_start],odeparam(tstep)); 
toc
 
%output preparation
%add the solved time and courses of gating probabilities 
%and membrane voltage to the container "out"
%out.P=P;
out.n=P(:,1);
out.m=P(:,2);
out.h=P(:,3);
out.V_m=P(:,4);
    
%derived parameters
out.t=t;
out.p_K    = out.n.^4;
out.p_Na   = out.m.^3 .*  out.h;
out.G_Na   = out.p_Na .*  out.Gbar_Na;
out.G_K    = out.p_K  .*  out.Gbar_K;
out.I_Na   = out.G_Na .* (out.V_m - out.E_Na);
out.I_K    = out.G_K  .* (out.V_m - out.E_K);
out.I_L    = out.G_L  .* (out.V_m - out.E_L);
out.I_inj = I_app(t);
out.I_c   = -(out.I_inj + out.I_Na + out.I_K + out.I_L);
out.task  = 6;
out.stimdur=stimdur;
out.stimind=(find(out.I_inj~=out.I0));

end %function

%Differential equation          
function dy = dPdt(t,P); global par;
         %get the probability values from the vector P and 
         n=P(1); m=P(2); h=P(3); V_m=P(4);
         
         %call the external function
         [alpha,beta]=alphabeta(V_m);
         %%time derivative of open probability change
         dndt = alpha(1) .* (1-n) - beta(1) .* n;
         dmdt = alpha(2) .* (1-m) - beta(2) .* m;
         dhdt = alpha(3) .* (1-h) - beta(3) .* h;
         dVdt = -1./par.C_m.* ...
                    ( I_app(t) ...
                    + m.*m.*m.*h .* par.Gbar_Na .* (V_m - par.E_Na) ...
                    + n.*n.*n.*n .* par.Gbar_K  .* (V_m - par.E_K) ...
                    +               par.G_L     .* (V_m - par.E_L) ) ;

         %put the probability and voltage derivatives back to a vector
         dy = [dndt ; dmdt ; dhdt ; dVdt];
         %disp(dy');
end

%Current clamp, with two pulses and an offset
function y = I_app(t);  global par
         y =   par.I1 .* (t > par.t_I1_start & t < par.t_I1_end) ... 
             + par.I2 .* (t > par.t_I2_start & t < par.t_I2_end) ... 
             + par.I0; 
end



