

W=70;


explode=1; // exploded model      
screw=0; // screw cap

  
include <reconyx_common.scad>
// projection() translate([0,0,T+3])
difference() {
    union() {
      translate([0,0,explode?30:0])  rotate([0,0,screw?-30:0]) cap();

        lensholder_attached();

        if (1) {
            translate([0,explode?30:0,0]) lensholder_mobile();
        }

        
        baseplate(W);


        // Flaps to hold the lens holder against the camera enclosure
        translate([W/2-10,-Dobj/2-1,-1+0.001]) cube([15,5,1]);
        translate([W/2-10,-Dobj/2-1+H-5,-1+0.001]) cube([15,5,1+T]);
        translate([W/2,-Dobj/2-1+H-5,0]) cube([15,5,1]);
        translate([-W/2-5,-Dobj/2-1,-1+0.001]) cube([15,5,1]);
        translate([-W/2-5,-Dobj/2-1+H-5,-1+0.001]) cube([15,5,1+T]);
        translate([-W/2-15,-Dobj/2-1+H-5,0]) cube([15,5,1]);
        
        if (1) {
            // little ears to stay attached to the box surface
            translate([W/2-3,-Dobj/2-1+halfdiag,T]) cube([8,H-halfdiag,1]);
            translate([-W/2-5,-Dobj/2-1+halfdiag,T]) cube([8,H-halfdiag,1]);
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
