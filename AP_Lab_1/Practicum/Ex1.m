
%QUESTION 1.A)
disp("QUESTION 1.A)");

%Default I_app, R_m, and C_m values
I_app = -1e-7;
R_m = 1e6;
C_m = 1e-9;

%Generate plot of V_m, I_cap, and I_res with negative I_app
plotresult(calc1(param1(I_app)));

%Save plot
print(gcf,'Plots/q11_negInj.png','-dpng','-r300');

%Generate plot of V_m, I_cap, and I_res with positive I_app
plotresult(calc1(param1(-1*I_app)));

%Save plot
print(gcf,'Plots/q11_posInj.png','-dpng','-r300');


%QUESTION 1.B)
disp("QUESTION 1.B)");

%Compute data (V_m as a function of time)
data = calc1();

%Get index of impulse start and end
impulse_i = find(data.I_inj<0);

start_i = impulse_i(1);
end_i = impulse_i(length(impulse_i)-1);

%Compute (approximated) derivative (slope)
slope_start = -(data.I_inj(start_i)+data.V_m(start_i)/data.R_m)/data.C_m;
value_end = data.V_m(end_i);

%Display first and last V_m value
disp("The initial voltage rate is " ... 
    + "-(1/" + data.C_m + ")*(" + data.I_inj(start_i) + " + " ...
    + data.V_m(start_i) + "/" + data.R_m + ") = "+ slope_start + " [V/s]");
disp("The final voltage value is V(" + data.t(end_i) + ") = " ...
    + value_end + " [V]");


%QUESTION 1.C)
disp("QUESTION 1.C)");

%Set new R_m value
R_m_temp = 2*R_m;

%Compute V_m given parameters
data = calc1(param1(I_app, R_m_temp));

%Get index of impulse start and end
impulse_i = find(data.I_inj<0);

start_i = impulse_i(1);
end_i = impulse_i(length(impulse_i)-1);

%Compute (approximated) derivative (slope)
slope_start = -(data.I_inj(start_i)+data.V_m(start_i)/data.R_m)/data.C_m;
value_end = data.V_m(end_i);

%Display first and last V_m value
disp("The initial voltage rate is " ... 
    + "-(1/" + data.C_m + ")*(" + data.I_inj(start_i) + " + " ...
    + data.V_m(start_i) + "/" + data.R_m + ") = "+ slope_start + " [V/s]");
disp("The final voltage value is V(" + data.t(end_i) + ") = " ...
    + value_end + " [V]");


%QUESTION 1.D)
disp("QUESTION 1.D)");

%Set new C_m value
C_m_temp = 5*C_m;

%Compute V_m given parameters
data = calc1(param1(I_app, R_m, C_m_temp));

%Get index of impulse start and end
impulse_i = find(data.I_inj<0);

start_i = impulse_i(1);
end_i = impulse_i(length(impulse_i)-1);

%Compute (approximated) derivative (slope)
slope_start = -(data.I_inj(start_i)+data.V_m(start_i)/data.R_m)/data.C_m;
value_end = data.V_m(end_i);

%Display first and last V_m value
disp("The initial voltage rate is " ... 
    + "-(1/" + data.C_m + ")*(" + data.I_inj(start_i) + " + " ...
    + data.V_m(start_i) + "/" + data.R_m + ") = "+ slope_start + " [V/s]");
disp("The final voltage value is V(" + data.t(end_i) + ") = " ...
    + value_end + " [V]");


%QUESTION 1.G)
disp("QUESTION 1.G");

%Generate plot of V_m, I_cap, and I_res with small C
plotresult(calc1(param1(I_app, R_m, 1e-12)));

%Save plot
print(gcf,'Plots/q17_smallC.png','-dpng','-r300');

%Generate plot of V_m, I_cap, and I_res with C = 0 F
plotresult(calc1(param1(I_app, R_m, 0)));

%Save plot
print(gcf,'Plots/q17_zeroC.png','-dpng','-r300');

%Generate plot of V_m, I_cap, and I_res with negative C
plotresult(calc1(param1(I_app, R_m, -C_m)));

%Save plot
print(gcf,'Plots/q17_negativeC.png','-dpng','-r300');


