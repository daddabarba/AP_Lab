
global C; C = 2;
global R; R = 3;
global I; I = -2;

global E; E = 2;

global start_step; start_step = 0;
global end_step; end_step = 10;

t_int = [0,10];

V_start = 10;

[t,V_m] = ode23(@dVdt_2,t_int,V_start,odeparam(1e-4,1e-5));

plot(t,V_m);

function y = dVdt_1(t,V); global C; global R;
    y = -(1/C)*(V/R + I_inj(t));
end

function y = dVdt_2(t,V); global C; global R; global E;
    y = -(1/C)*((V-E)/R + I_inj(t));
end

function i = I_inj(t); global start_step; global end_step; global I;
    if(start_step<t)&&(t<end_step)
        i = I;
    else
        i = 0;
    end
end