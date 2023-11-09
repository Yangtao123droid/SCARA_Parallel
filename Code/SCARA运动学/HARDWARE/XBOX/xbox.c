#include "xbox.h"
#include "led.h"

float xbox[18];//stm32接收数据数组
float blobs[3];
float X_data;//接收黑色中心横坐标的绝对值
float Y_black_data;//接收黑色中心纵坐标的绝对值

float X_red_data;//接收红色中心横坐标的绝对值
float Y_data;//接收红色中心纵坐标的绝对值

float X_yellow_data;//接收黄色中心横坐标的绝对值
float Y_yellow_data;//接收黄色中心纵坐标的绝对值

float errer;

float buttonA;
float buttonB;
float buttonX;
float buttonY;
float axisX;
float axisY;
float dirX;
float dirY;

int i=0;

void Xbox_Receive_Data(float data)//接收Xbox传过来的数据
{
    static float state = 0;
    if(state==0&&data==0x2C)
    {
        state=1;
        xbox[0]=data;
    }
    else if(state==1&&data==0x12)
    {
        state=2;
        xbox[1]=data;
    }
    else if(state==2)
    {
        state=3;
        xbox[2]=data;
    }
    else if(state==3)
    {
        state = 4;
        xbox[3]=data;
    }
    else if(state==4)
    {
        state = 5;
        xbox[4]=data;
    }
    else if(state==5)
    {
        state = 6;
        xbox[5]=data;
    }
    else if(state==6)
    {
        state = 7;
        xbox[6]=data;
    }
    else if(state==7)
    {
        state = 8;
        xbox[7]=data;
    }
    else if(state==8)
    {
        state = 9;
        xbox[8]=data;
    }
    else if(state==9)
    {
        state = 10;
        xbox[9]=data;
    }
    else if(state==10)
    {
        state = 11;
        xbox[10]=data;
    }
    else if(state==11)
    {
        state = 12;
        xbox[11]=data;
    }
    else if(state==12)
    {
        state = 13;
        xbox[12]=data;
    }
    else if(state==13)
    {
        state = 14;
        xbox[13]=data;
    }
    else if(state==14)
    {
        state = 15;
        xbox[14]=data;
    }
    else if(state==15)
    {
        state = 16;
        xbox[15]=data;
    }
    else if(state==16)
    {
        state = 17;
        xbox[16]=data;
    }
    else if(state==17)      //检测是否接受到结束标志
    {
        if(data == 0x5B)
        {
            state = 0;
            xbox[17]=data;
            Xbox_Data();
        }
    }
    else
    {
			state = 0;
			for(i=0;i<18;i++)
			{
				xbox[i]=0x00;
			}
  }
}

void Xbox_Data(void)
{
		buttonA = xbox[2];
    buttonB = xbox[4];
    buttonX = xbox[6];
    buttonY = xbox[8];
    axisX = xbox[10];
    axisY = xbox[12];
	  dirX = xbox[14];
    dirY = xbox[16];
}

