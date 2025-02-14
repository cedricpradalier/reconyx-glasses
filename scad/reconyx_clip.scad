

W=92;

explode=1; // exploded model      
screw=0; // screw cap


include <reconyx_common.scad>

difference() {
    union() {
     translate([0,0,explode?30:0])  rotate([0,0,screw?-30:0]) cap();

        lensholder_attached();

        if (1) {
            translate([0,explode?30:0,0]) lensholder_mobile();
        }

        
        baseplate(W);

        
        // Left leg to attach to reconyx 
        translate([-W/2-14,-footH/2,-28+T]) 
        difference() {
            cube([14,footH,28]);
            union() {
                translate([14-6,-1,-1]) cube([6+1,footH+2,28-7.5+1]);
                translate([14-6-5,-1,4]) cube([6+5+1,footH+2,6]);
            }
        }

        // Right leg to clip in the camera side
        translate([W/2,-Dobj/2-1,-4])
        union() {
            cube([13,H,T+4]);
            translate([9,Dobj/2+1-5/2,-5]) cube([4,5,5]);
            translate([7.001,Dobj/2+1-5/2,-5]) cube([2,5,2]);
        }
    }

               
    union() {
//            translate([-100,-50,6]) cube([200,100,100]);
//            translate([-100,footH/2,-40]) cube([200,100,100]);
        center_cutout();
    }
}
