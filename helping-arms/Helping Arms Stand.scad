$fn = 50;

box_l = 40; // Length
box_w = 40; // Width
box_h = 10; // Height
hole_d = 5; // Diameter of hole

difference() {
	minkowski() {			
		rotate([0,90,0]) cylinder([0,2,0], center=true);
		rotate([90,0,0]) cylinder([0,2,0], center=true);
		cylinder([0,2,0], center=true);
		cube([box_l, box_w, box_h], center = true);
	}
	translate([-box_l/4,0,0]) rotate([90,0,0]) cylinder(box_l+6,d=hole_d, center = true);
	translate([box_l/4,0,0]) rotate([90,0,0]) cylinder(box_l+6,d=hole_d, center = true);
}
