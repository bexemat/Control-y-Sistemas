function GraficaRespuesta(t,r,xkt,ukt,ekt,p)
figure
% Top plot
ax1 = nexttile;
stairs(ax1,t,xkt)

grid on
title('control PID Respuesta')
xlabel('t[s]')
ylabel('θ[rad]')


% Bottom plot
ax2 = nexttile;  
stairs(ax2,t,r)

grid on
title('control PID Referencia')
xlabel('t[s]')
ylabel('θ[rad]')
if p==1
    ylim([0 0.05])
end


% Bottom plot
ax3 = nexttile;  
stairs(ax3,t,ekt)
title('control PID: Error')
xlabel('t[s]')
ylabel('θ[rad]')
grid on

% Bottom plot
ax4 = nexttile;  
stairs(ax4,t,ukt)
title('control PID : entrada de control')
xlabel('t[s]')
ylabel('θ[rad]')
grid on
end

