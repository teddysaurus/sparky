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
37d_bolt_orbit_d = 31;  // diameter of the circle described by the M3 screw hols
37d_axle_d = 12.2;      // diameter of the axle bearing housing
37d_axle_offset = 7;    // distance from the center of the gearbox cylinder to the center of the axle bearing housing
37d_motor_base_w = 40;  // dimensions for the motor base mount housing
37d_motor_base_h = 20;
37d_bracket_width = 4;  // width of the bracket that mates with the face of the motor
//$fn = 100;
//37d_motor_base();     // uncomment this to build the motor mount alone

/* Describes the motor as two cylinders                     */
/* the fatter cylinder is the gearbox, the other is the main*/
/* motor body.                                              */
/* cylinder is oriented face down, centered on the origin   */
/* with the body upright in positive space.                 */

module 37d_body()
{
    cylinder( d = 37d_gearbox_d, h = 37d_gearbox_l);
    cylinder( d = 37d_body_d, h = 37d_full_l);
}

/* Describes the holes (cutouts) needed to mount the motor  */
/* to a bracket with the M3 screw holes.                    */
/* Use the same translate() arguments used for the body     */
/* and difference() with the bracket to remove the screw    */
/* cylinders.                                               */

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

/* Build a 37D motor mount                                  */
/* d is the diameter of the screw holes for the tension     */
/* strap. Ideally should be larger than the screw/bolt size.*/

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
