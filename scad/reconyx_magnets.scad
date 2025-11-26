use <Round-Anything/polyround.scad>


W=70;

explode=true; // exploded model      
screw=false; // screw cap
add_handle=false; // Do we want to add handles at the end of the magnet flaps
attach_flap=false; // True if we want to print in powder, False otherwise
detach_flap=false;
use_plug=true;
minimag=false;
engrave_flap=true;
engrave_cap=true;
engrave_mode=+1; // -1, 0, +1
Tmag=minimag?0.75:3.15;
Tentrefer=minimag?0.75:1;
Dmag=minimag?(8+1):(10+0.5);
TflapSupport=0.0; // Thickness of support pads. Probably not needed
Tflap=3.0;
Tflapcover=1.5;
Wflap=Dmag+11;
flapScrew=use_plug?4:3.2;
include <reconyx_common.scad>

Lholder1=Lstart+Tlens;
Whandle=12;
thetaHandle=Whandle/(Dlens/2+Dholder) * (180./PI);
Hhandle=4.5;
Hoverlap=3;
Hcap=Hoverlap+Lholder_ex+1;
Hear=Lholder1-Hoverlap+Hcap-Lear-1;
Dcap=Dlens/2+Dholder+1.5;

module lensholder_onepart() {
    translate([0,0,T]) 
    difference() {
        color("grey") union() {
                
                
                 
                difference() {
                    union() {
                        rotate([0,0,180+alpha]) translate([Dlens/2+Dholder-1,0,Hear]) {
                            ear(11);
                            translate([0,0.35,0.5]) rotate([-120,0,0]) linear_extrude(earT) {
                                polygon([[0,8],[0,0],[9.25,0],[3,8]]);
                            }
                            //translate([0,0,-6]) cube([5,earT,7]); 
                        }
                        rotate([0,0,alpha]) translate([Dlens/2+Dholder-1,0,Hear]) {
                            ear(11);
                            translate([0,0,-6]) cube([10,earT,7]); 
                        }
                    }
                    translate([0,0,Lholder1-Hoverlap-0.1]) 
                        cylinder(h=Hcap+0.2, r=Dcap+0.1,$fn=100);
                }
                
                 difference() {
                     union() {
                        translate([-19,-Dobj/2+2,0]) cube([38,H,T+1+5.75]);
                        //translate([-19,-Dobj/2-1+H,-T]) cube([38,3,T]);
                        intersection() {
                            translate([-19,-Dobj/2-1+H,-T]) 
                                rotate([0,90,0]) linear_extrude(38) {
                                polygon([[0,0.5],[0,-1],[-T-2,-1],[-T-2,Dlens/2+Dholder+4-(-Dobj/2-1+H)]]);
                            }
                            translate([0,0,-T]) union() {
                                    cylinder(r=Dlens/2+Dholder,h=10,$fn=100);
                                    translate([0,-Dobj/2-1+H+1.5,T/2]) cube([38,3,T],center=true);
                              
                            }
                        }
                         
                        rotate_extrude(angle=360,$fn=100) {
                            square([Dlens/2+Dholder,Lholder1]);
                         }
                     }
                    color("green") union() {
                        translate([0,0,-1]) cylinder(h=Lholder+2,r=Dlens/2-Dsupport,$fn=100);
                        translate([20.25,-Dobj/2-1,0]) cube([2,H,5.5]);
                        translate([-22.25,-Dobj/2-1,0]) cube([2,H,5.5]);
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
             
             rotate([0,0,alpha]) translate([Dlens/2+Dholder-1,-earT,Hear]) ear(11,1);
             rotate([0,0,180+alpha]) translate([Dlens/2+Dholder-1,-earT,Hear]) ear(11,0);
        
             translate([0,0,Lholder1-Hoverlap]) 
                cylinder(h=Hcap, r=Dcap,$fn=100);
        }
        union() {
                translate([0,0,-1]) cylinder(h=Lholder1+1, r=Dlens/2+Dholder+0.2,$fn=100);
                translate([0,0,-1]) cylinder(h=Lholder1-Hoverlap+Hcap+2, r=Dlens/2-Dsupport,$fn=100);     
            
                translate([0,0,-Dobj/2-1+T*sqrt(2)-T]) rotate([-45,0,0]) 
                        translate([0,0,-T]) scale([1,sqrt(2),1]) 
                        cylinder(h=T,r=Dlens/2+Dholder,$fn=100);
            
                // Interaction with the enclosure
                rotate([0,0,-121]) translate([0,0,Lstart-1])     
                        rotate_extrude(angle=62,$fn=100) {
                            square([Dlens/2+Dholder+3,Tlens+1]);
                         }
                rotate([0,0,-121]) translate([0,0,Lstart+Tlens])     
                        rotate_extrude(angle=62,$fn=100) {
                            translate([Dlens/2+Dholder+3*sqrt(2)/2+1.3,0,0]) 
                            rotate([0,0,70])
                            square([6,6],center=true);
                         }
                    
            
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
        
             difference() {
                union() {
                    color("cyan") cylinder(h=5.5, r=Dcap+2.2,$fn=100);
                    if (engrave_cap && (engrave_mode>0)) {
                        color("black") translate([0,0,5.5-0.01]) scale([0.1,0.1,1]) linear_extrude(0.1) {
                            import("toad.svg",center=true);
                        }
                    }
                }
                 union() {
                     if (engrave_cap && (engrave_mode<0)) {
                        translate([0,0,5.5-0.16]) scale([0.1,0.1,1]) linear_extrude(0.5) {
                            import("toad.svg",center=true);
                        }
                    }
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

module baseflap(hflap) {
    translate([-9,0,0]) difference() {
            color("blue",alpha=0.5) union() {
                linear_extrude(hflap,convexity=2) {
                    polygon(polyRound([[2,6,0],[9,0,3],[15,12-Dmag-4,3],[Wflap+7,12-Dmag-4,6],[Wflap+7,12,6],[2,12,0]],20));
                }
            }
            union() {
                // Space for a 8mm x 0.75mm magnet
                if (detach_flap) {
                    translate([6,12-4,-1]) cylinder(h=hflap+2,r=flapScrew/2,$fn=100);
                }
            }
      }
}

module flap() {
    translate([-9,0,0]) difference() {
                color("blue") union() {
                    translate([0,0,Tmag-0.75-0.001]) linear_extrude(2) {
                        polygon(polyRound([[2,6,0],[9,0,3],[9,12-Dmag-4,3],[Wflap+7,12-Dmag-4,6],[Wflap+7,12,6],[2,12,0]],20));
                    }
                    if (Tmag>0.75) {
                        linear_extrude(Tmag-0.75) {
                            polygon(polyRound([[2,6,0],[9,0,1],[9,12,1],[2,12,0]]));
                        }
                    }
                }
                union() {
                    // Space for a 8mm x 0.75mm magnet
                    color("green") translate([Wflap+7-Dmag/2-2,12-(Dmag+4)/2,-0.25]) cylinder(h=Tmag+0.25,r=Dmag/2,$fn=100);
                    if (detach_flap) {
                        translate([6,12-4,-1]) cylinder(h=Tmag+4,r=flapScrew/2,$fn=100);
                    }
                }
                        
      }
}

module plug(length,rad) {
    difference() {
        union() {
            cylinder(h=length,r=rad,$fn=60);
            translate([0,0,length-0.5]) rotate_extrude(angle=360,$fn=60) {
              polygon([[0,0],[rad+0.0,0],[rad+0.0,0.2],[rad,0.5],[0,0.5]]);
            }
        }
        union() {
            translate([0,0,0.25*length]) cylinder(h=12,r=rad-0.6,$fn=60);
            translate([-rad-1,-0.5,0.25*length]) cube([2*rad+2,1,length]);
        }
    }
}

module flap2(image=0) {
    difference() {
        union() {
            baseflap(Tmag+Tentrefer+0.5+0.1);
            translate([Wflap-2,7,0]) rotate([90,0,0]) linear_extrude(5) {
                polygon([[0,0],
                    [1.5,1.5],
                    [1.5,0.50+Tflapcover+Tmag+Tentrefer+0.7],
                    [0.5,1.50+Tflapcover+Tmag+Tentrefer+0.7],
                    [-1,1.50+Tflapcover+Tmag+Tentrefer+0.7],
                    [-1,1.50+Tflapcover+Tmag+Tentrefer-0.5],
                    [0.,1.50+Tflapcover+Tmag+Tentrefer-0.5],
                    [0.,1.50+Tmag+Tentrefer-1],
                    [-1,1.50+Tmag+Tentrefer-1],
                    [-1,0]
                ]);
            }
        }
        union() {
            color("green") translate([Wflap+7-Dmag/2-2-9,12-(Dmag+4)/2,Tentrefer]) cylinder(h=Tmag+1,r=Dmag/2,$fn=100);
            translate([-2.5,12-3,attach_flap?(Tmag+Tentrefer-0.5):-1]) scale([use_plug?1.5:2,1,1]) cylinder(h=(attach_flap)?2:(Tmag+Tentrefer+2),r=flapScrew/2,$fn=100);
        }
    }
    translate([0,0,Tmag+Tentrefer+0.5+0.1+(explode?8:0)]) {
        difference() {
            union() {
                baseflap(Tflapcover);
                if (engrave_flap && (engrave_mode > 0)) {
                    if (minimag) {
                        if (image==1) {
                            translate([11,5.5,Tflapcover-0.01]) scale([0.06,0.06,1]) linear_extrude(0.1) {
                                import("Minion1.svg",center=true);
                            }
                        }
                        if (image==2) {
                            translate([10,5.5,Tflapcover-0.01]) scale([0.05,0.05,1]) linear_extrude(0.1) {
                                import("toadb.svg",center=true);
                            }
                        }
                    } else {
                        if (image==1) {
                            translate([11,4.75,Tflapcover-0.01]) scale([0.070,0.070,1]) linear_extrude(0.1) {
                                import("Minion1.svg",center=true);
                            }
                        }
                        if (image==2) {
                            translate([11,5,Tflapcover-0.01]) scale([0.05,0.05,1]) linear_extrude(0.1) {
                                import("toadb.svg",center=true);
                            }
                        }
                    }
                }
            }
            union() {
                if (engrave_flap && (engrave_mode < 0)) {
                    if (minimag) {
                        if (image==1) {
                            translate([11,5.5,Tflapcover-0.16]) scale([0.06,0.06,1]) linear_extrude(0.5) {
                                import("Minion1.svg",center=true);
                            }
                        }
                        if (image==2) {
                            translate([10,5.5,Tflapcover-0.16]) scale([0.05,0.05,1]) linear_extrude(0.5) {
                                import("toad.svg",center=true);
                            }
                        }
                    } else {
                        if (image==1) {
                            translate([11,4.75,Tflapcover-0.16]) scale([0.070,0.070,1]) linear_extrude(0.5) {
                                import("Minion1.svg",center=true);
                            }
                        }
                        if (image==2) {
                            translate([11,5,Tflapcover-0.16]) scale([0.05,0.05,1]) linear_extrude(0.5) {
                                import("toad.svg",center=true);
                            }
                        }
                    }
                }
            }
        }
        translate([Wflap+7-Dmag/2-2-9,12-(Dmag+4)/2,-0.5]) difference() {
            cylinder(h=0.75,r=Dmag/2-0.1,$fn=100);
            translate([0,0,-0.01]) cylinder(h=0.77,r=Dmag/2-1.1,$fn=100);
        }
        if (!detach_flap /*&& !use_plug*/) {
            translate([-2.5,12-3,-0.5]) {
                linear_extrude(1) {
                            offset(r=-0.15) scale([use_plug?1.5:2,1,1]) circle(r=flapScrew/2,$fn=100);
                 }
            }
        }
        
    }
}


intersection() {
    // Debug cube to print a tiny bit of the structure
    //translate([25,8,0]) cube([25,12,20]);
    
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
            
            translate([W/2-10,-Dobj/2-1,-TflapSupport+0.001]) cube([10,5,TflapSupport]);
            translate([W/2-10,-Dobj/2-1+H-5,-TflapSupport+0.001]) cube([15,5,TflapSupport+T]);
            translate([-W/2,-Dobj/2-1,-TflapSupport+0.001]) cube([10,5,TflapSupport]);
            translate([-W/2-5,-Dobj/2-1+H-5,-TflapSupport+0.001]) cube([15,5,TflapSupport+T]);

            
            if (1) {
                // little ears to stay attached to the box surface
               
                translate([-W/2-1-((explode && !attach_flap)?10:0),-Dobj/2-1+H-12,T+((explode && !attach_flap)?2:0)]) mirror([1,0,0]) flap2(image=1);
                
                translate([W/2+1+((explode && !attach_flap)?10:0),-Dobj/2-1+H-12,T+((explode && !attach_flap)?2:0)]) flap2(image=2);
                if (detach_flap) {
                    translate([-W/2+7+0.1,-Dobj/2-1+H-6,T]) cube([4,6,3]);
                    translate([W/2-11-0.1,-Dobj/2-1+H-6,T]) cube([4,6,3]);
                } else {
                    color("gray")translate([-W/2+7+0.05-1,-Dobj/2-1+H-6,T]) cube([4,6,3]);
                    color("gray")translate([W/2-11-0.05+1,-Dobj/2-1+H-6,T]) cube([4,6,3]);
                    if (!attach_flap) {                    
                        color("gray") translate([W/2-1.5,-Dobj/2+H-4,T-(use_plug?0:1)]) {
                            if (use_plug) {
                                //scale([2,1,1]) rotate([0,0,90]) 
                                //    plug(1.+Tmag+Tentrefer,flapScrew/2-0.15);
                                linear_extrude(1+Tmag) {
                                    offset(r=-0.15) scale([1.5,1,1]) circle(r=flapScrew/2,$fn=100);
                                }
                                translate([-5.,+3,-T]) rotate([90,0,90]) linear_extrude(10) {
                                        polygon([[0,0],
                                            [1.5,1.5],
                                            [1.5,0.50+T+Tflapcover+Tmag+Tentrefer+0.7],
                                            [0.5,1.50+T+Tflapcover+Tmag+Tentrefer+0.7],
                                            [-0.7,1.50+T+Tflapcover+Tmag+Tentrefer+0.7],
                                            [-0.7,1.50+T+Tflapcover+Tmag+Tentrefer-0.5],
                                            [0.,1.50+T+Tflapcover+Tmag+Tentrefer-0.5]
                                        ]);
                                    }
       
                            } else {
                                linear_extrude(1+Tmag) {
                                    offset(r=-0.15) scale([1.5,1,1]) circle(r=flapScrew/2,$fn=100);
                                }
                            }
                            //scale([2,1,1]) cylinder(h=1+Tmag+2,r=flapScrew/2-0.15,$fn=100);
                        }
                            color("gray") translate([-W/2+1.5,-Dobj/2+H-4,T-(use_plug?0:1)]) {
                                if (use_plug) {
                                    linear_extrude(1+Tmag) {
                                        offset(r=-0.15) scale([1.5,1,1]) circle(r=flapScrew/2,$fn=100);
                                    }
                                    translate([-5.,+3,-T]) rotate([90,0,90]) linear_extrude(10) {
                                        polygon([[0,0],
                                            [1.5,1.5],
                                            [1.5,0.50+T+Tflapcover+Tmag+Tentrefer+0.7],
                                            [0.5,1.50+T+Tflapcover+Tmag+Tentrefer+0.7],
                                            [-0.7,1.50+T+Tflapcover+Tmag+Tentrefer+0.7],
                                            [-0.7,1.50+T+Tflapcover+Tmag+Tentrefer-0.5],
                                            [0.,1.50+T+Tflapcover+Tmag+Tentrefer-0.5]
                                        ]);
                                    }
                                } else {
                                    linear_extrude(1+Tmag) {
                                        offset(r=-0.15) scale([1.5,1,1]) circle(r=flapScrew/2,$fn=100);
                                    }
                                }
                            // scale([2,1,1]) cylinder(h=1+Tmag,r=flapScrew/2-0.15,$fn=100);
                        }
                    }
                }
            }
            
           
            }
            
        union() {
            // Optional debug cuts
            // translate([-25,-50,-20]) cube([200,100,200]);
            // translate([-100,-50,-45]) cube([200,45,200]);
            // rotate([0,0,-30]) translate([-100,0,6]) cube([200,100,100]);
               
            translate([-16,0,-0.75]) cube([32,H/2+1.5,T+1+8]);
            
            if (detach_flap) {
                translate([W/2-3,-Dobj/2+H-5,-1]) {
                    cylinder(h=T+2+20,r=flapScrew/2,$fn=100);
                    translate([0,0,1]) cube([6,8,2],center=true);
                }
                translate([-W/2+3,-Dobj/2+H-5,-1]) {
                    cylinder(h=T+2+20,r=flapScrew/2,$fn=100);
                    translate([0,0,1]) cube([6,8.5,2],center=true);
                }
            }
            
            corner_cutouts(W);
            
        }
    }

}