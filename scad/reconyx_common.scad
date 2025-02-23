use <Round-Anything/polyround.scad>

H=25;
H45=17;
T=3;

Dobj=20;
Dled=10;

testLens=1; // type of lens, 1 = 38mm optometric insert, 0 = 40mm
 

Dlens=testLens?38+0.4:40+0.2;
Tlens=2.1;
Dsupport=1.5;
Dholder=testLens?1.5:1.0;

Nlens=1;
Lstart=11;
Lholder_ex=3.5;
Lholder=Lstart+Nlens*(Tlens+1)+Lholder_ex;
footH=H/1.8;
alpha=22;
Lear=11;
earT=3;
earScrew=3.3;

// size of the rotated square removed in the piece corners (in corner_cutouts)
halfdiag=9;
face=halfdiag/(sqrt(2)/2)+0.001;
 

module ear(earW=8,peg=0) {
    if (peg!=0) {
        union() {
            // cube([earW,earT,Lear]);
            rotate([90,0,0]) translate([0,0,-earT]) linear_extrude(earT) {
                polygon(polyRound([[0,0,1],[0,Lear,1],[earW,Lear,1],[earW,0,1]],20));
            }
            translate([earW-4,0,Lear-3-earScrew/2]) rotate([-90,0,0]) cylinder(h=2*earT,r=earScrew/2-0.15,$fn=100);
        }
    } else {
        difference() {
            // cube([earW,earT,Lear]);
            rotate([90,0,0]) translate([0,0,-earT]) linear_extrude(earT) {
                polygon(polyRound([[0,0,1],[0,Lear,1],[earW,Lear,1],[earW,0,1]],20));
            }
            translate([earW-4,-1,Lear-3-earScrew/2]) rotate([-90,0,0]) cylinder(h=earT+2,r=earScrew/2,$fn=100);
        }
    }
}

module cap() {
    translate([0,0,Lholder+T-4]) union() {
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
}

module lensholder_attached() {
    difference() {
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
                        square([Dlens/2+Dholder,Lholder]);
                     }
                    color("green") union() {
                        translate([0,0,-1]) cylinder(h=Lholder+2,r=Dlens/2-Dsupport,$fn=100);
                        translate([19,-Dobj/2-1,0]) cube([2,H,5.5]);
                        translate([-21,-Dobj/2-1,0]) cube([2,H,5.5]);
                        for (i = [0:Nlens-1]) {
                            translate([0,0,Lstart+i*(Tlens+1)]) cylinder(h=Tlens,r=Dlens/2,$fn=100);
                        }
                        translate([0,-Dobj/2-1,0]) rotate([-45,0,0]) translate([-Dobj,-H45,-20]) cube([2*Dobj,H45,20]);
                    }
                }
            }
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

module lensholder_mobile() {
    color("pink") 
            //translate([0,0,2*(Lholder+T)+0.5]) rotate([180,0,0])
            
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
                    // Main lens holder (pink side)
                    union() {
                        translate([0,0,8]) rotate([0,0,alpha]) rotate_extrude(angle=180,$fn=100) {
                         square([Dlens/2+Dholder,Lholder-8]);
                     }
                     // Bottom cube (pink side)
                     difference() {
                         union() {
                            translate([-19,-Dobj/2-1,0]) cube([38,H+5,T+1+5]);
                             translate([-19,-Dobj/2-1+H,-T]) cube([38,5,T]);
                         }
                         union() {
                            rotate([0,0,180+alpha]) translate([-30,0,-1]) cube([60, H, T+1+10]);
                            // Little grooves to hold the rubber band
                            translate([-19,-Dobj/2-1+H+5,2]) cylinder(h=4,r=1.5);
                            translate([19,-Dobj/2-1+H+5,2]) cylinder(h=4,r=1.5);
                         }
                     }
                     
                 }
                 // Cut-out in the pink side
                    color("green") union() {
                        translate([0,0,-1]) cylinder(h=Lholder+2,r=Dlens/2-Dsupport,$fn=100);
                        // Lens groove
                        for (i = [0:Nlens-1]) {
                            translate([0,0,Lstart+i*(Tlens+1)]) cylinder(h=Tlens,r=Dlens/2,$fn=100);
                        }
                        
                        translate([-16,-10,-0.75]) cube([32,H/2+10+1.5,T+1.5+4]);
                    }
                }
            }
}

module baseplate(width) {
    difference() {
            union() {
                translate([-width/2,-Dobj/2-1,0]) cube([width,H,T]);
                //translate([0,-Dobj/2-1,0]) rotate([-45,0,0]) translate([-Dobj,-H45,0]) cube([2*Dobj,H45,T]);
                difference() {
                    translate([0,0,-Dobj/2-1+T*sqrt(2)]) rotate([-45,0,0]) 
                        translate([0,0,-T]) scale([1,sqrt(2),1]) 
                        cylinder(h=T,r=Dlens/2+Dholder,$fn=100);
                    translate([-Dlens/2-2.5,-Dlens/2-2.5,-Dlens*sqrt(2)+0.001]) cube([Dlens+5,Dlens+5,Dlens*sqrt(2)]);
                    
                }
            }
            union() {
                color("green") translate([0,0,-1]) cylinder(h=T+2,r=Dobj/2,$fn=100);
                
                color("green") translate([-26.5,0,-1]) cylinder(h=T+2,r1=Dled/2,r2=(Dled+3)/2,$fn=100);
                color("green") translate([26.5,0,-1]) cylinder(h=T+2,r1=Dled/2,r2=(Dled+3)/2,$fn=100);
                color("orange") translate([-16,0,-0.75]) cube([32,H/2+5,T+1.5]);
                translate([-16,-T*sqrt(3),-0.75]) rotate([-60,0,0]) cube([32,H/2+1.5,T*5]);
            }
        }
}

module corner_cutouts(width) {
            // Oblique corner cut-out
        translate([width/2,-Dobj/2-1,T-2]) 
            rotate([0,0,45]) translate([-face/2,-face/2,0]) cube([face,face,3]);
        translate([-width/2,-Dobj/2-1,T-2]) 
            rotate([0,0,45]) translate([-face/2,-face/2,0]) cube([face,face,3]);
}

module center_cutout() {
    translate([-16,0,-0.75]) cube([32,H/2+1.5,T+1+8]);
}

module handle(w,h,radius) {
    translate([-w/2,0,0]) {
        cylinder(h,r=radius,$fn=30);
        translate([w,0,0]) cylinder(h,r=radius,$fn=30);
        translate([w/2,0,h]) rotate([90,0,0]) rotate_extrude(angle=180,$fn=30) {
            translate([w/2,0,0]) circle(r=radius);
        }
    }
}