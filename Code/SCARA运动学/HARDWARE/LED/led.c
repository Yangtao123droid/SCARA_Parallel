#include "led.h"
#include "stm32f4xx.h" 

void LED_init(void)
{
	GPIO_InitTypeDef  GPIO_InitStructure;

  RCC_AHB1PeriphClockCmd(RCC_AHB1Periph_GPIOC, ENABLE);//使能GPIOC时钟
	RCC_AHB1PeriphClockCmd(RCC_AHB1Periph_GPIOA, ENABLE);//使能GPIOC时钟

  GPIO_InitStructure.GPIO_Pin = GPIO_Pin_4;//LED2对应IO口
//	GPIO_InitStructure.GPIO_Pin = GPIO_Pin_5;//LED2对应IO口
  GPIO_InitStructure.GPIO_Mode = GPIO_Mode_OUT;//普通输出模式
  GPIO_InitStructure.GPIO_OType = GPIO_OType_PP;//推挽输出
  GPIO_InitStructure.GPIO_Speed = GPIO_Speed_100MHz;//100MHz
  GPIO_InitStructure.GPIO_PuPd = GPIO_PuPd_UP;//上拉
  GPIO_Init(GPIOC, &GPIO_InitStructure);//初始化GPIO
	
	GPIO_InitStructure.GPIO_Pin = GPIO_Pin_6;//LED2对应IO口
//	GPIO_InitStructure.GPIO_Pin = GPIO_Pin_7;//LED2对应IO口
  GPIO_InitStructure.GPIO_Mode = GPIO_Mode_OUT;//普通输出模式
  GPIO_InitStructure.GPIO_OType = GPIO_OType_PP;//推挽输出
  GPIO_InitStructure.GPIO_Speed = GPIO_Speed_100MHz;//100MHz
  GPIO_InitStructure.GPIO_PuPd = GPIO_PuPd_UP;//上拉
	GPIO_Init(GPIOA, &GPIO_InitStructure);//初始化GPIO
	
	GPIO_ResetBits(GPIOC,GPIO_Pin_4|GPIO_Pin_5);//PA1  设置高，灯灭
	GPIO_ResetBits(GPIOA,GPIO_Pin_6|GPIO_Pin_7);//PA1  设置高，灯灭
}
