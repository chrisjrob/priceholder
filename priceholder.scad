// priceholder.scad
// Price Holder
// 
// Copyright (C) 2013 Christopher Roberts
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
// 
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
// 
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.


// Global Parameters
label_width   = 70;
label_height  = 35;
labels_across =  3;
labels_down   =  5;
padding       =  2;
thickness     =  2;
roundedness   =  5;
overlap       =  2;
header        = 25;

// Derived Parameters
width = labels_across * (label_width + padding) + padding;
height = labels_down * (label_height + padding) + padding + header;

module priceholder() {

    difference() {

        // Things that exist
        union() {
            translate( v = [0, 0, thickness/2] ) {
                minkowski() {
                    cube( size = [width, height, thickness/2], center = true );
                    cylinder( h = thickness/2, r = roundedness );
                }
            }
        }

        // Things to be cut out
        union() {
            translate( v = [-52, height/2-header, thickness] ) {
                scale( v = [4, 4, 0] ) {
                    linear_extrude(height=thickness, convexity = 1) import("tridentlogo.dxf");
                }
            }
            for ( y = [1 : labels_down] ) {
                for ( x = [1 : labels_across] ) {
                    translate( v = [
                                    (x - labels_across/2) * (label_width + padding) - (label_width + padding)/2,
                                    (y - labels_down/2) * (label_height + padding) - (label_height + padding)/2 - header/2, 
                                    thickness
                                    ] ){
                        translate( v = [0, 0, -thickness/8] ) {
                            cube( size = [label_width, label_height, thickness/4], center = true );
                        }
                        translate( v = [0, label_height/4, thickness/2] ) { 
                            cube( size = [label_width, label_height/2, thickness], center = true );
                        }
                        translate( v = [0, -label_height/4, thickness/2] ) { 
                            cube( size = [label_width - overlap, label_height/2, thickness], center = true );
                        }
                    }
                }
            }
        }
    }

}

priceholder();
