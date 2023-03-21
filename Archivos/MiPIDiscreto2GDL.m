function [xk,xk1,xk2,ek,ek1,ek2,uk,uk1,uk2] = MiPIDiscreto2GDL(ref,A,B,C,xk1,xk2,uk1,uk2,ek1,ek2)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    %xk=1.996*xk1-0.996*xk2+4.993e-05*uk1+4.987e-05*uk2;  %respuesta del sistema 2GDL
    
    xk(1)=2.005*xk1(1)-1*xk2(1)-3.514e-07*uk1(1)-3.514e-07*uk2(1);  %respuesta del sist Pendulo Invertido al angulo de inclinacion
    ek(1)=ref(1)-xk(1);                                             %Error actual Theta
    uk(1)=uk1(1)+A(1)*ek(1)+B(1)*ek1(1)+C(1)*ek2(1);                %Accion PID Discreta de Theta
    
   
    xk(2)=2*xk1(2)-1*xk2(2)-6.096*uk(1)+12.2*uk1(2)-6.084*uk2(2);  %respuesta del sist Pendulo Invertido al desplazamiento
    ek(2)=ref(2)-xk(2);                                                %Error actual de x
    uk(2)=uk1(2)+A(2)*ek(2)+B(2)*ek1(2)+C(2)*ek2(2);                      %Accion PID Discreta de x
%Actualizo valores
    for i=1:2
        xk2(i)=xk1(i);
        xk1(i)=xk(i);
        ek2(i)=ek1(i);
        ek1(i)=ek(i);
        uk2(i)=uk1(i);
        uk1(i)=uk(i);
    end
end

