/* Arduino dimensions module                                         */
/* include <arduino.scad>                                   */
/* dimensions for arduino mounting holes                    */
/* modules to draw mounting holes                           */
/* and standoffs                                            */
/* Version 1.0: Created Simon Jensen-Fellows    01.31.2018  */

include <standoff.scad>
include <fasteners.scad>

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

arduino_A_B_Y = 48.26;  // distance from A to B on the X axis
arduino_A_B_X = 1.27;   // distance from A to B on the Y axis
arduino_A_C_Y = 5.08 + 27.94;
arduino_A_C_X = 52.07;
arduino_A_D_Y = 5.08;
arduino_A_D_X = arduino_A_C_X;
arduino_A_E_Y = arduino_A_B_Y;
arduino_A_E_X = 76.2;
arduino_A_F_Y = 0;
arduino_A_F_X = 82.55; 

/* Note. On some uno/deicimilia boards,         */
/* the D hole is smaller than M3 - probably M2  */
/* This will be fixed later                     */

/* build standoffs for an original Uno type     */
/* Arduino board.                               */

module arduino_uno_standoffs( h = 10, inside_d = M3_grip_d, outside_d = 8)
{
    standoffs(inside_d = inside_d, outside_d = outside_d, h = h,
                v=[0, 0, arduino_A_B_X, arduino_A_B_Y, arduino_A_C_X, arduino_A_C_Y, arduino_A_D_X, arduino_A_D_Y]);
}    

/* build standoffs for a mega type Arduino board*/

module arduino_mega_standoffs( h = 10, inside_d = M3_grip_d, outside_d = 8)
{
       arduino_uno_standoffs(h=h, inside_d = inside_d, outside_d = outside_d);
       standoffs(inside_d = inside_d, outside_d = outside_d, h = h,
                v=[0, 0, arduino_A_E_X, arduino_A_E_Y, arduino_A_F_X, arduino_A_F_Y]);
}
