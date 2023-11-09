#include "SCARA.h"
#include "key.h"
#include "delay.h"
#include "motor.h" 
#include "stm32f4xx.h"
#include "pwm.h"
#include "math.h"
#include "led.h"
#include "xbox.h"
#include "openmv.h"
#include "balance.h"

u8 key_upA=1;
u16 model1=0;
u8 key_upB=1;
u16 model2 = 0;
u16 arr2=10000;
float arr1=2000;

u16 l1=250;
u16 l2=300;
u16 l3=300;
u16 l4=250;
u16 l5=250;
float cosfoai_12=0;
float cosfoai_01=0;
float cosfoai_34=0;
float foai_12=0;
float foai_01=0;
float foai_34=0;
float foai_t=0;
float foai_40=0;
float pi=3.1415926;
float A = 0;
float B = 0;
float C = 0;
float thta1;
float thta2;
float thta1_last = 90;
float thta2_last = 90;
float Delta_X = 0;  
float Delta_Y = 0;
float Step_X = 0;
float Step_Y = 0;
float Sub_X = 200;
float Sub_Y = 1000;
float XC = 0;
float YC = 0;
float times = 1;
float times_Inverse = 0;
float Sub = 1;
float PulseNum1 = 0;
float PulseNum2 = 0;
float X_N = 125;
float Y_N = 382.3376;
int PulseNum1_int = 0;
int PulseNum2_int = 0;
float X_c = 125;
float Y_c = 382.3376;
float X_d = 0;
float Y_d = 0;
float u1 = 3.1415926/2;
float u4 = 3.1415926/2;
float u3 = 0;
float XN;
float YN;
float X_E = 125;
float Y_E = 382.3376;
float X_S = 125;
float Y_S = 382.3376;
float AA = 0;
float model = 0;
int Balance_Begin_flag = 0;
float YN_dir = 1;
float YN_dir_last = 1;
float YN_dir_flag = 1;



void Inverse_motion(float Xc,float Yc)  //逆运动解算，输入末端目标位置
{
	times_Inverse+=1;
	cosfoai_12=(float)(Xc*Xc + Yc*Yc - l1*l1 - l2*l2)/(2 * l1 * l2);
	foai_12=(float)(2 * pi - acos(cosfoai_12));  
	cosfoai_01=(float)(l2 * Yc * sin(foai_12) + Xc * (l2 * cos(foai_12) + l1))/\
		((l2*cos(foai_12)+l1)*(l2*cos(foai_12)+l1) + (l2*l2 * (sin(foai_12))*(sin(foai_12)))); 
	foai_01=acos(cosfoai_01);
	cosfoai_34=(float)((Xc - l5)*(Xc - l5) + Yc * Yc - l3 * l3 - l4 * l4)/(float)(2 * l3 * l4);
	foai_34=2 * pi - acos(cosfoai_34);
	A=l5 - Xc;
	B=l3 * sin(foai_34);
	C=l4 + l3 * cos(foai_34);
	foai_t=acos(B/sqrt(B*B + C*C));
	foai_40=foai_t - asin(A/sqrt(B*B + C*C));
	thta1=foai_01/pi*180;
	thta2=180 - foai_40/pi*180;
	
	u1=foai_01;
	u4=pi-foai_40;
	
	if(thta1 >= thta1_last)
		DIR1=0;
	else
		DIR1=1;
	if(thta2 >= thta2_last)
		DIR2=0;
	else
		DIR2=1;
	
	PulseNum1=(((fabs(thta1-thta1_last))*80000/360))-1;
	PulseNum2=(((fabs(thta2-thta2_last))*80000/360))-1;
	
	if(PulseNum1 <= 1)
		PulseNum1=1;
	if(PulseNum2 <= 1)
		PulseNum2=1;
	
	PulseNum1_int=(int)(PulseNum1+0.5);
	PulseNum2_int=(int)(PulseNum2+0.5);
	
	Pulse_output1(arr1,21-1,PulseNum1_int); 
	Pulse_output2(arr1,21-1,PulseNum2_int);
	
	thta1_last = thta1;
	thta2_last = thta2;
}

void motion()
{
	DIR1=0;
	DIR2=0;
	Pulse_output1(arr1,21-1,7); 
	Pulse_output2(arr1,21-1,11);
}

int Position_init()
{
	  if(buttonB == 100 && key_upA == 1)  //检测按键0按下，开机第一次按下，电机转动寻找零位。
		{
			delay_ms(10);               //第二次及二次以上按下按键0为转换方向寻找。
			key_upA=0;
			if(model1 == 0 && buttonB == 100)
				model1 += 1;     
			else if(model1 <= 3)
				DIR1=!DIR1;
		}
		else if(buttonB == 0)
			key_upA = 1;
		
		if(model1 == 1)
		{
			model1 = 2;
			TIM_Cmd(TIM1, ENABLE);
		}
		
		if(ZERO1 == 0 && model1 == 2) //在真正检测到零位之前，没有被遮挡住过
			model1 = 3;                 //防止断电时，激光正好停在零位
		
		if(ZERO1 == 1)
		{
			delay_ms(10);          //激光开关也要消抖，不然经常误判
			if(ZERO1 == 1 && model1 == 3) 
		  {
				model1 = 4;
				TIM_Cmd(TIM1, DISABLE);
				delay_ms(100);

				if(DIR1 == 0)
				{
					DIR1=1;
					Pulse_output1(500,21-1,6720);  //TIM1主定时器-TIM4从定时器
				}
				else
					Pulse_output1(500,21-1,7100);  
		  }
		}
		
		
		if(buttonA == 100 && key_upB == 1)  //检测按键0按下，开机第一次按下，电机转动寻找零位。
		{
			delay_ms(10);               //第二次及二次以上按下按键0为转换方向寻找。
			key_upB=0;
			if(model2 == 0 && buttonA == 100)
				model2 += 1;  
			else if(model2 <= 3)
				DIR2=!DIR2;
		}
		else if(buttonA == 0)
			key_upB = 1;
		
		if(model2 == 1)
		{
			model2 = 2;
			TIM_Cmd(TIM8, ENABLE);
		}
		
		
		if(ZERO2 == 0 && model2 == 2) //在真正检测到零位之前，没有被遮挡住过
			model2 = 3;                 //防止断电时，激光正好停在零位
		
		if(ZERO2 == 1)
		{
			delay_ms(10);          //激光开关也要消抖，不然经常误判
			if(ZERO2 == 1 && model2 == 3) 
		  {
				model2 = 4;
				TIM_Cmd(TIM8, DISABLE);
				delay_ms(100);

				if(DIR2 == 1)
				{
					DIR2=0;
					Pulse_output2(500,21-1,6530);  //TIM1主定时器-TIM4从定时器
				}
				else
					Pulse_output2(500,21-1,6830);  
		  }
		}
		if(model1==4 && model2==4)
		{
	    times2=1;
			times4=1;
			return 1;
		}
		else
			return 0;
}

void Interpolation(float Xa,float Ya,float Xb,float Yb) //Xa,Ya起点坐标;Xb,Yb终点坐标
{
	  Delta_X=Xb-Xa;   //计算X偏差
		Delta_Y=Yb-Ya;   //计算Y偏差
    
    if(Delta_X == 0 && Delta_Y == 0)	
		{
			Step_X=0;
			Step_Y=0;
		}		
		else
		{
			Sub=sqrt(Delta_X*Delta_X+Delta_Y*Delta_Y);

		
			Step_X=Delta_X/Sub;   //计算X每一步增长的距离
			Step_Y=Delta_Y/Sub;   //计算Y每一步增长的距离
		}
	XC=Xa + Step_X*times;   //从起点起，每次增加之后的X坐标
	YC=Ya + Step_Y*times;   //从起点起，每次增加之后的Y坐标
	
	X_N=XC;
	Y_N=YC;
		
  X_c=XC;
  Y_c=YC;
	
	Inverse_motion(XC,YC);
	times+=1;
}

void Coordinate_Transformation()
{
	X_d = l5 + l4*cos(u4);
	Y_d = l4*sin(u4);
	u3 = atan((Y_c - Y_d)/(X_c - X_d)) + pi;
	u3 = u3 - (pi/2);
	XN = X*cos(u3) - Y*sin(u3);
	YN = X*sin(u3) + Y*cos(u3);
}

