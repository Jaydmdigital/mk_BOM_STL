include <configuration.scad>;

use <microswitch.scad>;

thickness = 9;  // 1mm thicker than linear rail.
width = 15;  // Same as vertical extrusion.
height = 15;
$fn=120;
layer_height = 0.2;
//left=-1; right=1;
side = -1;


module endstop(offset=thickness/2,neg=1) {
  difference() {
    union() {
      cube([width, thickness, height], center=true);
      translate([0, 0, -height/4])cube([width+2, thickness, height/2], center=true);
     // translate([neg*(-(width+2+thickness-2)/2), 0, -height/4])cylinder(h=height/2, r=thickness/2, center=true);
      translate([0, 3.5, 0]) cube([3, thickness, height], center=true);
      
     // translate([width/2-offset, width/2+2, -height/4]) rotate(90) cube([width+thickness-thickness/2, thickness, height/2], center=true);
	}
    //cutout screw adjustment hole
    //translate([neg*(-(width+2+thickness-2)/2), 0, -height/4]) cylinder(h=height, r=m3_wide_radius, center=true);
    //translate([neg*(-(width+2+thickness-2)/2), 0, height/4 - 2.3]) 
    //translate([width/2+neg*offset, (thickness+width)/2, -height/4])  cylinder(h=height, r=m3_wide_radius, center=true);
   // translate([width/2+neg*offset, (thickness+width)/2, -height/4+ 2.3])rotate(30) cylinder(h=height/2, r=m3_nut_radius, center=true, $fn=6);
	
    
    translate([0, 0, 3]) rotate([90, 0, 0]) {
      cylinder(r=m3_wide_radius, h=20, center=true);
      translate([0, 0, 3.6-thickness/2]) {
        cylinder(r=3, h=10);
        translate([0, 5, 5])
          cube([6, 10, 10], center=true);
      }
      translate([0, 0, -thickness/2]) scale([1, 1, -1])
        cylinder(r1=m3_wide_radius, r2=7, h=4);
    }
    translate([0, -3-thickness/2, -2]) rotate([0, 180, 0]) {
      //% microswitch();
      for (x = [-9.5/2, 9.5/2]) {
        translate([x, 0, 0]) rotate([90, 0, 0])
          cylinder(r=2.5/2, h=40, center=true);
      }
    }  }

}


translate([0,7.5+thickness/2,0]) %cube([15,15,40],center=true);
//translate([0, 0, height/2]) endstop(-thickness/2,side);
translate([0, 0, height/2]) endstop(2,1);
%rotate([180,0,0])
//translate([side*(width-3), -(7.5+thickness/2), height/2+5]) 
translate([0,-(width+thickness), height/2+5])

endstop(-thickness/2,side);