$fn=50;

thickness = 1.6;
outer_d = 34.5;
inner_d = 25;

difference() {
  union() {
    difference() {
        cylinder(15, d=outer_d + thickness);
        translate([0,0,2])
        cylinder(15, d=outer_d);
    }
    translate([0,0,2])
    cylinder(4, d=inner_d);
  }
  cylinder(15, d=inner_d - thickness);
}
