use <path_extrude.scad>

W=70;

explode=1; // exploded model      
screw=0; // screw cap
add_handle=1; // Do we want to add handles at the end of the magnet flaps
Dmag=8+1;
Tflap=0.75;
Wflap=22;
include <reconyx_common.scad>

difference() {
    union() {
        translate([0,0,explode?30:0])  rotate([0,0,screw?-30:0]) cap();

        lensholder_attached();

        if (1) {
            translate([0,explode?30:0,0]) lensholder_mobile();
        }

        
        baseplate(W);

        if (add_handle) {
            translate([W/2+Wflap-5,-Dobj/2-1+H-6,T+2]) rotate([0,0,90]) handle(7,2,1.2);
            translate([-W/2-Wflap+5,-Dobj/2-1+H-6,T+2]) rotate([0,0,90]) handle(7,2,1.2);
        }

        // Flaps to hold the lens holder against the camera enclosure
        
        translate([W/2-10,-Dobj/2-1,-Tflap+0.001]) cube([10,5,Tflap]);
        translate([W/2-10,-Dobj/2-1+H-5,-Tflap+0.001]) cube([15,5,Tflap+T]);
        translate([-W/2,-Dobj/2-1,-Tflap+0.001]) cube([10,5,Tflap]);
        translate([-W/2-5,-Dobj/2-1+H-5,-Tflap+0.001]) cube([15,5,Tflap+T]);
        //translate([W/2,-Dobj/2-1+H-5,0]) cube([8,5,1]);
        //translate([-W/2-8,-Dobj/2-1+H-5,0]) cube([8,5,1]);
        
        if (1) {
            // little ears to stay attached to the box surface
           
            translate([-W/2-Wflap+3,-Dobj/2-1+H-12,T]) 
            difference() {
                color("blue") linear_extrude(2) {
                    polygon([[0,0],[Wflap,0],[Wflap+7,6],[Wflap+7,12],[0,12]]);
                }
                // Space for a 8mm x 0.75mm magnet
                color("green") translate([6,(12)/2,-0.25]) cylinder(h=1,r=Dmag/2,$fn=100);
            }
            translate([W/2-10,-Dobj/2-1+H-12,T]) 
            difference() {
                color("blue") linear_extrude(2) {
                    polygon([[0,6],[7,0],[Wflap+7,0],[Wflap+7,12],[0,12]]);
                }
                // Space for a 8mm x 0.75mm magnet
                color("green") translate([Wflap+7-6,(12)/2,-0.25]) cylinder(h=1,r=Dmag/2,$fn=100);
            }
        }
        
        }
        
    union() {
        // Optional debug cuts
        // translate([-100,-50,6]) cube([200,100,100]);
        // translate([-100,-50,-40]) cube([200,100,40+T+12]);
        // rotate([0,0,-30]) translate([-100,0,6]) cube([200,100,100]);
           
        center_cutout();

        corner_cutouts(W);
        
    }
}
