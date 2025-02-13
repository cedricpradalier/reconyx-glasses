
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

module ear() {
    difference() {
        cube([8,earT,Lear]);
        translate([4,5,Lear/2]) rotate([90,0,0]) cylinder(h=6,r=earScrew/2,$fn=100);
    }
}

difference() {
    union() {
 // Cap
        translate([0,0,explode?30:0]) 
         translate([0,0,Lholder+T-4]) rotate([0,0,screw?-30:0]) union() {
             color("blue") difference() {
                cylinder(h=5, r=Dlens/2+Dholder+2.2,$fn=100);
                 union() {
                    translate([0,0,-1]) cylinder(h=5, r=Dlens/2+Dholder+0.8,$fn=100);
                     rotate([0,0,0]) translate([0,0,-1]) rotate_extrude(angle=60,$fn=100) {
                        square([Dlens/2+Dholder+3,5]);
                 }
                    rotate([0,0,180]) translate([0,0,-1]) rotate_extrude(angle=60,$fn=100) {
                        square([Dlens/2+Dholder+3,5]);
                 }
                 }
            }
            color("black") 
            for (i=[0:4]) {
                rotate([0,0,-10-90*i]) 
                    rotate_extrude(angle=10,$fn=60) {
                       translate([Dlens/2+Dholder+0.8,2.5,0]) circle(0.5);
                     }
                 }
        }


        color("grey") union() {
            translate([0,0,Lholder+T-Lear]) 
                rotate([0,0,180+alpha]) translate([Dlens/2+0.5,0,0]) ear();
            translate([0,0,Lholder+T-Lear]) 
                rotate([0,0,alpha]) translate([Dlens/2+0.5,-earT,0]) ear();
             
            // Small rim to hold lens cap
            translate([0,0,T+0.001]) {
                rotate([0,0,180+alpha]) 
                    rotate_extrude(angle=60,$fn=100) {
                       translate([Dlens/2+Dholder,Lholder-0.5,0]) circle(0.5);
                     }
                rotate([0,0,180+alpha+90]) 
                    rotate_extrude(angle=60,$fn=100) {
                       translate([Dlens/2+Dholder,Lholder-0.5,0]) circle(0.5);
                     }
             }
             
             translate([0,0,T+0.001]) difference() {
                rotate([0,0,180+alpha]) rotate_extrude(angle=180,$fn=100) {
                     square([Dlens/2+1.5,Lholder]);
                 }
                color("green") union() {
                    translate([0,0,-1]) cylinder(h=Lholder+2,r=Dlens/2-3,$fn=100);
                    translate([19,-Dobj/2-1,0]) cube([2,H,5.5]);
                    translate([-21,-Dobj/2-1,0]) cube([2,H,5.5]);
                    for (i = [0:Nlens-1]) {
                        translate([0,0,Lstart+i*(Tlens+1)]) cylinder(h=Tlens,r=Dlens/2,$fn=100);
                    }
                    translate([0,-Dobj/2-1,0]) rotate([-45,0,0]) translate([-Dobj,-H45,-20]) cube([2*Dobj,H45,20]);
                }
            }
        }

        color("pink") 
        //translate([0,0,2*(Lholder+T)+0.5]) rotate([180,0,0])
        translate([0,explode?30:0,0])
        union() {
            translate([0,0,Lholder+T-Lear]) 
                rotate([0,0,alpha]) translate([Dlens/2+0.5,0,0]) ear();
            translate([0,0,Lholder+T-Lear]) 
                rotate([0,0,180+alpha]) translate([Dlens/2+0.5,-earT,0]) ear();
              // Small rim to hold lens cap
                translate([0,0,T+0.001]) {
                    rotate([0,0,alpha]) 
                        rotate_extrude(angle=60,$fn=100) {
                           translate([Dlens/2+Dholder,Lholder-0.5,0]) circle(0.5);
                         }
                    rotate([0,0,alpha+90]) 
                        rotate_extrude(angle=60,$fn=100) {
                           translate([Dlens/2+Dholder,Lholder-0.5,0]) circle(0.5);
                         }
                 }
            
            translate([0,0,T-0.001]) difference() {
                union() {
                    translate([0,0,8]) rotate([0,0,alpha]) rotate_extrude(angle=180,$fn=100) {
                     square([Dlens/2+1.5,Lholder-8]);
                 }
                 difference() {
                     union() {
                        translate([-19,-Dobj/2-1,0]) cube([38,H+3,T+1+5]);
                         translate([-19,-Dobj/2-1+H,-T]) cube([38,3,T]);
                     }
                     rotate([0,0,180+alpha]) translate([-30,0,-1]) cube([60, H, T+1+10]);
                 }
                 
             }
                color("green") union() {
                    translate([0,0,-1]) cylinder(h=Lholder+2,r=Dlens/2-3,$fn=100);
                    for (i = [0:Nlens-1]) {
                        translate([0,0,Lstart+i*(Tlens+1)]) cylinder(h=Tlens,r=Dlens/2,$fn=100);
                    }
                    translate([0,-Dobj/2-1,0]) rotate([-45,0,0]) translate([-Dobj,-H45,-20]) cube([2*Dobj,H45,20]);
                    translate([-16,-10,-0.75]) cube([32,H/2+10+1.5,T+1.5+4]);
                }
            }
        }

        
        translate([-W/2-14,-footH/2,-28+T]) 
        difference() {
            cube([14,footH,28]);
            union() {
                translate([14-6,-1,-1]) cube([6+1,footH+2,28-7.5+1]);
                translate([14-6-5,-1,4]) cube([6+5+1,footH+2,6]);
            }
        }

        translate([W/2,-Dobj/2-1,-4])
        union() {
            cube([13,H,T+4]);
            translate([9,Dobj/2+1-5/2,-5]) cube([4,5,5]);
            translate([7.001,Dobj/2+1-5/2,-5]) cube([2,5,2]);
        }


        difference() {
            union() {
                translate([-W/2,-Dobj/2-1,0]) cube([W,H,T]);
                //translate([0,-Dobj/2-1,0]) rotate([-45,0,0]) translate([-Dobj,-H45,0]) cube([2*Dobj,H45,T]);
                difference() {
                    translate([0,0,-Dobj/2-1+T*sqrt(2)]) rotate([-45,0,0]) 
                        translate([0,0,-T]) scale([1,sqrt(2),1]) 
                        cylinder(h=T,r=Dlens/2+1.5,$fn=100);
                    translate([-Dlens/2-2.5,-Dlens/2-2.5,-Dlens*sqrt(2)+0.001]) cube([Dlens+5,Dlens+5,Dlens*sqrt(2)]);
                    
                }
            }
            union() {
                color("green") translate([0,0,-1]) cylinder(h=T+2,r=Dobj/2,$fn=100);
                color("green") translate([-26.5,0,-1]) cylinder(h=T+2,r=Dled/2,$fn=100);
                color("green") translate([26.5,0,-1]) cylinder(h=T+2,r=Dled/2,$fn=100);
                color("orange") translate([-16,0,-0.75]) cube([32,H/2+5,T+1.5]);
                color("orange") translate([-W/2,-6,-0.01]) cube([5,12,1]);
                color("orange") translate([W/2-5,-6,-0.01]) cube([5,12,1]);
        //        color("orange") translate([-W/2+3.5,-0.2*H+1,-0.75]) cube([1.5,0.75*H,T+1.5]);
        //        color("orange") translate([-W/2+3,-0.2*H+1,-0.75]) cube([1.5,0.65*H,T+1.5]);
        //        color("orange") translate([W/2-5.0,-0.2*H+1,-0.75]) cube([1.5,0.75*H,T+1.5]);
        //        color("orange") translate([W/2-4.5,-0.2*H+1,-0.75]) cube([1.5,0.65*H,T+1.5]);
            }
        }

        }
        
    union() {
//            translate([-100,-50,6]) cube([200,100,100]);
//            translate([-100,footH/2,-40]) cube([200,100,100]);
        translate([-16,0,-0.75]) cube([32,H/2+1.5,T+1.5+8]);
        if (testLens) {
            // Opening for test lens handle
            Whandle=12;
            rotate([0,0,-30]) translate([Dlens/2-6,-Whandle/2,Lholder+T-(Tlens+2+Lholder_ex)+0.002]) union() {
                cube([10,Whandle,(Tlens+2)]);
                //translate([0,Whandle,0]) cube([10,Whandle,Tlens]);
            }
        }
    }
}
