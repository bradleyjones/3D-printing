$fn = 50;
use <libs/rounded_corners.scad>;

width = 40;
thickness = 5;
// Gap between bottom and top
height = 75;
// Laptop hold
laptop_depth = 45;
// Screw hold
screw_depth = 20;
screw_diameter = 4;

module evenly_space_along_base() {
	move_amount = (width/$children);
	for(i = [0:$children - 1]) {
		translate([i*move_amount + move_amount/2, screw_depth/2, 0]) children(i);
	}
}

module screw_holder() {
	difference() {
		rounded_cube(width,screw_depth,thickness,15,corners=[false,false,true,true]);
		evenly_space_along_base() {
			cylinder(h=thickness+1,d=screw_diameter);
			cylinder(h=thickness+1,d=screw_diameter);
		}
	}
}

module make(left=true) {
	union() {
		cube([width,height,thickness]);
		// laptop hold
		translate([0,1,0])
			rotate([90,0,0])
				rounded_cube(width,laptop_depth,thickness,15,corners=[false,false,true,true]);
		// laptop stay
		if (left==true) {
			translate([0,-1,width/2+thickness-1])
				rotate([90,90,90])
					rounded_cube(width/2,laptop_depth/2,thickness,15,corners=[false,false,false,true]);
		} else {
			translate([width-thickness,0,width/2+thickness])
				rotate([90,90,90])
					rounded_cube(width/2,laptop_depth/2,thickness,15,corners=[false,false,false,true]);
		}
		// Screw plate 1
		translate([width,thickness+height - 1,thickness/2 + 1])
			rotate([90,180,0])
				screw_holder();
		// Screw plate 2
		translate([0,thickness+height - 1,thickness/2 - 1])
			rotate([90,0,0])
				screw_holder();
	}
}

//left
//rotate([0,270,0])
//	make();
//right
translate([width+10, 0, width])
	rotate([0,90,0])
		make(left=false);