// freeMAV_-_base_frame.scad

// Global settings
$fn=200; // 200 default (smoother curves)

// Dimensional settings (all measurements in mm)
// WARNING: Some of these scale, some don't (this is a WIP).
// Default values in comments--these should work properly.
motorDiameter=7.5;            // 7.5 default
motorSpacingX=80;             // 80 default
motorSpacingY=80;             // 80 default
electricsCarrierLength=50;    // 50 default
electricsCarrierWidth=32;     // 32 default
electricsCarrierThickness=3;  // 3 default

// Which paradigm to generate and with/without upper panel
toBeGenerated="quad";
loadElectricsCarrierUpper="true";

if(toBeGenerated=="quad"){
  motorHousingsQuad();
  motorArmsQuad();
  electricsCarrierBase();
}
if(toBeGenerated=="tri"){
  motorHousingsTri();
  motorArmsTri();
  electricsCarrierBase();
}
if(loadElectricsCarrierUpper=="true"){
  electricsCarrierUpper();
}

module motorArmsTri(){
  difference(){
    union(){
      // front arms
      difference(){
        translate([28,motorSpacingY/2,1.5]){
          for(r=[180-54.5,180+54.5]){
            rotate([0,0,r]){
              cube(center=true,[92,4,3]);
            }
          }
        }
      
        translate([30,0,electricsCarrierThickness/2-2]){
          cube([32,100,electricsCarrierThickness+4.1]);
        }
      }
      // rear arm
      translate([75,motorSpacingX/2,1.5]){
        cube(center=true,[40,4,3]);
      }
      // reinforcing circles
      scale([1.1,1,1]){
        difference(){
          translate([35,40,0]){
            cylinder(h=3,r=35);
          }
          translate([35,40,-0.1]){
            cylinder(h=3.2,r=32.5);
          }
        }
      }
    }
    // remove honeycomb inset excess of arms
    union(){
      // honeycomb inset
      translate([motorSpacingX/2,motorSpacingY/2,electricsCarrierThickness/2-2]){
        cube(center=true,[electricsCarrierLength-4,electricsCarrierWidth-4,electricsCarrierThickness+4.1]);
      }
      for(x=[18,62.5]){
        for(y=[27,53]){
          translate([x,y,-0.1]){
            cylinder(h=3.2,r=1.7);
          }
        }
      }
    }
  }
}
module motorArmsQuad(){
  difference(){
    union(){
      difference(){
        union(){
        // front arms
        translate([28,motorSpacingY/2,1.5]){
            for(r=[180-54.5,180+54.5]){
              rotate([0,0,r]){
                cube(center=true,[92,4,3]);
              }
            }
          }
          // rear arms
          translate([52,motorSpacingY/2,1.5]){
            for(r=[180-54.5,180+54.5]){
              rotate([0,0,r]){
                cube(center=true,[92,4,3]);
              }
            }
          }
        }
        translate([20,0,electricsCarrierThickness/2-2]){
          cube([40,100,electricsCarrierThickness+4.1]);
        }        
        for(x=[0,80]){
          for(y=[0,80]){
            translate([x,y,-0.2]){
              cylinder(h=20.3,r=(motorDiameter/2));
            }
          }
        }
      }
      // reinforcing circles
      scale([1,1,1]){
        difference(){
          translate([40,40,0]){
            cylinder(h=3,r=35);
          }
          translate([40,40,-0.1]){
            cylinder(h=3.2,r=32.5);
          }
        }
      }
    }
    // remove honeycomb inset excess of arms
    union(){
      // honeycomb inset
      translate([motorSpacingX/2,motorSpacingY/2,electricsCarrierThickness/2-2]){
        cube(center=true,[electricsCarrierLength-4,electricsCarrierWidth-4,electricsCarrierThickness+4.1]);
      }
      for(x=[18,62.5]){
        for(y=[27,53]){
          translate([x,y,-0.1]){
            cylinder(h=3.2,r=1.7);
          }
        }
      }
    }
  }
}
module electricsCarrierBase(){
  union(){
    difference(){
      translate([motorSpacingX/2,motorSpacingY/2,electricsCarrierThickness/2]){
        cube(center=true,[electricsCarrierLength,electricsCarrierWidth,electricsCarrierThickness]);
      }
      translate([motorSpacingX/2,motorSpacingY/2,electricsCarrierThickness/2+2]){
        cube(center=true,[electricsCarrierLength-6,electricsCarrierWidth-6,electricsCarrierThickness+2]);
      }
      difference(){
        union(){
          translate([motorSpacingX/2-electricsCarrierLength/2+5,motorSpacingY/2-electricsCarrierWidth/2+4,0]){
            for(x=[0,10,20,30,40]){
              for(y=[0,6,12,18,24]){
                translate([x,y,-0.1]){
                  cylinder($fn=6,h=electricsCarrierThickness+0.2,r=2.8);
                }
              }
            }
          }
          translate([motorSpacingX/2-electricsCarrierLength/2+10,motorSpacingY/2-electricsCarrierWidth/2+7,0]){
            for(x=[0,10,20,30]){
              for(y=[-12,-6,0,6,12,18,24]){
                translate([x,y,-0.1]){
                  cylinder($fn=6,h=electricsCarrierThickness+0.2,r=2.8);
                }
              }
            }
          }
        }
        difference(){
          translate([motorSpacingX/2,motorSpacingY/2,electricsCarrierThickness/2]){
            cube(center=true,[electricsCarrierLength,electricsCarrierWidth,electricsCarrierThickness]);
          }
          translate([motorSpacingX/2,motorSpacingY/2,electricsCarrierThickness/2-2]){
            cube(center=true,[electricsCarrierLength-6,electricsCarrierWidth-6,electricsCarrierThickness+2]);
          }
        }
      }
    for(x=[18,62.5]){
      for(y=[27,53]){
        translate([x,y,-0.1]){
          cylinder(h=8.2,r=1.7);
        }
      }
    }

    }
  }
  // posts and holes for M3 fasteners to connect lower base frame to upper frame cover
  difference(){
    for(x=[18,62.5]){
      for(y=[27,53]){
        translate([x,y,0]){
          cylinder(h=3,r=4);
        }
      }
    }
    for(x=[18,62.5]){
      for(y=[27,53]){
        translate([x,y,-0.1]){
          cylinder(h=3.2,r=1.7);
        }
      }
    }
    
  }
  
}
module electricsCarrierUpper(){
  translate([0,motorSpacingX,16.1]){
    rotate([180,0,0]){
      electricsCarrierBase();
    }
  }
}
module motorHousingsTri(){
  difference(){
    for(x=[0]){
      for(y=[0,motorSpacingY]){
        difference(){
          union(){
            translate([x,y,0]){
              cylinder(h=20.1,r=(motorDiameter/2+1.5));
            }
            translate([motorSpacingY*1.25,motorSpacingY/2,0]){
              cylinder(h=20.1,r=(motorDiameter/2+1.5));
            }
          }
          union(){
            translate([x,y,-0.1]){
              cylinder(h=20.3,r=(motorDiameter/2));
            }
            translate([motorSpacingY*1.25,motorSpacingY/2,-0.1]){
              cylinder(h=20.3,r=(motorDiameter/2));
            }
          }
        }
      }
    }
    difference(){
      translate([motorSpacingX/2,motorSpacingY/2,0]){
        for(r=[0,45,135]){
          rotate([0,0,r]){
            cube(center=true,[160,3,50]);
          }
        }
      }
      translate([0,0,-0.2]){
        cube([motorSpacingX*1.25,motorSpacingY,20.3]);
      }
    }
  }
}
module motorHousingsQuad(){
  difference(){
    for(x=[0,80]){
      for(y=[0,80]){
        difference(){
          translate([x,y,-0.1]){
            cylinder(h=20.1,r=(motorDiameter/2+1.5));
          }
          translate([x,y,-0.2]){
            cylinder(h=20.3,r=(motorDiameter/2));
          }
        }
      }
    }
    difference(){
      translate([motorSpacingX/2,motorSpacingY/2,0]){
        for(r=[45,135]){
          rotate([0,0,r]){
            cube(center=true,[160,3,50]);
          }
        }
      }
      translate([0,0,-0.2]){
        cube([80,80,20.3]);
      }
    }
  }
}


