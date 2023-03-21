#include "pid.h"
// Parametros del Sistema
double xk=0;
double ek=0;
double uk=0;
double xk1=0;      //xk-1
double xk2=0;      //xk-2
double uk1=0;      //uk-1
double uk2=0;      //uk-2
double ek1=0;      //ek-1
double ek2=0;      //ek-2
double PID(double ref,double kpt,double kit,double kdt,double Ts,double xs){
        double tit=kpt/kit;
        double tdt=kdt/kpt;
        double A=kpt*(1+(Ts/(2*tit))+(tdt/(Ts)));
        double B=-kpt*(1-(Ts/(2*tit))+(2*tdt/(Ts)));
        double C=kpt*tdt/(Ts);         
        //xk=2.005*xk1-1*xk2-3.514e-07*uk1-3.514e-07*uk2;  //respuesta del sist Pendulo Invertido al angulo de inclinacion
        xk=xs;        
        ek=ref-xk;                                         //Error actual Theta
        uk=uk1+A*ek+B*ek1+C*ek2;                           //Accion PID Discreta de Theta             
        //Actualizo valores    
        xk2=xk1;
        xk1=xk;
        ek2=ek1;
        ek1=ek;
        uk2=uk1;
        uk1=uk;
        return uk;
}










