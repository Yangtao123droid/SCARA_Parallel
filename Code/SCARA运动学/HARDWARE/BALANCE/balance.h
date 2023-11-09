#ifndef __balance_H
#define __balance_H	 
#include "sys.h" 

typedef struct
{
	float err_X; 
  float last_err_X;	
	float P_value_X;
  float I_value_X;
  float D_value_X;
  float Kp_X;
  float Ki_X;
  float Kd_X;
	float PID_OUT_X;
	float Zero_X;
	float Omega_X;
	float err_X_dir;
	float err_X_dir_last;
	float err_X_dir_flag;
	
	float err_Y;
	float last_err_Y;	 
	float P_value_Y;
  float I_value_Y;
  float D_value_Y;	
	float Kp_Y;
  float Ki_Y;
  float Kd_Y;
	float PID_OUT_Y;
	float Zero_Y;
	float Omega_Y;
	float err_Y_dir;
	float err_Y_dir_last;
	float err_Y_dir_flag;
	
}_Balance,*_pBalance;
extern _pBalance pBalance;

extern float X_err;
extern float Y_err;

void X_PID_INIT();
void Y_PID_INIT();
void X_PID_Cacluate(float dir,_pBalance pBalance);
void Y_PID_Cacluate(float dir,_pBalance pBalance);
void X_OUT(_pBalance pBalance);
void Y_OUT(_pBalance pBalance);


#endif
