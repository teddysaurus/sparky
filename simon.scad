module pie_slice(d=3.0,a=30, h= 3.85) {
  intersection() {
    cylinder(d=d, h = h);
    cube([d/2,d/2,h]);
    rotate(90-a)     cube([d/2,d/2,h]);
  }
}

module tube(h = 10, r= 10, wall = 1)
{
    difference()
    {
        cylinder(h=h, r=r);
        cylinder(h=h, r=r - wall);
    }
}

module semicircle(r = 10, h = 1)
{
       intersection()
        {
               cylinder(r = r, h = h);
               translate([0,-r,0]) cube([2*r,2*r,h]);
        }
 }