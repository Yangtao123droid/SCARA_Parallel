#ifndef __MOTOR_H
#define __MOTOR_H
#include "sys.h"

//////////////////////////////////////////////////////////////////////////////////	 
 
//LED��������	   
//STM32F4����-�⺯���汾
//�Ա����̣�http://mcudev.taobao.com									  
////////////////////////////////////////////////////////////////////////////////// 	


#define DIR1 PAout(1)	// DS1
#define DIR2 PAout(3)	// DS1	
#define DIR3 PAout(2)	// DS1
#define LED2 PAout(7)	// DS1	
//#define ENA1 PAout(3)	// DS1	
#define ENA2 PAout(4)	// DS1	
#define ZERO1 		GPIO_ReadInputDataBit(GPIOE,GPIO_Pin_6)	
#define ZERO2 		GPIO_ReadInputDataBit(GPIOE,GPIO_Pin_5) 

void MOTOR_Init(void);//��ʼ��		 				    
#endif
