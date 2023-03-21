clc;clear;close
%% Parametros del Sistema
M=583.756;
m=116.7512;
l=6.096;
% M=1;
% m=0.1;
% l=0.5;
g=9.81;
Ts=0.05;                 %Tiempo de muestreo
tsim=10;
t=0:Ts:tsim;
s=tf(['s']);
%% Sistema de inclinacion

Gst=1/(-M*l*s^2+(M+m)*g); %Funcion de transferencia en Sistema Continuo del angulo de inclinacion
Gstd=c2d(Gst,Ts,'zoh')    %Funcion de transferencia discreta de theta(Se le agrega un ZOH a la funcion de transferencia continua al Ts deseado)
%step(Gst,tsim)
%title('Respuesta de theta en Sistema Continuo al Escalon')
%xlabel('t[s]')
%ylabel('θ[rad]')
%grid on;
%% Sistema de Desplazamiento
Gsx=((-(l*s^2)+g)/(s^2));       %Funcion de transferencia en Sistema Continuo del desplazamiento x
Gsxd=c2d(Gsx,Ts,'zoh');    %Funcion de transferencia discreta de x

%% Parametros PID de theta
kpt=-2253.02199465803;
kit=-1255.49487156541;
tit=kpt/kit;
kdt=-1010.77834393764;
tdt=kdt/kpt;
reft=2*pi/180;
At=kpt*(1+(Ts/(2*tit))+(tdt/(Ts)));
Bt=-kpt*(1-(Ts/(2*tit))+(2*tdt/(Ts)));
Ct=kpt*tdt/(Ts);
%% Parametros PID de x

kpx=367.793686927;
kix=26.4785457931426;
tix=kpx/kix;
kdx=1277.18679492305;
tdx=kdx/kpx;
refx=0.5;
Ax=kpx*(1+(Ts/(2*tix))+(tdx/(Ts)));
Bx=-kpx*(1-(Ts/(2*tix))+(2*tdx/(Ts)));
Cx=kpx*tdx/(Ts);
%% Algoritmo PID Discreto de theta

ref=[reft,refx];
A=[At,Ax];
B=[Bt,Bx];
C=[Ct,Cx];
xk1=[0,0];      %xk-1
xk2=[0,0];      %xk-2
uk1=[0,0];      %uk-1
uk2=[0,0];      %uk-2
ek1=[0,0];     %ek-1
ek2=[0,0];      %ek-2
k=length(t);
%uk=zeros(2,k);
%ek=zeros(2,k);
%xk=zeros(2,k);
for i=1:k
    [xk(:,i),xk1,xk2,ek(:,i),ek1,ek2,uk(:,i),uk1,uk2] = MiPIDiscreto2GDL(ref,A,B,C,xk1,xk2,uk1,uk2,ek1,ek2);
     rt(i)=ref(1);
     rx(i)=ref(2);
end

GraficaRespuesta(t,rt,xk(1,:),uk(1,:),ek(1,:),1)
%GraficaRespuesta(t,rx,xk(2,:),uk(2,:),ek(2,:),2)
%% Genera función de PID Discreto escrito c para usar en Simulink
% def=legacy_code('initialize')
% def.SourceFiles={'pid.c'}
% def.HeaderFiles={'pid.h'}
% def.SFunctionName='PIDiscreto'
% def.OutputFcnSpec='double y1=PID(double u1,double u2,double u3,double u4,double u5,double u6)'
% legacy_code('sfcn_cmex_generate',def)
% legacy_code('compile',def)
%% Trayectoria del Carro
t=0:0.05:180;
x0=0;
for i=1:length(t)
    if i<=(1000)-399
        x(i)=0.1*t(i);      
    end    
    if i>(1000)-399 && i<=(1000)+800
         x(i)=x((1000)-399);         
    end
    if i>(1000)+800 && i<=2400
        x(i)=(4*(x((1000)+800))-0.1*t(i));         
    end
    if i>2400
        x(i)=(4*(x((1000)+800))-0.1*t(2400));         
    end
end
for i=1:length(t)
    if i<=600
       theta(i)=3*pi/180;
    end    
    if i>600 && i<800
        theta(i)=(3*pi/180)-((3*pi/(180*10))*(t(i)-30));
    end
    if i>800 && i<=1800
        theta(i)=0*pi/180;
    end
    if i>1800 && i<=2000
       theta(i)=0-(3*pi/(180*10))*(t(i)-90);
    end
    if i>2000 && i<=2400
       theta(i)=-3*pi/180;
    end
    if i>2400 && i<=2600
       theta(i)=-3*pi/180+((3*pi/(180*10))*(t(i)-120));
    end
    if i>2600        
        theta(i)=0*pi/180;
    end
end
xn=x';
thetan=theta';
tn=t';
xx=cat(2,tn,xn);
theta=cat(2,tn,thetan);
figure
subplot(1,2,1)
plot(t,x)
xlabel('t [s]')
ylabel('x [m]')
title('trayectoria en x')
grid on
subplot(1,2,2)
plot(t,thetan)
xlabel('t [s]')
ylabel('theta [rad]')
title('angulo de inclinacion')
grid on
%% Datos para los Sensores
VpTheta=3.3;
bitsTheta=16;
rms_Signal_Theta=0.05*(pi/180);
var_Theta=rms_Signal_Theta;
LF_Theta=((var_Theta)/(VpTheta^2))^(1/2)
LF_Theta=rms_Signal_Theta/VpTheta;
var_Theta=(LF_Theta^2)*(VpTheta^2)
SNR_Theta=20*log10(LF_Theta)+4.77+6.02*bitsTheta;
SNR_Theta
Vpx=5;
bitsx=16;
rms_Signal_x=0.0122;
LF_x=rms_Signal_x/Vpx;
var_x=(LF_x^2)*(Vpx^2)
SNR_x=20*log10(LF_x)+4.77+6.02*bitsx;
SNR_x