function r=plotresult7(I0,P_start,tend)
%function r=plotresult7(I0,P_start,tend)

if ~exist('I0','var') I0 = 0; end

p=(param7(0,0,0,0,I0));

if exist ('tend','var'), p.tsim=[0 tend(1)]; end
if ~exist('P_start','var'), P_start=[]; end
if length(P_start)==1, p.P_start(1)=P_start; end
if length(P_start)>1, p.P_start([1:2])=P_start([1:2]); end

r=calc7(p);
subplot(221); plot(r.t,r.V); axis([p.tsim p.E_K p.E_Ca]);
xlabel('Time (ms)'); ylabel('Membrane voltage (mV)');
title(sprintf('I_0 = %3.3f \\muA/cm^2, V_0 = %3.2f mV, w_0 = %1.3f', ...
    [p.I0,p.P_start(1),p.P_start(2)]));
subplot(223); plot(r.t,[r.w r.m_inf]); axis([p.tsim 0 1]);
xlabel('Time (ms)'); ylabel('Channel activation ()'); legend('w','m_{\infty}');
subplot(122); hold off;
V1=r.V_grad; 
w1=r.w_grad;
V1(V1<-20)=-20; V1(V1>20)=20; %V1=V1/20; 
h=quiver(r.V_grid,r.w_grid,V1,w1,'b.-');
axis([-100 100 0 1]);
%set(h,'ShowArrowHead','off');
%set(h,'AutoScale','off');
%set(h,'AutoScaleFactor',1);
hold on
plot(r.V_lin,r.V_null,'g','LineWidth',3),
plot(r.V_lin,r.w_null,'m','LineWidth',3); 
plot(r.V,r.w,'r.-','Linewidth',2); 
hold off;
legend('gradient','V nullcline','w nullcline','trajectory')
xlabel('Membrane voltage V (mV)'); ylabel('K channel gating activation w ()');
text(-100,1.01,studentname);
r.handle=h;
end