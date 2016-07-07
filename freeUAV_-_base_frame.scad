//=====================================//
// freeUAV_-_base_frame.scad           //
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

// General and quality settings
$fn=200; // 200 default (smoother curves)
yes=1; // for choosing which parts are rendered

// Dimensional settings (all measurements in mm)
// WARNING: Some of these scale, some don't (this is a WIP).
// Default values in comments--these should work properly.
motorDiameter=8.5;                 // 8.5 default
motorSpacing=88;                   // 80 default; 88 is 125-class spacing; 177 is 250-class spacing, etc.
electricsCarrierLength=42;         // 42 default for Micro Scisky
electricsCarrierWidth=25.5;        // 25.5 default for Micro Scisky
electricsCarrierThickness=3;       // 3 default
frameThickness=3;                  // 3 default
frameWidth=4.5;                    // 4.5 default

// Which pieces to generate (both yes for default)
renderFrame=yes;
renderCarrier=yes;

if(renderFrame==1){
  motorHousingsQuad();
  motorArmsQuad();
}
if(renderCarrier==1){
  electricsCarrierBase();
}

module motorArmsQuad(){
  difference(){
    union(){ // Full circles for arms
      for(x=[-motorSpacing/2,1.5*motorSpacing]){
        for(y=[.5*motorSpacing]){
          translate([x,y,frameThickness/2]){
            difference(){
              cylinder(center=true,h=frameThickness,r=1/sin(45)*motorSpacing/2-(.5*motorDiameter));
              cylinder(center=true,h=frameThickness+.2,r=1/sin(45)*motorSpacing/2-(.5*motorDiameter)-frameWidth);
            }
          }
        }
      }
      for(x=[.5*motorSpacing]){
        for(y=[-motorSpacing/2,1.5*motorSpacing]){
          translate([x,y,frameThickness/2]){
            difference(){
              cylinder(center=true,h=frameThickness,r=1/sin(45)*motorSpacing/2-(.5*motorDiameter));
              cylinder(center=true,h=frameThickness+.2,r=1/sin(45)*motorSpacing/2-(.5*motorDiameter)-frameWidth);
            }
          }
        }
      }

    }
    difference(){ // Cube to remove excess of arms
      translate([motorSpacing/2,motorSpacing/2,frameThickness/2]){
        rotate([0,0,45]){
          cube(center=true,[motorSpacing*4+.2,motorSpacing*4+.2,frameThickness+.2]);
        }
      }
      translate([motorSpacing/2,motorSpacing/2,frameThickness/2]){
        rotate([0,0,45]){
          cube(center=true,[1/sin(45)*motorSpacing,1/sin(45)*motorSpacing,frameThickness+.4]);
        }
      }
    }
  }
}
module microSciskyCarrier(){ // Micro Scisky dimensions (x,y,z): (33.5,20,6)
  translate([39,40,6.5]){
    difference(){
      translate([0,0,-2.5]){
        cube(center=true,[37.5,24,8]);
      }
      union(){
        translate([2,0,-.5]){
          cube(center=true,[35.6,21,2]);
        }
        translate([0,0,-2.5]){
          cube(center=true,[37.7,19,8.2]);
        }
      }
    }
  }
}
module naze32Carrier(){
  for(x=[(motorSpacing/2)-15.25,(motorSpacing/2)+15.25]){
    for(y=[(motorSpacing/2)-15.25,(motorSpacing/2)+15.25]){
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
module electricsCarrierBase(){
  union(){
    difference(){
      translate([motorSpacing/2,motorSpacing/2,electricsCarrierThickness/2]){
        cube(center=true,[electricsCarrierLength,electricsCarrierWidth,electricsCarrierThickness]);
      }
      translate([motorSpacing/2,motorSpacing/2,electricsCarrierThickness/2+2.5]){
        cube(center=true,[electricsCarrierLength-6,electricsCarrierWidth-6,electricsCarrierThickness+2]);
      }
      difference(){
        // honeycomb mesh
        translate([motorSpacing/2,motorSpacing/2,0]){
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
          translate([motorSpacing/2,motorSpacing/2,electricsCarrierThickness/2]){
            cube(center=true,[electricsCarrierLength,electricsCarrierWidth,electricsCarrierThickness]);
          }
          translate([motorSpacing/2,motorSpacing/2,electricsCarrierThickness/2-2]){
            cube(center=true,[electricsCarrierLength-6,electricsCarrierWidth-6,electricsCarrierThickness+2]);
          }
        }
      }
      for(x=[(.5*motorSpacing)-(electricsCarrierLength/2)+2,(.5*motorSpacing)+(electricsCarrierLength/2)-2]){
        for(y=[(.5*motorSpacing)-(electricsCarrierWidth/2)+2,(.5*motorSpacing)+(electricsCarrierWidth/2)-2]){
          translate([x,y,-0.1]){
            cylinder(h=8.2,r=1.7);
          }
        }
      }
      // cutout for micro-USB connector at rear of FC
      translate([motorSpacing/2+electricsCarrierLength/2,motorSpacing/2,electricsCarrierThickness]){
        cube(center=true,[electricsCarrierLength+.02,12,electricsCarrierThickness]);
      }
    }
    // protruding tabs for rubber bands (battery strap in particular)
    translate([motorSpacing/2,motorSpacing/2,1.5]){ // 40,40,1.5
      for(x=[-7,7]){ // for 4 tabs use [-15,-5,5,15]
        for(y=[-14,14]){
          translate([x,y,0]){
            cube(center=true,[4,6,3]);
          }
        }
      }
    }
  }
  // posts and holes for M3 fasteners to connect lower base frame to upper frame cover
  difference(){
    for(x=[(.5*motorSpacing)-(electricsCarrierLength/2)+2,(.5*motorSpacing)+(electricsCarrierLength/2)-2]){
      for(y=[(.5*motorSpacing)-(electricsCarrierWidth/2)+2,(.5*motorSpacing)+(electricsCarrierWidth/2)-2]){
        translate([x,y,0]){
          cylinder(h=3,r=4);
        }
      }
    }
    for(x=[(.5*motorSpacing)-(electricsCarrierLength/2)+2,(.5*motorSpacing)+(electricsCarrierLength/2)-2]){
      for(y=[(.5*motorSpacing)-(electricsCarrierWidth/2)+2,(.5*motorSpacing)+(electricsCarrierWidth/2)-2]){
        translate([x,y,-0.1]){
          cylinder(h=3.2,r=1.7); // should be r=1.7 for a nice fit with M3 screws
        }
      }
    }

  }

}
module electricsCarrierUpper(){
  translate([0,motorSpacing,16.1]){
    rotate([180,0,0]){
      electricsCarrierBase();
    }
  }
}
module motorHousingsQuad(){
  difference(){
    for(x=[0,motorSpacing]){
      for(y=[0,motorSpacing]){
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
    translate([motorSpacing/2,motorSpacing/2,0]){
      for(r=[45,135]){
        rotate([0,0,r]){
          cube(center=true,[sqrt(2*motorSpacing*motorSpacing),3,50]);
        }
      }
    }
  }
}
