use <path_extrude.scad>

W=70;

explode=1; // exploded model      
screw=0; // screw cap
add_handle=0; // Do we want to add handles at the end of the magnet flaps
Dmag=8+1;
Tflap=1.0;
Wflap=22;
include <reconyx_common.scad>

Lholder1=Lstart+Tlens;
Whandle=12;
thetaHandle=Whandle/(Dlens/2+Dholder) * (180./PI);
Hhandle=4.5;
Hoverlap=3;
Hcap=Hoverlap+Lholder_ex;
Hear=Lholder1-Hoverlap+Hcap-Lear-1;
Dcap=Dlens/2+Dholder+1.5;

module lensholder_onepart() {
    translate([0,0,T]) 
    difference() {
        color("grey") union() {
                
                
                 
                difference() {
                    union() {
                        rotate([0,0,180+alpha]) translate([Dlens/2+Dholder-1,-earT,Hear]) ear(10);
                        rotate([0,0,alpha]) translate([Dlens/2+Dholder-1,0,Hear]) ear(10);
                    }
                    translate([0,0,Lholder1-Hoverlap-0.1]) 
                        cylinder(h=Hcap+0.2, r=Dcap+0.1,$fn=100);
                }
                
                 difference() {
                     union() {
                        translate([-19,-Dobj/2-1,0]) cube([38,H+3,T+1+4.5]);
                        translate([-19,-Dobj/2-1+H,-T]) cube([38,3,T]);
                         
                        rotate_extrude(angle=360,$fn=100) {
                            square([Dlens/2+Dholder,Lholder1]);
                         }
                     }
                    color("green") union() {
                        translate([0,0,-1]) cylinder(h=Lholder+2,r=Dlens/2-3,$fn=100);
                        translate([19,-Dobj/2-1,0]) cube([2,H,5.5]);
                        translate([-21,-Dobj/2-1,0]) cube([2,H,5.5]);
                        translate([0,0,Lstart]) cylinder(h=Tlens+1,r=Dlens/2,$fn=100);
                        translate([0,-Dobj/2-1,0]) rotate([-45,0,0]) translate([-Dobj,-H45,-20]) cube([2*Dobj,H45,20]);
                        // Little grooves to hold the rubber band
                        translate([-19,-Dobj/2-1+H+3,2]) rotate([0,0,45]) translate([-1.25,-1.25,0]) cube([2.5,2.5,8]); 
                        translate([19,-Dobj/2-1+H+3,2]) rotate([0,0,45]) translate([-1.25,-1.25,0]) cube([2.5,2.5,8]); 
                        
                    }
                }
                
            }
            if (testLens) {
                // Opening for test lens handle
                rotate([0,0,-60]) translate([0,0,Lstart+Tlens/2-Hhandle/2+0.002])     
                    rotate_extrude(angle=thetaHandle,$fn=100) {
                        square([Dlens/2+Dholder+1,Hhandle]);
                     }
                
                
            }
    }
}


module lensholder_cap() {
    translate([0,0,T]) color("blue") difference() {
        union() {
            // Small rim to hold lens cap
            for (i=[0:3]) {
                rotate([0,0,alpha+i*90]) 
                    rotate_extrude(angle=60,$fn=100) {
                       translate([Dcap,Lholder1-Hoverlap+Hcap-0.5,0]) circle(0.5);
                     }
             }
             rotate([0,0,alpha]) translate([Dlens/2+Dholder+1,-earT,Hear]) ear();
             rotate([0,0,180+alpha]) translate([Dlens/2+Dholder+1,0,Hear]) ear();
        
             translate([0,0,Lholder1-Hoverlap]) 
                cylinder(h=Hcap, r=Dcap,$fn=100);
        }
        union() {
                translate([0,0,-1]) cylinder(h=Lholder1+1, r=Dlens/2+Dholder+0.2,$fn=100);
                translate([0,0,-1]) cylinder(h=Lholder1-Hoverlap+Hcap+2, r=Dlens/2-3,$fn=100);     
            
                translate([0,0,-Dobj/2-1+T*sqrt(2)-T]) rotate([-45,0,0]) 
                        translate([0,0,-T]) scale([1,sqrt(2),1]) 
                        cylinder(h=T,r=Dlens/2+Dholder,$fn=100);
            
                if (testLens) {
                    // Opening for test lens handle
                    rotate([0,0,-60]) translate([0,0,Lstart-3])     
                        rotate_extrude(angle=thetaHandle,$fn=100) {
                            square([Dlens/2+Dholder+3,Tlens+4]);
                         }
                    
                    
                }
             }
        }
}

module cap2() {
    translate([0,0,T]) 
    translate([0,0,Lholder1]) 
    union() {
             color("cyan") difference() {
                cylinder(h=5, r=Dcap+2.2,$fn=100);
                 union() {
                    translate([0,0,-1]) cylinder(h=5, r=Dcap+0.8,$fn=100);
                     rotate([0,0,0]) translate([0,0,-1]) rotate_extrude(angle=60,$fn=100) {
                        square([Dcap+3,5]);
                 }
                 rotate([0,0,180]) translate([0,0,-1]) rotate_extrude(angle=60,$fn=100) {
                        square([Dcap+3,5]);
                 }
                 }
            }
            color("black") 
            for (i=[0:4]) {
                rotate([0,0,-10-90*i]) 
                    rotate_extrude(angle=10,$fn=60) {
                       translate([Dcap+0.8,2.5,0]) circle(0.5);
                     }
                 }
        }
}

difference() {
    union() {
        translate([0,0,explode?60:30])  rotate([0,0,screw?-30:0]) cap2();

        //lensholder_attached();
        lensholder_onepart();
        translate([0,0,explode?30:0]) 
        lensholder_cap();

        if (0) {
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
                    polygon([[0,0],[Wflap-2,0],[Wflap+7,6],[Wflap+7,12],[0,12]]);
                }
                // Space for a 8mm x 0.75mm magnet
                color("green") translate([6,(12)/2,-0.25]) cylinder(h=1,r=Dmag/2,$fn=100);
            }
            translate([W/2-10,-Dobj/2-1+H-12,T]) 
            difference() {
                color("blue") linear_extrude(2) {
                    polygon([[0,6],[9,0],[Wflap+7,0],[Wflap+7,12],[0,12]]);
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
           
        translate([-16,0,-0.75]) cube([32,H/2+1.5,T+1+8]);
        corner_cutouts(W);
        
    }
}
