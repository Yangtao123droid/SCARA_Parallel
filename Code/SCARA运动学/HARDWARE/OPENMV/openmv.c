#include "openmv.h"
#include "led.h"
#include "SCARA.h"

float openmv[18];//stm32接收数据数组

float X;
float Y;
float DIR_cx;
float DIR_cy;

int j=0;

void Openmv_Receive_Data(float data)//接收Xbox传过来的数据
{
    static float state = 0;
    if(state==0&&data==0x3C)
    {
        state=1;
        openmv[0]=data;
    }
    else if(state==1&&data==0x32)
    {
        state=2;
        openmv[1]=data;
    }
    else if(state==2)
    {
        state=3;
        openmv[2]=data;
    }
    else if(state==3)
    {
        state = 4;
        openmv[3]=data;
    }
    else if(state==4)
    {
        state = 5;
        openmv[4]=data;
    }
    else if(state==5)
    {
        state = 6;
        openmv[5]=data;
    }
    else if(state==6)
    {
        state = 7;
        openmv[6]=data;
    }
    else if(state==7)
    {
        state = 8;
        openmv[7]=data;
    }
    else if(state==8)
    {
        state = 9;
        openmv[8]=data;
    }
    else if(state==9)
    {
        state = 10;
        openmv[9]=data;
    }
    else if(state==10)
    {
        state = 11;
        openmv[10]=data;
    }
    else if(state==11)
    {
        state = 12;
        openmv[11]=data;
    }
    else if(state==12)
    {
        state = 13;
        openmv[12]=data;
    }
    else if(state==13)
    {
        state = 14;
        openmv[13]=data;
    }
    else if(state==14)
    {
        state = 15;
        openmv[14]=data;
    }
    else if(state==15)
    {
        state = 16;
        openmv[15]=data;
    }
    else if(state==16)
    {
        state = 17;
        openmv[16]=data;
    }
    else if(state==17)      //检测是否接受到结束标志
    {
        if(data == 0x6B)
        {
            state = 0;
            openmv[17]=data;
            Openmv_Data();
        }
    }
    else
    {
			state = 0;
			for(j=0;j<18;j++)
			{
				openmv[j]=0x00;
			}
  }
}

void Openmv_Data(void)
{
	  X = openmv[2];
    Y = openmv[4];
	  DIR_cx = openmv[6];
	  DIR_cy = openmv[8];
	  if(DIR_cx == 0)
			X = -X;
		else
			X = X;
		if(DIR_cy == 0)
			Y = -Y;
		else
			Y = Y;
    Coordinate_Transformation();
}

