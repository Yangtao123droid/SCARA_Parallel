【SCARA_Parallel】
=
![image](https://github.com/Yangtao123droid/SCARA_Parallel/blob/main/Docs/SCARA.png)
![image](https://github.com/Yangtao123droid/SCARA_Parallel/blob/main/Docs/SCARA_Model.png)

毕设设计的一款并联SCARA机械臂，闭环步进电机，谐波减速，碳纤维杆件，3D打印关节，运动控制，直线插补
=
后面会慢慢更新MATLAB运动学仿真、基于STM32F407的运动控制代码、插补代码以及一些思路分享等等
    
更新说明
=
2023.9.11 更新3D模型 ---所有的零件、电机、减速器、杆件、机加工轴、3D打印关节、装配体文件等等

1、硬件选型与结构设计
=
1.1、电机的选择  
=
电机因为成本考虑问题和项目工作量问题，没有选择使用伺服电机或者无刷电机作为驱动关节，而是选用的
    
闭环步进电机电机的型号是杰美康的57J1880，在闲鱼上淘的,加驱动器一套大概150元，驱动器的型号是2HSS57，

也是杰美康的闭环驱动器，里面自带了电机控制算法，有电流环位置环等等，控制起来和普通的步进电机驱动器  

一样，发脉冲就好了。

后面有时间也许会考虑做一个无刷电机作为关机的版本，FOC控制，可以加入动力学的控制

![image](https://github.com/Yangtao123droid/SCARA_Parallel/blob/main/Docs/Motor_Driver.png)

1.2、减速器
=
减速器选用的谐波减速，在闲鱼上淘的leaderdrive绿的谐波的LSCG系列减速器，17-50，减速比50，450元一个，减速器与电机出轴的

尺寸不一样，当时这里自己画了一个连轴器，相当于把电机轴加粗然后插进减速器的孔里面，用键销固定，再上顶丝，电机端

本来就是D型轴，直接卡住就好了，发的模型里面都可以找到零件和装配方法。
![image](https://github.com/Yangtao123droid/SCARA_Parallel/blob/main/Docs/harmonic.jpg)

1.3、 关节旋转轴
=
这里当时是最苦恼的部分，因为不是机械方面专业的，所以自己完全不知道怎么去设计这部分旋转的关节，后面直接找到了这种

带法兰座的轴承，这样设计起来就容易很多了。
![image](https://github.com/Yangtao123droid/SCARA_Parallel/blob/main/Docs/bearing.png)

1.4、 杆件的选择
=
当时也走了不少弯路，中间有一次甚至直接整个结构都用光固化打印的材料去搭，结果刚度完全不够，搭上去

整个结构就一点一点的塌下去了，后面还是换回了碳纤维管的方案。下面是用过的杆件，整整一箱

![image](https://github.com/Yangtao123droid/SCARA_Parallel/blob/main/Docs/%E6%9D%86%E4%BB%B6.jpg)
