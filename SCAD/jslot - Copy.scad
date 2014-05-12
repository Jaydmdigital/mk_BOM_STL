include <configuration.scad>;

separation = 40;  // Distance between ball joint mounting faces.
offset = 20;  // Same as DELTA_EFFECTOR_OFFSET in Marlin.
mount_radius = 12.5;  // Hotend mounting screws, standard would be 25mm.
hotend_radius = 8.1;  // Hole for the hotend (J-Head diameter is 16mm).
hotend_neck_radius = 12.1/2;
push_fit_height = 4;  // Length of brass threaded into printed plastic.
height = 9.2;

//$fs=0.1;
//$fa=0.9;
$fn=60;

module effector() {
  difference() {
    union() {
      cylinder(r=offset, h=height, center=true);      
    }
    translate([0,0,-9.2/2])union(){
    translate([0,-14,0])cube([11.4,24.5,9.4],center=true);
     cylinder(r=12/2, h=9.4,center=true);
    }
    translate([0,0,9.2/2])union(){
     translate([0,-13,0])cube([16.2,24.5,9.2],center=true);
     cylinder(r=16.2/2, h=9.2,center=true);
    }

    for (a = [0:60:359]) rotate([0, 0, a]) {
      translate([0, mount_radius, 0]) cylinder(r=m3_radius, h=2*height, center=true);
      translate([0, mount_radius, -3]) rotate(0)cylinder(r=m3_nut_radius, h=4, center=true, $fn=6);
      translate([0, mount_radius, 3]) rotate(0)cylinder(r=m3_nut_radius, h=4, center=true, $fn=6);
    }
  }
}

projection()
translate([0,0,-4.1])difference() {
  translate([0, 0, height/2]) effector();
  translate([0,0,height])cylinder(h=10,r=30,center=true);
  cylinder(h=8,r=30,center=true);
}
