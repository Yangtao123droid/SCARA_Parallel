#include "led.h"
#include "stm32f4xx.h" 

void LED_init(void)
{
	GPIO_InitTypeDef  GPIO_InitStructure;

  RCC_AHB1PeriphClockCmd(RCC_AHB1Periph_GPIOC, ENABLE);//ʹ��GPIOCʱ��
	RCC_AHB1PeriphClockCmd(RCC_AHB1Periph_GPIOA, ENABLE);//ʹ��GPIOCʱ��

  GPIO_InitStructure.GPIO_Pin = GPIO_Pin_4;//LED2��ӦIO��
//	GPIO_InitStructure.GPIO_Pin = GPIO_Pin_5;//LED2��ӦIO��
  GPIO_InitStructure.GPIO_Mode = GPIO_Mode_OUT;//��ͨ���ģʽ
  GPIO_InitStructure.GPIO_OType = GPIO_OType_PP;//�������
  GPIO_InitStructure.GPIO_Speed = GPIO_Speed_100MHz;//100MHz
  GPIO_InitStructure.GPIO_PuPd = GPIO_PuPd_UP;//����
  GPIO_Init(GPIOC, &GPIO_InitStructure);//��ʼ��GPIO
	
	GPIO_InitStructure.GPIO_Pin = GPIO_Pin_6;//LED2��ӦIO��
//	GPIO_InitStructure.GPIO_Pin = GPIO_Pin_7;//LED2��ӦIO��
  GPIO_InitStructure.GPIO_Mode = GPIO_Mode_OUT;//��ͨ���ģʽ
  GPIO_InitStructure.GPIO_OType = GPIO_OType_PP;//�������
  GPIO_InitStructure.GPIO_Speed = GPIO_Speed_100MHz;//100MHz
  GPIO_InitStructure.GPIO_PuPd = GPIO_PuPd_UP;//����
	GPIO_Init(GPIOA, &GPIO_InitStructure);//��ʼ��GPIO
	
	GPIO_ResetBits(GPIOC,GPIO_Pin_4|GPIO_Pin_5);//PA1  ���øߣ�����
	GPIO_ResetBits(GPIOA,GPIO_Pin_6|GPIO_Pin_7);//PA1  ���øߣ�����
}
