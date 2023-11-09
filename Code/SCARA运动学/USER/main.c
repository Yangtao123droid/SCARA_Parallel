#include "stm32f4xx.h"
#include "delay.h"
#include "led.h"
#include "key.h"
#include "pwm.h"
#include "motor.h" 
#include "SCARA.h"
#include "xbox.h"
#include "openmv.h"
#include "balance.h"

u16 pwmval=0;     
u16 ar1=5000;
u16 ar2=5000;
u16 ar3=5000;
u16 L1=1;
u16 L3=1;
u8 model_S = 0;
u8 key_up1 = 0;
u8 key_up2 = 0;
u8 key_up3 = 0;
u8 key_up4 = 0;
u8 model_pen = 0;

float XNN = 382.3376;


int main(void)
{
	NVIC_PriorityGroupConfig(NVIC_PriorityGroup_2);//设置系统中断优先级分组2
	delay_init(168);
	LED_init();
	KEY_Init();
	MOTOR_Init();
	TIM1_config(ar1-1,21-1);	//84M/84=1Mhz的计数频率,重装载值500，所以PWM频率为 1M/500=2Khz. 
	TIM_SetCompare1(TIM1,ar1/2);	
	TIM8_config(ar2-1,21-1);
	TIM_SetCompare1(TIM8,ar1/2);
	TIM3_config(ar3-1,21-1);
	TIM_SetCompare1(TIM3,ar3/2);
  TIM5_config(50-1,8400-1);	//定时器时钟84M，分频系数8400，所以84M/8400=10Khz的计数频率，计数5000次为500ms     
	uart_init(76800);
	DIR1=1;    //1右
	DIR2=0;    //0左
	
	while(1)
	{
		if(model == 0)
		{
			model=Position_init();
		}
		else
		{
			if(buttonY == 100 && key_up3 == 1) 
			{
				delay_ms(10);             
				key_up3=0;
			if(buttonY == 100)
			{
			  model = 2;
				if(model == 2)
				{
					model = 3;
					arr1 = 500;
					Inverse_motion(125,382.3376);
				}
			}   
		}
		else if(buttonY == 0)
			key_up3 = 1;
		
		if(KEY1 == 1)
		{
			Balance_Begin_flag = 1;
			model = 4;
		}


		
		

//		if((axisY >= 3 || axisX >= 3) && model >= 3 )
//		{
//			model=4;		
//			if(axisY >= 3 && axisX >=3)
//			{
//				LED1=1;
//				if(dirY == 0 && dirX == 0)
//				{
//					X_E=X_N+axisX*0.09;
//					Y_E=Y_N-axisY*0.09;
//				}
//				else if(dirY == 0 && dirX == 1)
//				{
//					X_E=X_N-axisX*0.09;
//					Y_E=Y_N-axisY*0.09;
//				}
//				else if(dirY == 1 && dirX == 0)
//				{
//					X_E=X_N+axisX*0.09;
//					Y_E=Y_N+axisY*0.09;
//				}
//				else if(dirY == 1 && dirX == 1)
//				{
//					X_E=X_N-axisX*0.09;
//					Y_E=Y_N+axisY*0.09;
//				}
//			}
//			else
//			{
//				times=1;
//				model=3;
//		    X_S=X_N;
//		    Y_S=Y_N;
//				X_E=X_N;
//				Y_E=Y_N;
//			}
//		}
		
		if(Y_N >= 450 || Y_N <= 300 || X_N >= 200 || X_N <= 50)
			arr1 = 20000;
		
		
		if(arr1 <= 200)
			arr1 = 200;
		if(arr1 >= 20000)
			arr1 = 20000;
	}
		
//		XNN = 125-(X_N-125);/
//		printf("%.2f\r\n",XNN);//打印
//		printf("%.2f\r\n",Y_N);//打印
	


	  	printf("%.2f\r\n",arr1);//打印

		
//		if(buttonY == 100 && key_up3 == 1) 
//		{
//			delay_ms(10);             
//			key_up3=0;
//			if(buttonY == 100)
//			{
//				 if(model_pen == 0)
//				 {
//					 DIR3=!DIR3;
//					 model_pen=1;
//					 TIM_Cmd(TIM3, ENABLE);  //使能TIM3
//					 delay_ms(300);
//					 TIM_Cmd(TIM3, DISABLE);  //使能TIM3
//					 model_pen=0;
//				 }
//				 LED1=1;
//			}   
//		}
//		else if(buttonY == 0)
//			key_up3 = 1;
	}
}




