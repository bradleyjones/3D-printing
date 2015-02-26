$fn = 50;
use <libs/rounded_corners.scad>;

top_length = 18;
top_width = 14.5;
bottom_length = 23;
bottom_width = 18;
height = 9;

difference() {
	hull() {
		rounded_cube(bottom_length, bottom_width, 1, 5);
		translate([(bottom_length - top_length)/2, (bottom_width - top_width)/2,height-1]) rotate([-10,0,0]) rounded_cube(top_length, top_width, 1, 5);
	}
	translate([(bottom_length - 13)/2, (bottom_width - 13)/2, 0]) cube([13,13,height - 3]); 
}