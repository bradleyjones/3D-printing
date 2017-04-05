$fn = 15;

use <../libs/rounded_corners.scad>;

// CAN BE CHANGED
// 52 -- colgate
// 48 -- pearl drops
internal_hold_diameter = 52;
wall_thickness = 4;
screw_diameter = 5;

// DO NOT CHANGE
wall_height = 10;
module shape(wall_thickness) {
  union() {
    cylinder(wall_height, d=internal_hold_diameter + wall_thickness, $fn=60);
    translate([-(internal_hold_diameter + wall_thickness) / 2,0,0])
    difference() {
      rounded_cube(internal_hold_diameter + wall_thickness,
                   (internal_hold_diameter + wall_thickness)/2, wall_height*2, 5,
                   corners=[false,false,true,true]);
      translate([0,0,wall_height])
        cube([internal_hold_diameter + wall_thickness,
             (internal_hold_diameter + wall_thickness)/4,
             wall_height]);
      translate([0,(internal_hold_diameter + wall_thickness)/4,wall_height])
      rotate([45,0,0])
        cube([internal_hold_diameter + wall_thickness,
             (internal_hold_diameter/4 + wall_thickness),
             wall_height]);
    }
  }
}

module holder() {
  difference() {
    shape(wall_thickness); // * 2 because move in all sides
    // Translate up by how thick the bottom should be
    translate([0,0,2])
      shape(0);
  }
}

module screw_hole() {
  cylinder(wall_thickness, d=screw_diameter);
}

minkowski(){
  difference() {
    holder();
    screw_hole();
    translate([internal_hold_diameter/4,
               (internal_hold_diameter/2 + wall_thickness),
               wall_height + screw_diameter/2])
    rotate ([90,0,0])
      screw_hole();
    translate([-internal_hold_diameter/4,
               (internal_hold_diameter/2 + wall_thickness),
               wall_height + screw_diameter/2])
    rotate ([90,0,0])
      screw_hole();
  }
  sphere(1);
}
