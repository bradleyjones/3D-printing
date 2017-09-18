$fn = 50;

use <../libs/rounded_corners.scad>;

base_height=3;

difference() {
  rounded_cube(23, 23, 20, 10);
  translate([1,1,base_height]) rounded_cube(21,21,20,10);
}

