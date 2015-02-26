$fn = 50;

use <libs/rounded_corners.scad>;

base_length = 145;
base_width = 30;
base_height = 5;

generate_tab = true;
tab_side = "right";
tab_length = 60;
tab_width = 40;
tab_height = 2.4;

module tool_hold(hole_diameter, height, wall_width = 2.8) {
	difference() {
		cylinder(height, d=hole_diameter + wall_width);
		cylinder(height, d=hole_diameter);
	}
}

module solder_sucker_hold(tip_diameter, tip_height, shaft_diameter, wall_width=2.8) {
	union() {
		tool_hold(tip_diameter, tip_height, wall_width);
		tool_hold(shaft_diameter, tip_height + 15, wall_width);
	}
}

module evenly_space_along_base() {
	move_amount = (base_length/$children);
	for(i = [0:$children - 1]) {
		translate([base_width/2, i*move_amount + move_amount/2, base_height]) children(i);
	}
}

module tab() {
	if (tab_side == "right") {
		translate([base_width,base_length - tab_length - 22,0]) rounded_cube(tab_width, tab_length, tab_height, 15, [false, true, true, false]);
	} else {
		translate([-tab_width,base_length - tab_length - 22,0]) rounded_cube(tab_width, tab_length, tab_height, 15, [false, true, true, false]);
	}
}

module base() {	
	rounded_cube(base_width, base_length, base_height, 15);
}


union() {
	base();
	if (generate_tab == true) tab();
	evenly_space_along_base() {
		tool_hold(17.6, 15); // smaller yellow top solder
		tool_hold(22.2, 15); // larger 5-core solder
		// Replacement solder tips
		union() {
			translate([5,4.5,0]) tool_hold(8.4, 15);
			translate([-5,4.5,0]) tool_hold(8.4, 15);
			translate([0,-4.5,0]) tool_hold(8.4, 15);
		}
		solder_sucker_hold(8, 18, 21.2); // solder sucker
	}
}