#ifndef xbox_H
#define xbox_H


extern float xbox[18];//stm32接收数据数组

extern float buttonA;
extern float buttonB;
extern float buttonX;
extern float buttonY;
extern float axisX;
extern float axisY;
extern float dirX;
extern float dirY;

extern void Xbox_Receive_Data(float data);
extern void Xbox_Data(void);

#endif
