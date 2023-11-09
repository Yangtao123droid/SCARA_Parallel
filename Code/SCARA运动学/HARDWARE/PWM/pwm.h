#ifndef _TIMER_H
#define _TIMER_H
#include "sys.h"
//////////////////////////////////////////////////////////////////////////////////	 

//STM32F407开发板
//定时器 驱动代码	   
								  
////////////////////////////////////////////////////////////////////////////////// 	

extern float times2;
extern float times4;
void TIM1_config(u32 arr,u32 psc);
void TIM8_config(u32 arr,u32 psc);
void TIM3_config(u32 arr,u32 psc);
void TIM5_conf5ig(u32 arr,u32 psc);
void TIM4_config(u32 PulseNum);
void TIM2_config(u32 PulseNum);
void Pulse_output1(u16 arr1,u16 psc1,u32 PulseNum1);
void Pulse_output2(u16 arr2,u16 psc2,u32 PulseNum2);
void TIM4_IRQHandler(void);
void TIM2_IRQHandler(void);
void TIM5_IRQHandler(void);
#endif
