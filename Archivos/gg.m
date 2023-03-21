clc;
% for i=1:211
%     th(i)=out.grafica.signals(1).values(:,:,i);
% end
figure
stairs(out.grafica.time,out.grafica.signals(2).values,'b')
xlabel('t[s]')
ylabel('x[m]')
title('respuesta del sistema a una consigna escalon de x=0.5 m,con ruido de sensores y perturbaciones')
grid on 
figure
stairs(out.grafica.time,out.grafica.signals(1).values,'b')
xlabel('t[s]')
ylabel('θ[rad]')
title('respuesta del sistema a una consigna escalon de θ=0.0349 rad,con ruido de sensores y perturbaciones')
grid on 
