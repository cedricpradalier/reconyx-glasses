
H=25;
H45=17;
W=92;
T=3;

explode=1; // exploded model      
screw=0; // screw cap
testLens=1; // type of lens, 1 = 38mm optometric insert, 0 = 40mm


Dobj=20;
Dled=10;


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

include <reconyx_common.scad>

difference() {
    union() {
     translate([0,0,explode?30:0])  cap();

        lensholder_attached();

        if (1) {
            translate([0,explode?30:0,0]) lensholder_mobile();
        }

        
        baseplate();

        
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
        translate([-16,0,-0.75]) cube([32,H/2+1.5,T+1.5+8]);
        
    }
}
