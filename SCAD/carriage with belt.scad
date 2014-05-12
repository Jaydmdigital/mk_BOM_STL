include <configuration.scad>;
$fn=120;

// Belt parameters
belt_width_clamp = 6;              // width of the belt, typically 6 (mm)
belt_thickness = 1.0 - 0.05;       // slightly less than actual belt thickness for compression fit (mm)           
belt_pitch = 2.0;                  // tooth pitch on the belt, 2 for GT2 (mm)
tooth_radius = 0.8;                // belt tooth radius, 0.8 for GT2 (mm)

separation = 40;
thickness = 6;

horn_thickness = 13;
horn_x = 8;

belt_width = 5;
belt_x = 5.6;
belt_z = 7;
corner_radius = 3.5;

module carriage() {
  // Timing belt (up and down).
  translate([-belt_x, 0, belt_z + belt_width/2]) %
    cube([1.7, 100, belt_width], center=true);
  translate([belt_x+1.23, 0, belt_z + belt_width/2]) %
    cube([2.3, 100, belt_width], center=true);
  difference() {
    union() {
      // Main body.
      translate([0, 4, thickness/2])
        cube([27, 40, thickness], center=true);
      // Ball joint mount horns.
      for (x = [-1, 1]) {
        scale([x, 1, 1]) intersection() {
          translate([0, 15, horn_thickness/2])
             cube([separation, 18, horn_thickness], center=true);
          translate([horn_x, 16, horn_thickness/2]) rotate([0, 90, 0])
            cylinder(r1=14, r2=2.5, h=separation/2-horn_x);
        }
      }

      // Avoid touching diagonal push rods (carbon tube).
      difference() {
        translate([10.75, 2.5, horn_thickness/2+1])
          cube([5.5, 37, horn_thickness-2], center=true);

        translate([23, -12, 12.5]) rotate([30, 40, 30])
          cube([40, 40, 20], center=true);
        translate([10, -10, 0])
          cylinder(r=m3_wide_radius+1.5, h=100, center=true);

      }

      // Belt clamps
      for (y = [[9, -1], [-1, 1]]) {
        translate([2.20, y[0], horn_thickness/2+1])
          color("red") hull() {
            translate([ corner_radius-1,  -y[1] * corner_radius + y[1], 0]) cube([2, 2, horn_thickness-2], center=true);
            cylinder(h=horn_thickness-2, r=corner_radius,  center=true);
          }
      }

      // top cube
      translate([2.20, 19, horn_thickness/2+1])
        color("red") difference() {
          cube([7, 10, horn_thickness-2], center=true);
          translate([2.8, -3,1])
            cube([1.6, 7.6, 10], center=true);
			translate([-1.5,-5,-1.5]) {
	       cube([belt_thickness,10,10]);
    		 for (mult = [0:5]) {
			     translate([1,belt_pitch*mult,0]) cylinder(r=tooth_radius, h=10);
			  		}
			  } 
        }

      // bottom cube
      translate([2.20, -11, horn_thickness/2+1])
          color("red") difference() {
			 cube([7, 10, horn_thickness-2], center=true);
          translate([-1.5,-5,-1.5]) {
	       cube([belt_thickness,10,10]);
    		 for (mult = [0:5]) {
			     translate([1,belt_pitch*mult,0]) cylinder(r=tooth_radius, h=10);
			  		}
			  } }
    }

    // Screws for linear slider.
    for (x = [-10, 10]) {
      for (y = [-10, 10]) {
        translate([x, y, thickness]) 
          cylinder(r=m3_wide_radius, h=30, center=true);
      }
    }
    // Screws for ball joints.
    translate([0, 16, horn_thickness/2]) rotate([0, 90, 0]) #
      cylinder(r=m3_wide_radius, h=60, center=true);
    // Lock nuts for ball joints.
    for (x = [-1, 1]) {
      scale([x, 1, 1]) intersection() {
        translate([horn_x, 16, horn_thickness/2]) rotate([90, 0, -90])
          cylinder(r1=m3_nut_radius, r2=m3_nut_radius+0.5, h=8, center=true, $fn=6);
      }
    }
  }
}

carriage();
