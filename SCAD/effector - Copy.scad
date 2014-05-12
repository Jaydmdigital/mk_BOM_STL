include <configuration.scad>;

separation = 40;  // Distance between ball joint mounting faces.
offset = 20;  // Same as DELTA_EFFECTOR_OFFSET in Marlin.
mount_radius = 13;  // Hotend mounting screws, standard would be 25mm.
hotend_radius = 16.1/2;  // Hole for the hotend (J-Head diameter is 16mm).
push_fit_height = 4;  // Length of brass threaded into printed plastic.
height = 8;
cone_r1 = 2.5;
cone_r2 = 14;

$fs=0.1;
$fa=5;
//$fn=200;
nut_d = 11.6;

module effector() {
  difference() {
    union() {
      cylinder(r=offset-2, h=height, center=true);
      for (a = [60:120:359]) rotate([0, 0, a]) {
	rotate([0, 0, 30]) translate([offset-2, 0, 0])
	  cube([10, 13, height], center=true);
	for (s = [-1, 1]) scale([s, 1, 1]) {
	  translate([0, offset, 0]) difference() {
	    intersection() {
	      cube([separation, 40, height], center=true);
	      translate([0, -4, 0]) rotate([0, 90, 0])
		cylinder(r=10, h=separation, center=true);
	      translate([separation/2-7, 0, 0]) rotate([0, 90, 0])
		cylinder(r1=cone_r2, r2=cone_r1, h=14, center=true);
	    }
	    rotate([0, 90, 0])
	      cylinder(r=m3_radius, h=separation+1, center=true);
	    rotate([90, 0, 90])
	      cylinder(r=m3_nut_radius, h=separation-19, center=true, $fn=6);
	  }
        }
      }
    }
    translate([0, 0, push_fit_height-height/2])   cylinder(r=hotend_radius, h=height);
    translate([0, 0, -6]) # import("m5_internal.stl");
    //translate([0,0,-2])cylinder(h=12, r=nut_d/2, center=true);
    for (a = [0:60:359]) rotate([0, 0, a]) {
      translate([0, mount_radius, 0])
	cylinder(r=m3_wide_radius, h=2*height, center=true);
    }
  }
}

translate([0, 0, height/2]) effector();
