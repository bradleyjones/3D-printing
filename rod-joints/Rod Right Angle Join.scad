$fn = 50;
use <libs/rounded_corners.scad>;

rod_diameter = 8;
offset = 3;
width = rod_diameter + offset;
length = (rod_diameter*3) + (offset*3);
height = 15;

module evenly_space_along_base() {
	move_amount = (length/$children);
	for(i = [0:$children - 1]) {
		translate([width/2, i*move_amount + move_amount/2, 0]) children(i);
	}
}

difference() {
	rounded_cube(width, length, height, 15);
	evenly_space_along_base() {
		cylinder(height+2, d=rod_diameter + 1);
		translate([(-width/2)-1,0,height/2]) rotate([90,0,90]) cylinder(width+2, d=rod_diameter + 1);
	}
	// cutout one end
	translate([(width/2) - (rod_diameter-1)/2,0,0]) cube([rod_diameter-1,offset*2, height]);
}