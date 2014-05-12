include <configuration.scad>;

space = 15;  // Between horizontal OpenBeam pieces.

power_supply_height = 30.5;
power_supply_width = 50.5;

$fn=80;
module power_supply() {
  difference() {
    translate([0, 5, 8])
      cube([power_supply_width+40, 18, 16], center=true);
    // Power supply body.
    translate([0, 7.5+space/2+1, 0]) cube([power_supply_width, power_supply_height, 100], center=true);
    // Screw holes.
    for (x = [-1, 1]) {
      translate([x*(power_supply_width/2+13), 1, 9]) cylinder(r=m3_wide_radius, h=40, center=true);
      #translate([x*(power_supply_width/2+13),1, 11]) cylinder(r=m3_nut_radius, h=18, center=true);
      translate([x*(power_supply_width/2+m3_nut_radius+2), 20, 9]) rotate([90, 0, 0]) cylinder(r=m3_wide_radius, h=40, center=true);
      translate([x*(power_supply_width/2+m3_nut_radius+2), 10, 9]) rotate([90, 30, 0]) cylinder(r=m3_nut_radius, h=40,$fn=6);
    }
  }
}

power_supply();
% translate([0, space+15, 0]) rotate([0, 0, 180]) power_supply();
