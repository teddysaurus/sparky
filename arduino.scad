/* 37D Motor module                                         */
/* include <arduino.scad>                                   */
/* dimensions for arduino mounting holes                    */
/* modules to draw mounting holes                           */
/* and standoffs                                            */
/* Version 1.0: Created Simon Jensen-Fellows    01.31.2018  */

include <standoff.scad>


/*  Arduino dimensions    uno | mega        */ 
/*  __________________________|_________    */
/*  |  O B                    |    E O |    */
/*  |         Y               |        |    */
/*  |         ^               |         \   */
/*  |         |           C O |          |   */
/*  |         |               |          |   */
/*  |         o-----> X       |          |   */
/*  |                     D O |          |   */
/*  |  O A                    |      F O |   */
/*  |_________________________|__________|   */
/*                            |              */
arduino_A_B_Y = 48.26;
arduino_A_B_X = 1.27;
arduino_A_C_Y = 5.08 + 27.94;
arduino_A_C_X = 52.07;
arduino_A_D_Y = 5.08;
arduino_A_D_X = arduino_A_C_X;
arduino_A_E_Y = arduino_A_B_Y;
arduino_A_E_X = 76.2;
arduino_A_F_Y = 0;
arduino_A_F_X = 82.55; 

module arduino_uno_standoffs( h = 10, inside_d = 3.2, outside_d = 8)
{
    standoffs(inside_d = inside_d, outside_d = outside_d, h = h,
                v=[0, 0, arduino_A_B_X, arduino_A_B_Y, arduino_A_C_X, arduino_A_C_Y, arduino_A_D_X, arduino_A_D_Y]);
}    
        
module arduino_mega_standoffs( h = 10, inside_d = 3.2, outside_d = 8)
{
       arduino_uno_standoffs(h=h, inside_d = inside_d, outside_d = outside_d);
       standoffs(inside_d = inside_d, outside_d = outside_d, h = h,
                v=[0, 0, arduino_A_E_X, arduino_A_E_Y, arduino_A_F_X, arduino_A_F_Y]);
}