// Round Corners
// author: Bradley Jones

$fn=30;

// Makes the cut out required to diff with the cube
module cut_out(radius, height) {
	translate([-radius/2,-radius/2,height/2]) 
	difference() {
		translate([radius/4,radius/4,0]) cube([radius/2, radius/2, height], center=true);
		cylinder(height, d=radius, center=true);
	}
}

// corners=[(0,0),(1,0),(0,1),(1,1)]
module rounded_cube(width, length, height, radius, corners=[true,true,true,true]) {
	difference() {
		cube([width, length, height]);
		// Starting with corner at 0,0 then working anti-clockwise
		if (corners[0]==true) 
			translate([-0.1,-0.1,0]) rotate([0,0,180]) cut_out(radius, height);
		if (corners[1]==true) 
			translate([width + 0.1,-0.1,0]) rotate([0,0,270]) cut_out(radius, height);
		if (corners[2]==true) 
			translate([width + 0.1,length+0.1,0]) rotate([0,0,0]) cut_out(radius, height);
		if (corners[3]==true) 
			translate([-0.1,length + 0.1,0]) rotate([0,0,90]) cut_out(radius, height);

	}
}
