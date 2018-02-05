/* Standoff                                                 */
/* include <standoff.scad>                                  */
/*                                                          */
/* Version 1.0: Created Simon Jensen-Fellows    01.31.2018  */

include <fasteners.scad>

module standoff(h = 10, inside_d = M3_grip_d, outside_d = 8)
        {
            difference()
            {
                    cylinder(h=h, d=outside_d);
                    cylinder(h=h, d=inside_d);
            }
        }
        
module standoffs(h = 10, inside_d = M3_grip_d, outside_d = 8, v=[0,0])
        {
            for(i=[1:2:len(v)]){
                translate([v[i-1],v[i],0])  standoff(h = h, inside_d = inside_d, outside_d = outside_d);
            }
        }
