$fn=80;

wid=61;
len=110;
offset = 5;

boss_l = 88.88;
boss_w = 42.96;
boss_r1 = 5;
boss_r2 = 3;
boss_h = 8;

difference(){
 union(){
   minkowski(){cube([len-4,wid-4,3.1],center=true); cylinder(r=2,h=0.1);}
  translate([-boss_l/2-offset,boss_w/2,boss_h/2])cylinder(h=boss_h,r1=boss_r1,r2=boss_r2, center=true);
  translate([boss_l/2-offset,boss_w/2,boss_h/2])cylinder(h=boss_h,r1=boss_r1,r2=boss_r2,center=true);
  translate([boss_l/2-offset,-boss_w/2,boss_h/2])cylinder(h=boss_h,r1=boss_r1,r2=boss_r2,center=true);
  translate([-boss_l/2-offset,-boss_w/2,boss_h/2])cylinder(h=boss_h,r1=boss_r1,r2=boss_r2,center=true);
  translate([0,wid/2-1,(3+0.5)/2])cube([len-4,2,1.4],center=true);
  translate([0,-(wid/2-1),(3+0.5)/2])cube([len-4,2,1.4],center=true);
 }
 translate([0-offset,0,-5]) minkowski(){cube([70,35,30],center=true); cylinder(r=2,h=1);}
 
  translate([-boss_l/2-offset,boss_w/2,boss_h/2])cylinder(h=boss_h*2,r=1.4,center=true);
  translate([boss_l/2-offset,boss_w/2,boss_h/2])cylinder(h=boss_h*2,r=1.4,center=true);
  translate([boss_l/2-offset,-boss_w/2,boss_h/2])cylinder(h=boss_h*2,r=1.4,center=true);
  translate([-boss_l/2-offset,-boss_w/2,boss_h/2])cylinder(h=boss_h*2,r=1.4,center=true);

}
