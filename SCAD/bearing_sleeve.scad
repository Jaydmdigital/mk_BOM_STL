
include <MCAD/fillets.scad>;

$fn=200;
$fs=0.1;
$fa=0.5;

bearing_h=6;
bearing_r=10/2+0.5;

flange_h=0.6;
flange_r=bearing_r+4;

sleeve_r=bearing_r+0.9;

difference(){
  union(){
    cylinder(h=bearing_h,r=sleeve_r,center=true);
    translate([0,0,-(bearing_h-flange_h)/2])cylinder(h=flange_h,r=flange_r,center=true);
  }
  translate([0,0,0.6])cylinder(h=bearing_h,r=bearing_r,center=true);
  cylinder(h=bearing_h+2,r=bearing_r-1,center=true);
  //translate([0,0,bearing_h-2]) cylinder(h=bearing_h,r1=bearing_r, r2=sleeve_r,center=true);
}