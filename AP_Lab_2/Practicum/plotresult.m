function plotresult(r,figno,strictaxis)
%function plotresult(r,figno,strictaxis)
%this function plots the results of the simulations calc1 ... calc7
% parameters
% r     - structure with the results of the simulation
% figno - the figure number into which to plot: the function will figno and figno+1
%         in the case this parameter is not passed, two new figures will be made
% strictacis (TRUE*/false) controls axis behaviour: strict has predefined ranges

if ~exist('figno','var')
    figno=0;
end
if ~exist ('strictaxis','var')
    strictaxis=true;
end

%cast a figure
if figno~=0 
   hf=figure(figno);
else hf=figure;
end
setpaper(hf); 

%upper pane of figure 1
hs=subplot(2,1,1); 
switch r.task
case {1,2,3,4};
        hp=plot(r.t,r.V_m,'k.-');
        if strictaxis
           if r.task==4
                axis([r.tsim -0.10 +0.05]);
           else axis([r.tsim -0.30 +.30]); end
        end
case {6}
        hp=plot(r.t,r.V_m,'k.-',r.t(r.stimind),r.V_m(r.stimind),'r*');
        if strictaxis
            axis([r.tsim r.E_K r.E_Na])
        end
case {7}
        %here we plot gating variables in the upper pane
        hp=plot(r.t,r.V, 'g-', ...      %V  mV
                r.t,100*r.w, 'r--', ... %Ca %
                r.t,100*r.m_inf, 'b:'); %K  %
        if strictaxis
            axis([r.tsim -100 100])
        end
end

if r.task==7
    ylabel('Voltage [mV], probability [%]'); 
    xlabel('Time [ms]'); printtitle(r);
    legend('V_m (mV)','w (%)','m_{\infty} (%)');
    printtitle(r);
else    
    ylabel('Voltage [V]'); 
    xlabel('Time [s]'); printtitle(r);
end
setfonts(hs); plotnicify(hp); 



%lower pane of figure 1
hs=subplot(2,1,2); 
switch r.task
    case 1
       hp=plot( ...
            r.t, r.I_inj, 'k:',...        
            r.t, r.I_c,   'mo-',...
            r.t, r.I_r,   'gd-');
       if strictaxis 
           axis([r.tsim -3e-7 3e-7]);
       end
       legend('I_{app}','I_{cap}','I_{res}');
    case {2,3}
       if r.G_K==0    %no need to show K
         r.I_K = nan(size(r.I_K));
       end
       if r.G_Na==0   %no need to show Na
         r.I_Na = nan;
       end
         hp=plot( ...
         r.t, r.I_inj, 'k:', ...
         r.t, r.I_c,   'mo-', ...
         r.t, r.I_K,   'b^-', ...   
         r.t, r.I_Na,  'rv-'); 
       if strictaxis 
           axis([r.tsim -3e-7 3e-7]);
       end
       legend('I_{app}','I_{cap}','I_{K^{+}}','I_{Na^{+}}');

    case {4}
        hp=plot(r.t,r.I_K, 'b^-',...
               r.t,r.I_Na,'rv-', ...
               r.t,r.I_K+r.I_Na,'k:');
        legend('I_{K^+}','I_{Na^+}','I_{tot}');
        
    case {6}
        hp=plot(r.t,r.I_Na, 'b-', ...
             r.t,r.I_K,    'r-', ...
             r.t,r.I_L,    'g-', ...
             r.t,r.I_c,    'm-', ...
             r.t,r.I_inj,  'k:' ...
             );
        legend('I_{Na^+}','I_{K^+}','I_L','I_{cap}','I_{inj}');
        
    case {7}
        hp=plot(r.t,r.I_Ca, 'r-',...
                r.t,r.I_K,  'b-', ...
                r.t,r.I_L,  'g-', ...
                r.t,r.I_c,  'm-', ...
                r.t,r.I_app,'k:' ...
                ); 
        legend('I_{Ca^{2+}}','I_{K^+}','I_L','I_{cap}','I_{app}');
    end
    if r.task==7 
           ylabel('Current (\muA/cm^2)'); xlabel('Time (ms)');
    else   
           ylabel('Current (A)'); xlabel('Time (s)');     
    end
    setfonts(hs); plotnicify(hp);
    
%second figure for HH and ML models
switch r.task
case {4,6} %HH model
    if figno==0
       hf=figure;
    else 
       hf=figure(figno+1); 
    end
    setpaper(hf); 
    %upper panel showing conductance
        hs=subplot(2,1,1); 
        hp=plot(r.t,r.G_K, 'r-',...
             r.t,r.G_Na, 'b-', ...
             r.t(r.stimind),r.G_K(r.stimind),'k.' ...
             );
        legend('G_{K}','G_{Na}','Location','NorthEast');
        ylabel('Conductance (S)'); xlabel('Time [s]'); printtitle(r);
        plotnicify(hp); setfonts(hs); 
        
    %lower panel showing gating variables
        hs=subplot(2,1,2); setfonts(hs);
        hp=plot( ...
            r.t,r.n,'c-', ...
            r.t,r.m,'g-', ...
            r.t,r.h,'m-', ...
            r.t(r.stimind),r.m(r.stimind),'k*' ...
            );
        %    r.t,r.p_K,'b.-', ...
        %    r.t,r.p_Na,'r.-', ...        
        
        ax=axis; axis([ax(1) ax(2) 1e-3 1]);
        legend( ... %'p_{K}','p_{Na}',
                'n','m','h','Location','SouthEast');
        ylabel('Gating probability []');
        xlabel ('Time (s)');
        setfonts(hs);
        plotnicify(hp);
case 7 %{ML phase portrait}
    if figno==0
       hf=figure;
    else 
       hf=figure(figno+1); 
    end
    setpaper(hf); 

    wscale=100;
    hold off
    quiver(r.V_grid,r.w_grid*wscale,r.V_grad,r.w_grad*wscale,'ko', ...
    'ShowArrowHead','off','AutoScale','on','AutoScaleFactor',5,'Markersize',2); 
    hold on
    plot(r.V_lin,r.V_null*wscale,'b-','LineWidth',2);
    plot(r.V_lin,r.w_null*wscale,'g-','LineWidth',2);
    plot(r.V, r.w*wscale, 'r.-','LineWidth',2,'MarkerSize',10);
    ind=[ find(r.t>r.t_I1_start,1); ...
          find(r.t>r.t_I1_end,1);  ...
          find(r.t>r.t_I2_start,1); ...
          find(r.t>r.t_I2_end,1) ]; ...
    if r.I1>0 
        plot(r.V(ind(1:2)),r.w(ind(1:2))*wscale,'cs','Markersize',15); end
    if r.I2>0 
        plot(r.V(ind(3:4)),r.w(ind(3:4))*wscale,'ms','Markersize',15); end
    hold off;
    
    axis([-100 100 0 1*wscale])
    legend('gradient', ...
           'V nullcline', ...
           'w nullcline', ...
           'trajectory (V(t),w(t))', ...
           '1^{st} stimulus mark', ...
           '2^{nd} stimulus mark');
    xlabel('Membrane voltage V (mV)');
    ylabel('K channel gating activation w (%)');
    printtitle(r);
    text(-100,1.01*wscale,studentname);
end

        


end

function setfonts(h);
   set(h,'FontSize',14);
   set(h,'FontName','Arial')
end

function setpaper(h);
   set(h,'paperunits','centimeters',...
         'papersize',[21 29],...
         'paperposition',[2 2 17 25] ...
         );
   set(h,'paperunits','centimeters',...
         'papersize',[29 21],...
         'paperposition',[2 2 25 17] ...
         );
     
end

function plotnicify(h)
    set(h,'Markersize',2);
    set(h,'Linewidth',2);
    ax=axis;
    text(ax(1),ax(4)*0.95,studentname,'Fontsize',8);
end

function printtitle(r);
switch r.task
    case{1}
    title(sprintf('RC circuit: \nR_m = %1.2e \\Omega, C_m = %1.2e F. I_{app} = %2.2f \\muA', ...
           [r.R_m, r.C_m, r.I1*1e6]));
    case{2,3}
    title(sprintf('Passive cell: \n G_{K} = %1.2e S, G_{Na} = %1.2e S. I_{app} = %2.2f \\muA', ...
            [r.G_K r.G_Na r.I1*1e6]));
    case{4} 
    title(sprintf('HH Voltage Clamp: \n G''_{K} = %2.2f mS, G''_{Na} = %2.2f mS. V0,V1,V2 = %+2.2f,%+2.2f,%+2.2f mV', ...
            [r.Gbar_K r.Gbar_Na r.V0 r.V1 r.V2]*1000));
    case{6} 
    title(sprintf('HH Action Potential: \n G''_{K} = %2.2e mS, G''_{Na} = %2.2e mS. t_{I1,I2} = %2.2f ms, I_{0,1,2} = %2.2f,%2.2f,%2.2f \\muA', ...
            [r.Gbar_K*1e3 r.Gbar_Na*1e3 r.stimdur*1e3 r.I0*1e6 r.I1*1e6 r.I2*1e6]));
    case{7}
    title(sprintf('ML Action Potential: \n G''_{K,Ca,L} = %1.1f, %1.1f, %1.1f mS/cm^2. C_m = %1.1f \\muF/cm^2, I_{0,1,2} = %2.2f, %2.2f, %2.2f \\muA/cm^2. V_{t=0} = %1.1f V, w_{t=0} = %1.3f', ...
            [r.Gbar_K r.Gbar_Ca r.G_L r.C_m r.I0 r.I1 r.I2 r.P_start(1) r.P_start(2)]));
        
end
end