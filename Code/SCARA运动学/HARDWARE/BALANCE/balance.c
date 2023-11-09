#include "balance.h"
#include "led.h" 
#include "SCARA.h"

static _Balance Balance;
_pBalance pBalance = &Balance;

float X_err = 0;
float Y_err = 0;

int count_X = 0;
int count_Y = 0;



void X_PID_INIT()
{
	pBalance->Kp_X = 5;
	pBalance->Kd_X = 0;
	pBalance->Zero_X = -2.5;
}

void Y_PID_INIT()
{
	pBalance->Kp_Y = 5;
	pBalance->Kd_Y = 0;
	pBalance->Zero_Y = 1;
} 
	
void X_PID_Cacluate(float dir,_pBalance pBalance)
{
	count_X++;
	X_PID_INIT();
	pBalance->err_X = dir;
	if(pBalance->err_X >= 0)
		pBalance->err_X_dir = 1;
	else
		pBalance->err_X_dir = 0;
	if(pBalance->err_X_dir_flag != 0)
		LED1 = 0;
	else 
		LED1 = 1;
	pBalance->err_X_dir_flag = pBalance->err_X_dir - pBalance->err_X_dir_last;
	if(count_X == 5)
	{
		pBalance->Omega_X = pBalance->err_X - pBalance->last_err_X;
		count_X=0;
	}
	pBalance->P_value_X = pBalance->Kp_X * pBalance->err_X;
	pBalance->D_value_X = pBalance->Kd_X * pBalance->Omega_X;
	pBalance->PID_OUT_X = pBalance->P_value_X + pBalance->D_value_X;
	pBalance->last_err_X=pBalance->err_X;
  pBalance->err_X_dir_last = pBalance->err_X_dir;
}

void Y_PID_Cacluate(float dir,_pBalance pBalance)
{
	count_Y++;
	Y_PID_INIT();
	pBalance->err_Y = dir;
	
	if(pBalance->err_Y >= 0)
		pBalance->err_Y_dir = 1;
	else
		pBalance->err_Y_dir = 0;
	if(count_Y == 5)
	{
		pBalance->Omega_Y = pBalance->err_Y - pBalance->last_err_Y;
		count_Y=0;
	}
	pBalance->err_Y_dir_flag = pBalance->err_Y_dir - pBalance->err_Y_dir_last;
	pBalance->P_value_Y = pBalance->Kp_Y * pBalance->err_Y;
	pBalance->D_value_Y = pBalance->Kd_Y * pBalance->Omega_Y;
	pBalance->PID_OUT_Y = pBalance->P_value_Y + pBalance->D_value_Y;
	pBalance->last_err_Y=pBalance->err_Y;
	pBalance->err_Y_dir_last = pBalance->err_Y_dir;
}

void X_OUT(_pBalance pBalance)
{
	  if(pBalance->err_X_dir_flag == 0 && model >= 3 && Balance_Begin_flag == 1)
			X_E = X_N + pBalance->err_X;		
		else if(model >= 3)
	  {
			times=1;
			X_S=X_N;
			X_E=X_N;
			Y_S=Y_N;
			Y_E=Y_N;
		}	
		
	  if(pBalance->PID_OUT_X >= 0)
			arr1 = 5000/pBalance->PID_OUT_X;
		else
			arr1 = 5000/(0-(pBalance->PID_OUT_X));
		
		
	if(arr1 <= 200)
		arr1 = 200;
	if(arr1 >= 20000)
		arr1 = 20000;
	
	if(Y_N >= 450 || Y_N <= 300 || X_N >= 200 || X_N <= 50)
		arr1 = 20000;
}

void Y_OUT(_pBalance pBalance)
{	
	  if(pBalance->err_Y_dir_flag == 0 && model >= 3 && Balance_Begin_flag == 1)
			Y_E = Y_N + pBalance->err_Y;		
		else if(model >= 3)
	  {
			times=1;
			Y_S=Y_N;
			Y_E=Y_N;
			X_S=X_N;
			X_E=X_N;
		}	
		
		if(pBalance->PID_OUT_Y >= 0)
			arr1 = 5000/pBalance->PID_OUT_Y;
		else
			arr1 = 5000/(0-(pBalance->PID_OUT_Y));
		
		if(arr1 <= 200)
			arr1 = 200;
		if(arr1 >= 20000)
			arr1 = 20000;
	
		if(Y_N >= 450 || Y_N <= 300 || X_N >= 200 || X_N <= 50)
			arr1 = 20000;
}

