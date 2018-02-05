//$fn = 101; //x
include <simon.scad>
include <standoff.scad>
include <37d.scad>
include <arduino.scad> 

base_height = 100;
base_radius = 145;
base_wall = 5;

slop = 5;

wheel_pitch = (base_radius * 2) - 70;//67;
motor_to_wheel_center = 25;
wheel_width = 40;
wheel_length = 90;
wheel_inset = 55;
strength_height = 15;

standoff_pitch = 80;
standoff_h = strength_height;
standoff_r = 4;
standoff_hole_d = M3_grip_d;
outside_standoff = 110;
standoff_y_origin = 25;
standoff_x_origin = 6;

cutout_height = base_height - strength_height;
cutout_width = 180;
cutout_depth = 100;

caster_holes = 39;


upboard_Y = 49;
upboard_X = 58;

rasbpi_Y = 49;
rasbpi_X = 58;

/* uncomment one of these */

//standalone_cutout();
//chassis_with_cutout();
//standalone_cutout();
//main_chassis();
//basic_lid();
//arduino_uno_standoffs();
//arduino_mega_standoffs();
main_chassis(walls = false);
//expansion_frame();
//motor_bracket();
//base_cutout();

module  main_chassis_with_uno()
{
        main_chassis();
        translate([6+ (standoff_pitch - arduino_A_D_X),  -(110 + arduino_A_D_Y), base_wall]) arduino_uno_standoffs(h=standoff_h);

}
module chassis_with_cutout()
{
    difference(){
        main_chassis();    
        front_cutout();
    }   
}


module standalone_cutout()
{
     intersection(){
         main_chassis();    
        front_cutout();
    }   
}


        
module lid_support()
       {
            difference()
           {
            intersection()
            {
                
               translate([base_radius - base_wall,0,base_height])     sphere( r=10, center = true, $fn = 8);
               cylinder(h=base_height, r=base_radius);
            }
            translate([base_radius - base_wall -2,0,base_height])     cylinder( h=6, r=2);
            
        }
    }
    
    module lid_screwhole()
    {
        translate([base_radius - base_wall -2,0,base_height])     cylinder( h=6, r=2);            
    }
    
    
 module front_cutout()
    {
           translate([0,-(cutout_depth/2 + outside_standoff - standoff_r),(cutout_height/2) + strength_height]) cube([cutout_width,cutout_depth,cutout_height], center = true);
    }
    
module base_only(){
    cylinder(h = base_wall, r = base_radius -base_wall);
}


   
 module main_chassis(walls = true)
    {
        difference(){
            union(){
                difference(){                       // Main body and base
                    if(walls == true)    
                        outer_body();
                    else    
                        base_only();
                    translate([-caster_holes/2,100,0]) cylinder(h=6, d=3.2);                                          // holes for caster bolts
                    translate([caster_holes/2,100,0]) cylinder(h=6, d=3.2);                                           // 
                    
                    translate([-caster_holes/2,-100,0]) cylinder(h=6, d=3.2);                                          
                    translate([caster_holes/2,-100,0]) cylinder(h=6, d=3.2);                          
                }    
        
                // strengthening beams
                
                translate([0,0,base_wall+strength_height/2]) cube([base_wall,base_radius * 2 - 2,  strength_height], center = true);
               // translate([94,0,base_wall+strength_height/2]) cube([base_wall,base_radius * 2 - 70,  strength_height], center = true);
               // translate([-94,0,base_wall+strength_height/2]) cube([base_wall,base_radius * 2 - 70,  strength_height], center = true);
                translate([0,75,base_wall+strength_height/2]) cube([base_radius * 2 - 45, base_wall, strength_height], center = true);
                translate([0,-75,base_wall+strength_height/2]) cube([base_radius * 2 - 45, base_wall, strength_height], center = true);
                
                // D37 motor base
                translate([-(wheel_pitch - wheel_width)/2,-37d_motor_base_w/2,base_wall])   37d_motor_base();
                translate([(wheel_pitch - wheel_width)/2,-37d_motor_base_w/2,base_wall])   mirror() 37d_motor_base();
                
                    
            }
            translate([wheel_pitch/2, 0, wheel_width/2 - 1]) cube([wheel_width,wheel_length,wheel_width], center = true);
            translate([-wheel_pitch/2, 0, wheel_width/2 - 1]) cube([wheel_width,wheel_length,wheel_width], center = true);
            if(walls == false){
                tube(h = base_height, r = base_radius, wall = base_wall);
                base_holes();
            }
            
        ir_cutouts();        
    }
    
    base_standoffs();
    if(walls == true) lid_supports();
    
} // end of main_chassis()

module  outer_body(){
    difference(){
    cylinder(h=base_height, r=base_radius);                                             // outer circular wall and base
    translate([0,0,base_wall]) cylinder(h = base_height, r = base_radius -base_wall);   // subtract inside volume
    }
}

module lid_supports(){
    lid_support();

    rotate(a=180, v=[0,0,1]) lid_support();
    rotate(a=90, v=[0,0,1]) lid_support();
    rotate(a=-90, v=[0,0,1]) lid_support();
}


module base_standoffs(){
    //translate([(wheel_pitch/2) - 20, 0, -25]) cube([1,1,44]);
    {
        x_off = standoff_x_origin + standoff_pitch;
        y_off = standoff_y_origin + standoff_pitch;
        
        translate ([0,0,base_wall])
            standoffs( h=standoff_h, v=[x_off,y_off,standoff_x_origin,y_off,x_off,standoff_y_origin,standoff_x_origin,standoff_y_origin]);
        translate ([0,0,base_wall])
            standoffs( h=standoff_h , v=[x_off,-y_off,standoff_x_origin,-y_off,x_off,-standoff_y_origin,standoff_x_origin,-standoff_y_origin]);    translate ([0,0,base_wall])
            standoffs( h=standoff_h , v=[-x_off,-y_off,-standoff_x_origin,-y_off,-x_off,-standoff_y_origin,-standoff_x_origin,-standoff_y_origin]);      
        translate ([0,0,base_wall])
            standoffs( h=standoff_h , v=[-x_off,y_off,-standoff_x_origin,y_off,-x_off,standoff_y_origin,-standoff_x_origin,standoff_y_origin]);   
    }
}
    
module basic_lid()
{
       difference(){ 
           translate([0,0,base_height]) cylinder(r=base_radius, h= base_wall);
            lid_screwhole();
        rotate(a=180, v=[0,0,1]) lid_screwhole();
        rotate(a=90, v=[0,0,1]) lid_screwhole();
        rotate(a=-90, v=[0,0,1]) lid_screwhole();
       }
       
       translate([0,0,base_height - strength_height/2])
       {
           rotate(a=45, v=[0,0,1]) cube([base_wall,(base_radius - base_wall) * 2,  strength_height], center = true);
           rotate(a=135, v=[0,0,1]) cube([base_wall,(base_radius - base_wall) * 2,  strength_height], center = true);
       }
}




module expansion_frame()
{
        expansion_arm();
        rotate(a=90, v=[0,0,1]) expansion_arm();
        translate([0,standoff_pitch,0,]) expansion_arm();
        translate([0,standoff_pitch/2,0,]) expansion_arm();
        translate([standoff_pitch,0,0]) rotate(a=90, v=[0,0,1]) expansion_arm();    
        translate([standoff_pitch/2,0,0]) rotate(a=90, v=[0,0,1]) expansion_arm();    
}

module expansion_arm()
{
        difference(){
            hull(){
                cylinder(r = standoff_r, h = base_wall);
                translate([standoff_pitch,0,0]) cylinder(r = standoff_r, h = base_wall);
            }
            cylinder(d = M3_free_d, h = base_wall);
            translate([standoff_pitch,0,0]) cylinder(d = M3_free_d, h = base_wall);
        }
}

module base_holes()
{
    // mounting bolt holes
    for(i = [30:60:330])
        rotate([0,0,i]) translate([0,base_radius - base_wall-5,0]){
            cylinder(d = M3_free_d, h = 10);
            rotate([180,0,0]) countersink(d = M3_countersunk_d);
        }
}    

module ir_cutouts(){
for(i = [30:60:330])
        rotate([0,0,i]) translate([0,base_radius - base_wall-15,0]){
            base_cutout();
        }
}


module base_cutout(h = base_wall){
    
    translate([0,0,0]){
        hull(){
            translate([15,0,0]) cylinder( d = 10.1, h = h/2, center = true);
            translate([-15,0,0]) cylinder( d = 10.1, h = h/2, center = true);
        }
        translate([0,0,h/2]) cube([20.1,10.1,h], center = true);
        translate([15,0,h/2]) cylinder( d = M3_grip_d, h = h, center = true);
        translate([-15,0,h/2]) cylinder( d = M3_grip_d, h = h, center = true);
    }
}

module base_insert(h = base_wall){
    translate([0,0,-h]) difference(){
        union(){
            translate([15,0,0]) cylinder( d = 10, h = h/2, center = true);
            cube([30,10,h/2], center = true);
            translate([0,0,h/2]) cube([20,10,h], center = true);
            translate([-15,0,0]) cylinder( d = 10, h = h/2, center = true);
        }
            translate([15,0,0]) cylinder( d = M3_free_d, h = h/2, center = true);
            translate([-15,0,0]) cylinder( d = M3_free_d, h = h/2, center = true);
    }
}