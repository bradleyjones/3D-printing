$fn = 50;

glue_holder_freq = 8;
glue_spacing = 5;

base_l = 135;
base_w = 60;
base_h = 5;
module Base() {
minkowski() {
	cube([base_w,base_l,base_h]);
cylinder(1, 5);
}
	for (i = [1:glue_holder_freq]) {
		translate([base_w - (base_w - holder_w)/2, (glue_wall_thickness + glue_d + glue_spacing)*i - glue_spacing, base_h]) GlueHolder();
	}
}

holder_h = 60;
holder_w = 45;
module GunHolder() {
	wall_t = 5;
	tip_d = 27;
	holder_l = base_l - 35;
	difference() {
		translate([0,0,0]) cube([holder_w,holder_l,holder_h]);
		// Actual hole
		translate([holder_w/2,-26,40]) rotate([85,180,180])
		union() {
			translate([0,0,0]) cylinder(holder_l+20, d=holder_w - wall_t);
			translate([0,0, holder_l - 20]) cylinder(60, d=tip_d);
			translate([-(holder_w - wall_t)/2, -holder_h, 0]) cube([holder_w - wall_t, holder_h, holder_l +20]);
		}
		translate([0,holder_l,holder_h -12]) rotate([85,0,0]) cube([holder_w, holder_h, holder_l+20]);
	}
}

glue_d = 8; // diameter of glue (+1)
glue_wall_thickness = 2.8;
glue_h = 15;
module GlueHolder() {
	difference() {
		cylinder(glue_h, d=glue_d + glue_wall_thickness);
		cylinder(glue_h, d=glue_d);
	}
}

module main() {
	mirror([0,1,0])
	union() {
		Base();
		GunHolder();
	}
}

main();
