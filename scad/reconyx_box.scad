
H=25;
H45=17;
W=70;
T=3;

Dobj=20;
Dled=10;

explode=1; // exploded model      
screw=0; // screw cap
testLens=1; // type of lens, 1 = 38mm optometric insert, 0 = 40mm

Dlens=testLens?38:40;
Tlens=2.05;
Dholder=testLens?1.5:1.0;

Nlens=1;
Lstart=11;
Lholder_ex=4;
Lholder=Lstart+Nlens*(Tlens+1)+Lholder_ex;
footH=H/1.8;
alpha=25;
Lear=12;
earT=3;
earScrew=3.2;
// size of the rotated square removed in the piece corners
halfdiag=9;
face=halfdiag/(sqrt(2)/2)+0.001;
 
  
include <reconyx_common.scad>

difference() {
    union() {
       translate([0,0,explode?30:0])  cap();

        lensholder_attached();

        if (1) {
            translate([0,explode?30:0,0]) lensholder_mobile();
        }

        
        baseplate();


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
           
        // Center cut-out
        translate([-16,0,-0.75]) cube([32,H/2+1.5,T+1+8]);
        
        // Oblique corner cut-out
        translate([W/2,-Dobj/2-1,T-2]) 
            rotate([0,0,45]) translate([-face/2,-face/2,0]) cube([face,face,3]);
        translate([-W/2,-Dobj/2-1,T-2]) 
            rotate([0,0,45]) translate([-face/2,-face/2,0]) cube([face,face,3]);
        
    }
}
