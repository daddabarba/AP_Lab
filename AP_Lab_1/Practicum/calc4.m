function out = calc4(in)
%excersise 2: HH neuron in voltage clamp
%function out = calc4(in)
%Primoz Pirih, Sietse van Netten 2014

if ~exist('in','var')
    in = param4
    warning('input parameters not passed. Using defaults');
end

global par; 
par=in;
%copy the parameters to the output file
out=in;

%make the timesteps
if isfield(in,'tsteps')
   t=linspace(in.tsim(1),in.tsim(2),in.tsteps);
else
   t=in.tsim;
end

%solve the system
tic
[t,P] = ode23(@dPdt,par.tsim,par.P_start,odeparam(5e-4)); %,odeparam
toc

%add the solved time and courses of gating probabilities to "out"

out = in;
out.t=t;
%add the clamp pulse

%gating probabilities in all possible ways
%out.P = P;
n = P(:,1);
m = P(:,2);
h = P(:,3);
V_m = V_clamp(t);

out.V_m = V_m;
out.n   =  n;
out.m   =  m;
out.h   =  h;
out.p_K =  n.*n.*n.*n;
out.p_Na = m.*m.*m.*h;
    
%conductances and currents
out.G_K  =  G_K (n);
out.G_Na =  G_Na(m, h);
out.I_K  =  I_K (V_m,n);
out.I_Na =  I_Na(V_m,m,h);
out.stimind=(find(out.V_m~=out.V0)); 
end

%Differential equation          
function dy = dPdt(t,P); global par;
%get the probability values from the vector P 
n=P(1); m=P(2); h=P(3);
         
%the membrane voltage is clamped, i.e. controlled externally. see the
%function below
V_m = V_clamp(t);

[alpha,beta]=alphabeta(V_m);

%%time derivative of open probability change
dndt = alpha(1) .* (1-n) - beta(1) .* n;
dmdt = alpha(2) .* (1-m) - beta(2) .* m;
dhdt = alpha(3) .* (1-h) - beta(3) .* h;
         
%put the probability derivatives back to a vector
dy = [dndt ; dmdt ; dhdt];
%disp([t dy']);
end %derivation function

%The function defining the voltage clamp protocol
function y = V_clamp(t) ; global par;
    y =   par.V0 + ...
         (par.V1-par.V0) .* ((t > par.t_V1_start) & (t < par.t_V1_end)) + ...
         (par.V2-par.V0) .* ((t > par.t_V2_start) & (t < par.t_V2_end)) ;    
end         

%postprocessing functions
function y = G_K(n); global par
         y = n.^4 .* par.Gbar_K;
end

function y = G_Na(m,h); global par
         y = m.^3 .* h .* par.Gbar_Na;
end

function y = I_K(V_m,n); global par
         y = G_K(n) .* (V_m - par.E_K);
end
         
function y = I_Na(V_m,m,h); global par
         y = G_Na(m,h) .* (V_m - par.E_Na);       
end