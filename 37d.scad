/* 37D Motor module                                         */
/* include <37d.scad>                                       */
/* dimensions for 37D type motor                            */
/* modules to draw motor body and                           */
/* holes for mounting bolts and axle                        */
/* Version 1.0: Created Simon Jensen-Fellows    01.31.2018  */

include <simon.scad>
include <fasteners.scad>

37d_gearbox_d = 37;
37d_gearbox_l = 22;
37d_body_d = 34.5;
37d_full_l = 68;
37d_bolt_orbit_d = 31;
37d_axle_d = 12.2;
37d_axle_offset = 7;
37d_motor_base_w = 40;
37d_motor_base_h = 20;
37d_bracket_width = 4;
//$fn = 100;
//37d_motor_base();

module 37d_body()
{
    cylinder( d = 37d_gearbox_d, h = 37d_gearbox_l);
    cylinder( d = 37d_body_d, h = 37d_full_l);
}

module 37d_cutout(d = 3.2, h = 5)
{
    // axle surround
    translate([37d_axle_offset,0,-h]) cylinder( d= 37d_axle_d, h=h);
    // mounting bolt holes
    for(i = [0:60:300])
        rotate([0,0,i]) translate([0,37d_bolt_orbit_d/2,-h]){
            cylinder(d = d, h = h);
            rotate([180,0,0]) countersink();
        }
}    

// Build a 37D motor mount
// d is the diameter of the screw holes
// ideally should be larger than the screw/bolt size
// width of bracket

module 37d_motor_base(d = 3.2)   
{  
                {
                    difference(){
                        union(){
                            cube([37d_bracket_width, 37d_motor_base_w, 37d_motor_base_w]);
                            cube([37d_full_l + 37d_bracket_width, 37d_motor_base_w , 37d_motor_base_h]);
                            translate([27,37d_motor_base_w/2, 37d_motor_base_w/2]) rotate([0,90,0]) cylinder(h=20, r= 37d_motor_base_w/2);
                            translate([37,37d_motor_base_w/2, 37d_motor_base_w]) rotate([90,90,0]) cylinder(h=10, r= 10, center = true);
                        }
                        translate([37d_bracket_width,37d_motor_base_w/2, 20]) rotate([0,90,0]) 37d_body();
                        translate([37d_bracket_width,37d_motor_base_w/2, 20]) rotate([0,90,0]) 37d_cutout(d = d, h = 37d_bracket_width);
                        translate([37,  37d_motor_base_w/2,37d_motor_base_w]) cube([21,2,20], center = true);
                        translate([37,37d_motor_base_w/2, 37d_motor_base_w + 3]) rotate([90,90,0]) cylinder(h=10, d = 3.2, center = true);
                    }
                }
}