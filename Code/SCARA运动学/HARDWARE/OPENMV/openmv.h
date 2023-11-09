#ifndef openmv_H
#define openmv_H

extern float openmv[18];//stm32接收数据数组

extern float X;
extern float Y;
extern float DIR_cx;
extern float DIR_cy;

extern void Openmv_Receive_Data(float data);
extern void Openmv_Data(void);

#endif
