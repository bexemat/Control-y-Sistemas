subplot(2,1,1)
plot(out.Theta.time,out.Theta.signals.values)
xlabel('t[s]')
ylabel('Θ[rad]')
grid on
subplot(2,1,2)
plot(out.x.time,out.x.signals.values)
xlabel('t[s]')
ylabel('x[m]')
grid on
