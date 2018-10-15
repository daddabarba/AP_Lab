clear r7 r8;
I=linspace(-0.1e-5,-1e-5,10);
for c=1:length(I);
  r7{c}=calc6(param6(I(c))); 
  r8{c}=calc6(param6(0,0,0,0,I(c))); 
end;
figure (3); clf; hold on; for c=1:length(I), plot(r7{c}.t,r7{c}.V_m); end; hold off;
figure (4); clf; hold on; for c=1:length(I), plot(r8{c}.t,r8{c}.V_m); end; hold off;


