$fn = 50;

use <libs/rounded_corners.scad>;

base_length = 50;
base_width = 30;
base_height = 3;

generate_tab = true;
tab_side = "right";
tab_length = 40;
tab_width = 20;
tab_height = 1.5;
tab_offset = 5;

module tool_hold_rectangle(tool_width, tool_depth, height, wall_width = 2.8) {
	translate([-tool_width/2,-tool_depth/2,0])
	difference() {
		translate([-wall_width/2,-wall_width/2,0]) rounded_cube(tool_width + wall_width, tool_depth + wall_width, height, 5);
		cube([tool_width, tool_depth, height]);
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
		translate([base_width,base_length - tab_length - tab_offset,0]) rounded_cube(tab_width, tab_length, tab_height, 15, [false, true, true, false]);
	} else {
		translate([-tab_width,base_length - tab_length - tab_offset,0]) rounded_cube(tab_width, tab_length, tab_height, 15, [false, true, true, false]);
	}
}

module base() {	
	rounded_cube(base_width, base_length, base_height, 15);
}


union() {
	base();
	if (generate_tab == true) tab();
	evenly_space_along_base() {
		tool_hold_rectangle(18,7, 35);
		tool_hold_rectangle(9,4, 30);
	}
}