
clc;
%% Graficas de angulo de Inclinacion
for i=1:length(out.Theta.time)
    ThetaSen(i)=out.Theta.signals(2).values(:,:,i);
end
subplot(4,1,1)
plot(out.Theta.time,out.Theta.signals(1).values)
xlabel('t[s]')
ylabel('θ[ ° ]')
title('θ perturbado')
grid on
axis([0 inf -5 5 ])
subplot(4,1,2)
plot(out.Theta.time,ThetaSen)
xlabel('t[s]')
ylabel('θ[ ° ]')
title('θ sensado')
grid on
axis([0 inf -5 5 ])
subplot(4,1,3)
plot(out.Theta.time,out.Theta.signals(3).values)
xlabel('t[s]')
ylabel('θ[ ° ]')
title('θ planta')
grid on
axis([0 inf -5 5 ])
subplot(4,1,4)
plot(out.Theta.time,out.Theta.signals(4).values)
xlabel('t[s]')
ylabel('θ[ ° ]')
title('θ referencia')
grid on
axis([0 inf -5 5 ])
figure
plot(out.Theta.time,out.Theta.signals(1).values)
hold on
plot(out.Theta.time,ThetaSen)
plot(out.Theta.time,out.Theta.signals(3).values)
plot(out.Theta.time,out.Theta.signals(4).values)
xlabel('t[s]')
ylabel('θ[ ° ]')
grid on
axis([0 inf -5 5 ])
legend('θ perturbado','θ sensado','θ planta','refencia θ')
%% Graficas de Desplazamiento
figure
subplot(4,1,1)
plot(out.X.time,out.X.signals(1).values)
xlabel('t[s]')
ylabel('x[m]')
title('x perturbado')
grid on
axis([0 inf -1 4 ])
subplot(4,1,2)
plot(out.X.time,out.X.signals(2).values(:,:,:))
xlabel('t[s]')
ylabel('x[m]')
title('x sensado')
grid on
axis([0 inf -1 4 ])
subplot(4,1,3)
plot(out.X.time,out.X.signals(3).values)
xlabel('t[s]')
ylabel('θ[ ° ]')
title('x planta')
grid on
axis([0 inf -1 4 ])
subplot(4,1,4)
plot(out.X.time,out.X.signals(4).values)
xlabel('t[s]')
ylabel('x[m]')
grid on
axis([0 inf -1 4 ])
figure
plot(out.X.time,out.X.signals(1).values)
hold on
plot(out.X.time,out.X.signals(2).values)
plot(out.X.time,out.X.signals(3).values)
plot(out.X.time,out.X.signals(4).values)
xlabel('t[s]')
ylabel('x[m]')
grid on
axis([0 inf -1 4 ])
legend('X perturbado','X sensado','X planta','refencia X')

