%script producing a few nice graphs for ML model
I0=[100:5:300]; V=[]; w=[]; V0=[];
for c=1:length(I0)
p=param7(0,0,0,0,I0(c));p.tsim=[0:1:200];p.P_start=[+36 0.7];
r=calc7(p); V=[V r.V]; w=[w r.w]; V0=[V0 ; r.V_null];
end

figure(1); surf(r.t,I0,V'); shading interp; colorbar;
xlabel('t (ms)'); ylabel ('I_0 (\muA/cm^2)'); zlabel ('V (mV)');

figure(2); subplot(211); plot(r.t,V); xlabel('t (ms'); ylabel('V (mV)');
subplot(212); plot(r.t,w); xlabel('t (ms)'); ylabel ('w ()');

figure(3); plot(r.V_lin,V0,'b',r.V_lin,r.w_null,'k',V(50:end,:),w(50:end,:),'r');
axis([-100 100 0 1]); xlabel('V (mV)'); ylabel ('w ()');

t=repmat(I0,[size(V,1) 1]);
figure(4); plot3(t(50:end,:),(V(50:end,:)),(w(50:end,:)),'-');
zlabel('w ()'); xlabel ('I_0 (\muA/cm^2)'); ylabel ('V (mV)');