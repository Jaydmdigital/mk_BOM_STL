include <configuration.scad>;

$fn=120;

sticky_width = 25.4;
sticky_length = 25.4;
sticky_offset = 8;  // Distance from screw center to glass edge.

// Make the round edge line up with the outside of OpenBeam.
screw_offset = sticky_width/2 - 7.5;
cube_length = sticky_length + sticky_offset - screw_offset;

module glass_tab() {
  difference() {
    translate([0, screw_offset, 0]) union() {
      cylinder(r=sticky_width/2, h=thickness, center=true);
      translate([0, cube_length/2, 0])
        cube([sticky_width, cube_length, thickness], center=true);
    }
    cylinder(r=m3_wide_radius, h=20, center=true);
  }
  // Scotch restickable tab for mounting.
  translate([0, sticky_length/2+sticky_offset, thickness/2]) %
    cube([sticky_width, sticky_length, 0.7], center=true);
  // Horizontal OpenBeam.
  translate([0, 0, (15+thickness)/-2]) %
    cube([100, 15, 15], center=true);
}

translate([0, 0, thickness/2]) glass_tab();
//translate([0, 170/2+6.8, thickness]) %cylinder(h=3, r=170/2);
difference(){
rotate([0,180,-90]) translate([-14.65, -12.76, -11])glass_clip();
//translate([0,0,12]) cylinder(h=10, r=3, center=true);
}

module glass_clip(){
// works in conjunction with tab
//import("Spiral+Bed+Clamp.STL", convexity=10);
//cylinder(r=sticky_width/2, h=thickness, center=true);

}