function out = calc7(in)
%excersise 2: Morris-Lecar neuron
%function out = calc5(in)
%Primoz Pirih, Sietse van Netten 2014
%
%The Morris-Lecar model is a biological neuron model developed by 
%Catherine Morris and Harold Lecar to reproduce the variety of oscillatory behavior 
%in relation to Ca++ and K+ conductance in the giant barnacle muscle fiber.
%Morris-Lecar neurons exhibit both class I and class II neuron excitability.
%
%

if ~exist('in','var')
   warning('Input parameters not defined. Using defaults.')
   in=param7
 end

global par; 
par=in;
out=in;

%make the timesteps if the step is given 
if isfield(in,'tsteps')
   t=linspace(in.tsim(1),in.tsim(2),in.tsteps);
else
   t=in.tsim;
end

%this line is added to shake the initial parameters a bit away from
%the stable point; this is due to octave ode23 having trouble with
%stable boundary value;    
par.P_start = par.P_start.*(1+1e-5.*randn);    

%call to the integration function; we can increase the step here because we use ms and not s
tic
[t,P] = ode23(@dPdt,t,par.P_start,odeparam(0.5,1e-2)); 
toc

%output
out.t=t;
out.V=P(:,1);
out.w=P(:,2);
out.task  = 7;
out.stimdur = in.t_I1_end - in.t_I1_start;

%post-processing
out.m_inf = m_inf(out.V); 
%out.w_inf = w_inf(out.V);
out.tau_w = tau_w(out.V);
out.I_Ca  = - out.m_inf .* par.Gbar_Ca .* (par.E_Ca -out.V) ;
out.I_K   = - out.w     .* par.Gbar_K  .* (par.E_K  -out.V) ;
out.I_L   = -             par.G_L     .* (par.E_L  -out.V) ;
out.I_app = I_app(t);
%capacitive current is the negative of the sum of the other currents
out.I_c   = -(out.I_Ca+out.I_K+out.I_L-out.I_app);


%calculate in in the range -80 to +40 mV
axr=[-100 +100 0 1];
%create linear space
V_lin=axr(1):1:axr(2);
%calculate nullclines
out.V_lin = V_lin;
out.V_null = dV_0(V_lin);
out.w_null = w_inf(V_lin);

V_lin=axr(1):10:axr(2);
w_lin=axr(3):0.05:axr(4);
[V_grid, w_grid]=meshgrid(V_lin,w_lin);
out.V_grid=V_grid;
out.w_grid=w_grid;
out.V_grad=dV_dw(V_grid,w_grid);
out.w_grad=dw_dV(V_grid,w_grid); 


end

%Differential equation          
function dy = dPdt(t,P); global par;
V=P(1); w=P(2);
ddt_V = (1/par.C_m) .* ( ...
         m_inf(V) .* par.Gbar_Ca .* (par.E_Ca -V) + ...
         w .*        par.Gbar_K  .* (par.E_K  -V) + ...
                     par.G_L     .* (par.E_L  -V) + ...
                     I_app(t));
ddt_w = (w_inf(V)-w) ./ (tau_w(V));
dy=     [ddt_V; ddt_w];
%disp([t V w])
end

%Applied current with two pulses (I1,I2) and a baseline (I0)
function y = I_app(t);  global par;
         y =   par.I1 .* (t > par.t_I1_start & t < par.t_I1_end) ... 
             + par.I2 .* (t > par.t_I2_start & t < par.t_I2_end) ...
             + par.I0 ; 
end

%
function m = m_inf(V); global par;
m = (0.5*(1+tanh((V-par.V_1)/par.V_2)));
end

function w = w_inf(V); global par;
w = (0.5*(1+tanh((V-par.V_3)/par.V_4)));
end

function tau=tau_w(V); global par;
%this simplification is used when tau_w can be considered as a constant parameter;
if isfield ('tau_w',par)
     tau = par.tau_w;
else tau = par.taubar_w./(cosh ((V-par.V_3)./(2*par.V_4)));
end
end

%for post-processing
%V null cline; 
%note that it does not contain the C_m term
function y = dV_0(V); global par;
         y = (-par.Gbar_Ca.* m_inf(V) .*(par.E_Ca-V)  ...
              -par.G_L.*  (par.E_L-V) ...
              -par.I0) ...
         ./  ((par.Gbar_K).*(par.E_K-V)) ; 
end

%for w null cline, we use the function w_inf defined above

%gradient dV/dw
function dV = dV_dw (V,w); global par;
         dV = (1./par.C_m) .* ... 
                ( par.Gbar_Ca.*m_inf(V).*(par.E_Ca-V) ...
                + par.Gbar_K .*w.*(par.E_K-V) ...
                + par.G_L.*(par.E_L-V) ...
                + par.I0);
end

%gradient dw/dV
function dw = dw_dV (V,w) 
         dw = (w_inf(V)-w)./tau_w(V); 
end
