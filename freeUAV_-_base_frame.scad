//=====================================//
// freeMAV_-_base_frame.scad           //
//=====================================//
// Designed by Kyle Seigler and        //
// released under the MIT license,     //
// available at:                       //
// https://opensource.org/licenses/MIT //
//=====================================//

/*The MIT License (MIT)

Copyright (c) 2016 Kyle Seigler

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

// Global settings
$fn=200; // 200 default (smoother curves)

// Dimensional settings (all measurements in mm)
// WARNING: Some of these scale, some don't (this is a WIP).
// Default values in comments--these should work properly.
motorDiameter=8.5;                  // 7.5 default
motorSpacingX=80;                   // 80 default
motorSpacingY=80;                   // 80 default
electricsCarrierLength=50;          // 50 default
electricsCarrierWidth=26;         // 34.5 default
electricsCarrierThickness=3;        // 3 default

// Which paradigm to generate and with/without upper panel
toBeGenerated="quad";               // quad default
loadElectricsCarrierUpper="true";  // false default

if(toBeGenerated=="quad"){
  motorHousingsQuad();
  motorArmsQuad();
  electricsCarrierBase();
  microSciskyCarrier();
}
if(toBeGenerated=="tri"){
  motorHousingsTri();
  motorArmsTri();
  electricsCarrierBase();
}
if(loadElectricsCarrierUpper=="true"){
  electricsCarrierUpper();
}

module microSciskyCarrier(){ // Micro Scisky dimensions (x,y,z): (33.5,20,6)
  translate([39,40,6.5]){
    difference(){
      translate([0,0,-2.5]){
        cube(center=true,[37.5,24,8]);
      }
      union(){
        translate([2,0,-.5]){
          cube(center=true,[35.6,20,2]);
        }
        translate([0,0,-2.5]){
          cube(center=true,[37.7,19,8.2]);
        }
      }
    }
  }
}
module naze32Carrier(){
  for(x=[(motorSpacingX/2)-15.25,(motorSpacingX/2)+15.25]){
    for(y=[(motorSpacingY/2)-15.25,(motorSpacingY/2)+15.25]){
      difference(){
        translate([x,y,0]){
          cylinder(h=3,r=4);
        }
        translate([x,y,-0.1]){
          cylinder(h=3.2,r=1.7);
        }
      }
    }
  }
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
      for(x=[(.5*motorSpacingX)-(electricsCarrierLength/2)+2,(.5*motorSpacingX)+(electricsCarrierLength/2)-2]){
        for(y=[(.5*motorSpacingY)-(electricsCarrierWidth/2)+2,(.5*motorSpacingY)+(electricsCarrierWidth/2)-2]){
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
      translate([40,40,0]){
        for(r=[45,135]){
          rotate([0,0,r]){
            scale([3,1,1]){
              difference(){
                translate([0,0,0]){
                  cylinder(h=3,r=20);
                }
                scale([1.1,.85,1]){
                  translate([0,0,-0.1]){
                    cylinder(h=3.2,r=17);
                  }
                }
              }
            }
          }
        }
      }
    }
    union(){
      // honeycomb inset
      translate([motorSpacingX/2,motorSpacingY/2,electricsCarrierThickness/2-2]){
        cube(center=true,[electricsCarrierLength-4,electricsCarrierWidth-4,electricsCarrierThickness+4.1]);
      }
      for(x=[(.5*motorSpacingX)-(electricsCarrierLength/2)+2,(.5*motorSpacingX)+(electricsCarrierLength/2)-2]){
        for(y=[(.5*motorSpacingY)-(electricsCarrierWidth/2)+2,(.5*motorSpacingY)+(electricsCarrierWidth/2)-2]){
          translate([x,y,-0.1]){
            cylinder(h=3.2,r=1.7);
          }
        }
      }
      // motor openings
      for(x=[0,motorSpacingX]){
        for(y=[0,motorSpacingY]){
          translate([x,y,-0.1]){
            cylinder(h=20.2,r=(motorDiameter/2));
          }
        }
      }
    }
  }
}
module motorArmsQuadOriginal(){
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
      for(x=[(.5*motorSpacingX)-(electricsCarrierLength/2)+2,(.5*motorSpacingX)+(electricsCarrierLength/2)-2]){
        for(y=[(.5*motorSpacingY)-(electricsCarrierWidth/2)+2,(.5*motorSpacingY)+(electricsCarrierWidth/2)-2]){
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
      translate([motorSpacingX/2,motorSpacingY/2,electricsCarrierThickness/2+2.5]){
        cube(center=true,[electricsCarrierLength-6,electricsCarrierWidth-6,electricsCarrierThickness+2]);
      }
      difference(){
        // honeycomb mesh
        translate([motorSpacingX/2,motorSpacingY/2,0]){
          union(){
            translate([0,0,0]){
              for(x=[-60,-50,-40,-30,-20,-10,0,10,20,30,40,50,60]){
                for(y=[-48,-42,-36,-30,-24,-18,-12,-6,0,6,12,18,24,30,36,42,48]){
                  translate([x,y,-0.1]){
                    cylinder($fn=6,h=electricsCarrierThickness+0.2,r=2.8);
                  }
                }
              }
            }
            translate([5,3,0]){
              for(x=[-60,-50,-40,-30,-20,-10,0,10,20,30,40,50,60]){
                for(y=[-48,-42,-36,-30,-24,-18,-12,-6,0,6,12,18,24,30,36,42,48]){
                  translate([x,y,-0.1]){
                    cylinder($fn=6,h=electricsCarrierThickness+0.2,r=2.8);
                  }
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
      for(x=[(.5*motorSpacingX)-(electricsCarrierLength/2)+2,(.5*motorSpacingX)+(electricsCarrierLength/2)-2]){
        for(y=[(.5*motorSpacingY)-(electricsCarrierWidth/2)+2,(.5*motorSpacingY)+(electricsCarrierWidth/2)-2]){
          translate([x,y,-0.1]){
            cylinder(h=8.2,r=1.7);
          }
        }
      }
    }
  }
  // posts and holes for M3 fasteners to connect lower base frame to upper frame cover
  difference(){
    for(x=[(.5*motorSpacingX)-(electricsCarrierLength/2)+2,(.5*motorSpacingX)+(electricsCarrierLength/2)-2]){
      for(y=[(.5*motorSpacingY)-(electricsCarrierWidth/2)+2,(.5*motorSpacingY)+(electricsCarrierWidth/2)-2]){
        translate([x,y,0]){
          cylinder(h=3,r=4);
        }
      }
    }
    for(x=[(.5*motorSpacingX)-(electricsCarrierLength/2)+2,(.5*motorSpacingX)+(electricsCarrierLength/2)-2]){
      for(y=[(.5*motorSpacingY)-(electricsCarrierWidth/2)+2,(.5*motorSpacingY)+(electricsCarrierWidth/2)-2]){
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
    for(x=[0,motorSpacingX]){
      for(y=[0,motorSpacingY]){
        difference(){
          union(){
            translate([x,y,0]){
              cylinder(h=10,r=(motorDiameter/2+1.5));
            }
            translate([x,y,0]){
              cylinder(h=5,r=(motorDiameter/2+4.5));
            }
          }
          union(){
            translate([x,y,2]){
              cylinder(h=20.2,r=(motorDiameter/2));
            }
            translate([x,y,-0.1]){
              cylinder(h=20.2,r=(motorDiameter/2)-.75);
            }
          }
        }
      }
    }
    translate([motorSpacingX/2,motorSpacingY/2,0]){
      for(r=[45,135]){
        rotate([0,0,r]){
          cube(center=true,[115,3,50]);
        }
      }
    }
  }
}
