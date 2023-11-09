#ifndef _SCARA_H
#define _SCARA_H
#include "sys.h"

extern float thta1;
extern float thta2;
extern float X_N;
extern float Y_N;
extern float thta2;
extern float times_Inverse;
extern float times;
extern float Sub;
extern float X_d;
extern float Y_d;
extern float u1;
extern float u4;
extern float u3;
extern float X_c;
extern float Y_c;
extern float XN;
extern float YN;
extern float arr1;
extern float X_E;
extern float Y_E;
extern float X_S;
extern float Y_S;
extern float model;
extern int Balance_Begin_flag;
extern float YN_dir;
extern float YN_dir_last;
extern float YN_dir_flag;



void Inverse_motion(float Xc,float Yc);
void Interpolation(float Xa,float Ya,float Xb,float Yb);
int Position_init();
void motion();
void Coordinate_Transformation();



#endif




















