$fn=50;
use <libs/rounded_corners.scad>;

length=145;
width=7;
height= 1;
hole_d= 3.5;
hole_offset=7-hole_d;
tab_length=10;

module holder() {
	union() {
		cylinder(height+1.5, d=hole_d - 1);
		translate([0,0,height+1.5]) scale([1,1,0.5]) sphere(d=hole_d + 1);
	}
}
union() {
	difference() {
		rounded_cube(width, length, height,5);
		translate([width/2,hole_offset,0]) cylinder(height, d=hole_d);
	}
	translate([width/2, length - hole_offset, height]) holder();
	translate([width/4, -tab_length, 0])
		rounded_cube(width-hole_offset,tab_length,height,5,[true, true, false, false]);
}