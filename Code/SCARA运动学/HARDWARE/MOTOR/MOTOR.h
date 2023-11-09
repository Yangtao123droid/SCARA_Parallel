#ifndef __MOTOR_H
#define __MOTOR_H
#include "sys.h"

//////////////////////////////////////////////////////////////////////////////////	 
 
//LED驱动代码	   
//STM32F4工程-库函数版本
//淘宝店铺：http://mcudev.taobao.com									  
////////////////////////////////////////////////////////////////////////////////// 	


#define DIR1 PAout(1)	// DS1
#define DIR2 PAout(3)	// DS1	
#define DIR3 PAout(2)	// DS1
#define LED2 PAout(7)	// DS1	
//#define ENA1 PAout(3)	// DS1	
#define ENA2 PAout(4)	// DS1	
#define ZERO1 		GPIO_ReadInputDataBit(GPIOE,GPIO_Pin_6)	
#define ZERO2 		GPIO_ReadInputDataBit(GPIOE,GPIO_Pin_5) 

void MOTOR_Init(void);//初始化		 				    
#endif
