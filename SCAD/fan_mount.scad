include <configuration.scad>;

// Input parameters
mount_thickness = 3;                             // Overall thickness (mm)
mount_angle = 90
;                                // Angle to mount the fan at (degrees)
hole_radius = 12.5;                              // Radius at which the effector mount holes are made (mm)
effector_offset = 18;                            // Length of the side that offsets the fan from the effector (mm)
fan_radius = 20;                                 // overall fan radius, e.g. 40mm fan = 20 (mm)
fan_hole_pitch = 32;                             // pitch of the fan mounting holes (mm)
hole_offset = 3;                                 // space between thru holes and edges (mm)
hotend_radius = 8 + 0.25;                        // Radius of the hotend + buffer (mm)

trim_offset = 6;
trim_len = sqrt( (effector_offset*effector_offset) + (trim_offset*trim_offset));
trim_angle = asin( trim_offset/trim_len);

$fn=120;

// Calculated parameters
bracket_length = 2*(hole_offset+m3_wide_radius);                // Length of the angled portion (mm)
bracket_width = fan_hole_pitch+2*(hole_offset+m3_wide_radius);  // Overall bracket width (mm)



//rotate(a=90, v=[0,1,0]) // print on its side for a strong angle joint
difference() {
  union() {
    translate([0, hotend_radius+effector_offset, 0])
    rotate(a=mount_angle, v=[1,0,0])
      difference() {
        cube([bracket_width, bracket_length, mount_thickness]);
        translate([bracket_width/2, fan_radius+hole_offset, -0.5])
      #    cylinder(r=fan_radius, h=mount_thickness+1);

        // Fan mounting holes
        translate([m3_wide_radius+hole_offset, m3_wide_radius+hole_offset, -0.5])
          cylinder(r=m3_wide_radius, h=mount_thickness+1);
        translate([bracket_width-m3_wide_radius-hole_offset, m3_wide_radius+hole_offset, -0.5])
          cylinder(r=m3_wide_radius, h=mount_thickness+1);
    }

    // Effector mounting side
    translate([0, hotend_radius/2, 0])
      cube([bracket_width, effector_offset+hotend_radius/2, mount_thickness]);
  }

  //TRIM THE CORNERS
  translate([-trim_len/2+trim_offset/2,trim_len/2+trim_offset/2,1])rotate([0,0,trim_angle]) cube([trim_len,trim_len+trim_offset,mount_thickness*2],center=true);
  translate([bracket_width+trim_len/2-trim_offset/2,trim_len/2+trim_offset/2,1])rotate([0,0,-trim_angle]) cube([trim_len,trim_len+trim_offset,mount_thickness*2],center=true);
	
  // Thru holes
  for (hole_angle = [-30:60:30]) {
    translate([bracket_width/2, 0, 0])
      translate([sin(hole_angle)*hole_radius,cos(hole_angle)*hole_radius,-0.5])
      cylinder(r=m3_wide_radius, h=mount_thickness+1);
  }

  // Thru hole for hotend
  translate([bracket_width/2, 0, -0.5])
      cylinder(r=hotend_radius, h=mount_thickness+1);
};