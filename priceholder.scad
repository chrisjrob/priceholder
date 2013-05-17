// Global Parameters
label_width   = 70;
label_height  = 40;
labels_across =  4;
labels_down   =  4;
padding       = 10;
thickness     =  4;
roundedness   =  5;

// Derived Parameters
width = labels_across * (label_width + padding) + padding;
height = labels_down * (label_height + padding) + padding;

module priceholder() {

    difference() {

        // Things that exist
        union() {
            translate( v = [0, 0, thickness/2] ) {
                minkowski() {
                    cube( size = [width, height, thickness], center = true );
                    cylinder( h = 1, r = roundedness );
                }
            }

        }

        // Things to be cut out
        union() {
            for ( y = [1 : labels_down] ) {
                for ( x = [1 : labels_across] ) {
                    translate( v = [
                                    (x - labels_across/2) * (label_width + padding) - (label_width + padding)/2,
                                    (y - labels_down/2) * (label_height + padding) - (label_height + padding)/2, 
                                    thickness
                                    ] ) {
                        cube( size = [label_width, label_height, thickness], center = true );
                    }
                }
            }
        }
    }

}

priceholder();

// http://en.wikibooks.org/wiki/OpenSCAD_User_Manual

// primitives
// cube(size = [1,2,3], center = true);
// sphere( r = 10, $fn=100 );
// circle( r = 10 );
// cylinder( h = 10, r = 20, $fs = 6, center = true );
// cylinder( h = 10, r1 = 10, r2 = 20, $fs = 6, center = false );
// polyhedron(points = [ [x, y, z], ... ], triangles = [ [p1, p2, p3..], ... ], convexity = N);
// polygon(points = [ [x, y], ... ], paths = [ [p1, p2, p3..], ... ], convexity = N);

// transormations
// scale(v = [x, y, z]) { ... }
// rotate(a=[0,180,0]) { ... }
// translate(v = [x, y, z]) { ... }
// mirror([ 0, 1, 0 ]) { ... }

// rounded box by combining a cube and single cylinder
// $fn=50;
// minkowski() {
//   cube([10,10,1]);
//   cylinder(r=2,h=1);
// }

// hull() {
//   translate([15,10,0]) circle(10);
//   circle(10);
// }

// import_dxf(file="design.dxf", layer="layername", origin = [100,100], scale = 0.5);
// linear_extrude(height = 10, center = true, convexity = 10, twist = 0, $fn = 100)
// rotate_extrude(convexity = 10, $fn = 100)
// import_stl("example012.stl", convexity = 5);

// for (z = [-1, 1] ) { ... } // two iterations, z = -1, z = 1
// for (z = [ 0 : 5 ] ) { ... } // range of interations step 1
// for (z = [ 0 : 2 : 5 ] ) { ... } // range of interations step 2

// for (i = [ [ 0, 0, 0 ], [...] ] ) { ... } // range of rotations or vectors
// usage say rotate($i) or translate($i)
// if ( x > y ) { ... } else { ... }
// assign (angle = i*360/20, distance = i*10, r = i*2)
