/* fasteners                        */
/* include <fasteners.scad>          */

M3_grip_d   = 3.2;      // grips screw
M3_free_d   = 4;        // no grip
M3_countersunk_d = 6.5; // maximum diameter of countersunk hold for flathead M3

//countersink();

module countersink( d = M3_countersunk_d )
{
    r = d/2;
    translate ([0,0, -r]) cylinder(r1 = 0, r2 = r, h = r);
}


