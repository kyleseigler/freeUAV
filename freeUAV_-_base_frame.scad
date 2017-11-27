//=====================================//
// freeUAV_-_base_frame.scad           //
//=====================================//
// Designed by Kyle Seigler and        //
// released under the MIT license,     //
// available at:                       //
// https://opensource.org/licenses/MIT //
//=====================================//

/*The MIT License (MIT)

Copyright (c) 2017 Kyle Seigler

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

// Quality settings
$fn=300; // 300 default (smoother curves)

// Dimensional settings (all measurements in mm)
// WARNING: Some of these scale, some don't (this is a WIP).
// Default values in comments--these should work properly.

// Inner frame parameters (need to be manually changed depending on flight controller)
FC=1;                                   // 0 for Micro Scisky
                                        // 1 for Naze32
electricsCarrierLength=36;              // 48 default for Micro Scisky
                                        // 36 default for Naze32
electricsCarrierWidth=36;               // 25.5 default for Micro Scisky
                                        // 36 default for Naze32
electricsCarrierHoleSpacingX=30.5;      // "(electricsCarrierLength/2)+2" default for Micro Scisky
                                        // 30.5 default for Naze32
electricsCarrierHoleSpacingY=30.5;      // "(electricsCarrierWidth/2)+2" default for Micro Scisky
                                        // 30.5 default for Naze 32

// General dimensional options
electricsCarrierThickness=3;            // 3 default
electricsCarrierUpperLift=10;           // 10 default
electricsCarrierFrameOuterWidth=2;      // 3 default, 1.8 for lightweight version
electricsCarrierM3ScrewHolePadding=2.2; // 2.2 default, 1.5 for lightweight version
batteryMountType=1;                     // 0 for rubber band tabs, 1 for velcro battery strap
batteryStrapWidth=14;                   // 14 default
batteryStrapOpening=3.5;                  // 3.5 default
batteryStrapThickness=2;                // 1.5 default
fullMotorArms=1;                        // 1 default

// Outer frame parameters
frameThickness=3;                       // 3 default
frameWidth=3;                           // 3 default
motorSpacing=80;                        // 80 default
/* 56 is 80-class
 * 62 is 87-class
 * 70 is 100-class
 * 80 is 113-class
 * 88 is 125-class
 */

// Motor parameters
motorType=1;
/* Supported motor types
 * 0 for friction-fit brushed (change motorDiameter variable below to set motor casing size)
 * 1 for brushless (currently only RCX H1105)
 */
motorArrangement=0;
/* Supported motor arrangements
 * 0 for X-type quadrotor
 * 1 for hexarotor (TODO: implement hexarotor motor carrier layout)
 */
 
// Other parameters
fpvCameraMount=0;  // default 1
cameraAngle=15;    // default 15
LEDmounts=0;       // default 0, only works for Micro Scisky/brushed motors at this time
/* Whether LED mounts are on the frame. Note:
* This only really works well with nylon (since the LEDs can illuminate the frame.
* Also, this is currently only supported for brushed motor mounts.
*/

// Brushed motor parameters
motorDiameter=8.5;                  // 8.5 default
motorHousingThickness=2;            // 2 default
motorHousingHeight=10;              // 10 default
motorHousingBaseHeight=3;           // 5 default

// Brushless motor parameter values for RCX H1105 (http://www.myrcmart.com/rcx-h1105-4000kv-multirotor-brushless-motor-for-120150-frame-6g-p-9137.html)
brushlessMotorMountHoleSpacing=9;            // 9mm spacing per datasheet
brushlessMotorMountHoleDiameter=2;           // 2mm hole per datasheet (TODO: find out oversizing amount required)
brushlessMotorDiameter=14;                   // 14mm per datasheet
brushlessMotorPlateThickness=3;              // 4 default

// Which pieces to generate (1 for yes, 2 for no)
renderFrame=1; // 1 default
renderCarrier=1; // 1 default
renderCarrierUpper=1; // 0 default
renderMotorPads=0; // 0 default (0 for no, 1 for yes; these are to help with warping of motor arms by placing a wide base/pad around each motor mount)
motorPadThickness=0.3; // 0.3mm default, for typical printing settings

completeFrame();

// Modules
module completeFrame(){
  if(renderFrame==1){
    motorHousings();
    motorArmsQuad();
  }
  if(renderCarrier==1){
    electricsCarrierBase();
  }
  if(renderCarrierUpper==1){
    electricsCarrierUpper();
  }
}
module motorHousings(){
  if(motorType==0){motorHousingsBrushed();}
  if(motorType==1){motorHousingsBrushless();}
}
module motorHousingsBrushless(){
  for(x=[0,motorSpacing]){
    for(y=[0,motorSpacing]){
      translate([x,y,0]){
        difference(){
          cylinder(h=brushlessMotorPlateThickness,r=(motorDiameter/2+4.5));
          // mouting holes for brushless motor
          rotate([0,0,45]){
            for(x=[-brushlessMotorMountHoleSpacing/2,brushlessMotorMountHoleSpacing/2]){
              for(y=[-brushlessMotorMountHoleSpacing/2,brushlessMotorMountHoleSpacing/2]){
                translate([x,y,-0.1]){
                  cylinder(center=false,h=brushlessMotorPlateThickness+0.2,r=brushlessMotorMountHoleDiameter/2);
                }
              }
            }
          }
          translate([0,0,-0.1]){
            cylinder(h=brushlessMotorPlateThickness+0.2,r=2.5);
          }
        }
      }
    }
  }
}
module motorHousingsBrushed(){
  difference(){
    for(x=[0,motorSpacing]){
      for(y=[0,motorSpacing]){
        difference(){
          union(){
            translate([x,y,0]){
              cylinder(h=motorHousingHeight,r=(motorDiameter/2+motorHousingThickness));
            }
            translate([x,y,0]){
              cylinder(h=motorHousingBaseHeight,r=(motorDiameter/2+frameWidth));
            }
            if(renderMotorPads==1){
              translate([x,y,0]){
                cylinder(h=0.3,r=(motorDiameter/2+frameWidth)+4);
              }
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
module motorArmsQuad(){
  union(){
    difference(){
      union(){ // Full circles for arms
        // front/back arms
        for(x=[-motorSpacing/2,1.5*motorSpacing]){
          for(y=[.5*motorSpacing]){
            translate([x,y,frameThickness/2]){
              if(FC==1){
                scale([1.25,.865,1]){
                  difference(){
                    cylinder(center=true,h=frameThickness,r=1/sin(45)*motorSpacing/2-(.5*motorDiameter));
                    cylinder(center=true,h=frameThickness+.2,r=1/sin(45)*motorSpacing/2-(.5*motorDiameter)-frameWidth);
                  }
                }
              }
            }
          }
        }
        if(fullMotorArms==1){
          // left/right arms (temporarily omitted to save weight)
          for(x=[.5*motorSpacing]){
            for(y=[-motorSpacing/2,1.5*motorSpacing]){
              translate([x,y,frameThickness/2]){
                if(FC==1){
                  scale([.865,1.25,1]){
                    difference(){
                      cylinder(center=true,h=frameThickness,r=1/sin(45)*motorSpacing/2-(.5*motorDiameter));
                      cylinder(center=true,h=frameThickness+.2,r=1/sin(45)*motorSpacing/2-(.5*motorDiameter)-frameWidth);
                    }
                  }
                }
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
      // make sure brushless motor mounting holes are not obstructed by arms (TODO: find better fix for this)
      if(motorType==1){
        for(x=[0,motorSpacing]){
          for(y=[0,motorSpacing]){
            translate([x,y,0]){
              rotate([0,0,45]){
                for(x=[-brushlessMotorMountHoleSpacing/2,brushlessMotorMountHoleSpacing/2]){
                  for(y=[-brushlessMotorMountHoleSpacing/2,brushlessMotorMountHoleSpacing/2]){
                    translate([x,y,-0.1]){
                      cylinder(center=false,h=brushlessMotorPlateThickness+0.2,r=brushlessMotorMountHoleDiameter/2);
                    }
                  }
                }
              }
            }
          }
        }
      }
      // cutout for micro-USB connector at rear of Micro Scisky
      if(FC==0){
        translate([motorSpacing/2+electricsCarrierLength/2,motorSpacing/2,electricsCarrierThickness]){
          cube(center=true,[electricsCarrierLength+.02,12,electricsCarrierThickness]);
        }
      }
    }
    
    // conical/tilted holes for 3mm LEDs (should illuminate corners of nylon frame for better orientation at night)
    if(LEDmounts==1){
      if(motorType==0){
        for(rotation=[0,90,180,270]){
          translate([motorSpacing/2,motorSpacing/2,5]){
            rotate([0,0,rotation]){
              translate([-(motorSpacing+10.5)/2,-(motorSpacing+10.5)/2,0]){
                rotate([10,-10,0]){
                  difference(){
                    cylinder(center=true,r1=1.9,r2=3,h=8);
                    translate([0,0,0]){
                      cylinder(center=true,r=1.65,h=8.01);
                    }
                  }
                }
              }
            }
          }
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
        cube(center=true,[electricsCarrierLength-2*electricsCarrierFrameOuterWidth,electricsCarrierWidth-2*electricsCarrierFrameOuterWidth,electricsCarrierThickness+2]);
      }
      difference(){
        // honeycomb mesh
        translate([motorSpacing/2,motorSpacing/2,0]){
          union(){
            translate([0,0,0]){
              for(x=[-60,-40,-20,0,20,40,60]){
                for(y=[-48,-36,-24,-12,0,12,24,36,48]){
                  translate([x,y,-0.1]){
                    cylinder($fn=6,h=electricsCarrierThickness+0.2,r=6);
                  }
                }
              }
            }
            translate([10,6,0]){
              for(x=[-60,-40,-20,0,20,40,60]){
                for(y=[-48,-36,-24,-12,0,12,24,36,48]){
                  translate([x,y,-0.1]){
                    cylinder($fn=6,h=electricsCarrierThickness+0.2,r=6);
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
            cube(center=true,[electricsCarrierLength-2*electricsCarrierFrameOuterWidth,electricsCarrierWidth-2*electricsCarrierFrameOuterWidth,electricsCarrierThickness+2]);
          }
        }
      }
      for(x=[(.5*motorSpacing)-electricsCarrierHoleSpacingX/2,(.5*motorSpacing)+electricsCarrierHoleSpacingX/2]){
        for(y=[(.5*motorSpacing)-electricsCarrierHoleSpacingY/2,(.5*motorSpacing)+electricsCarrierHoleSpacingY/2]){
          translate([x,y,-0.1]){
            cylinder(h=8.2,r=1.7);
          }
        }
      }
      // cutout for micro-USB connector at rear of Micro Scisky
      if(FC==0){
        translate([motorSpacing/2+electricsCarrierLength/2,motorSpacing/2,electricsCarrierThickness]){
          cube(center=true,[electricsCarrierLength+.02,12,electricsCarrierThickness]);
        }
      }
    }
    // different types of battery/electrics mounting methods
    if(batteryMountType==0){ // protruding tabs for rubber bands (battery strap in particular)
      difference(){
        translate([motorSpacing/2,motorSpacing/2,1.5]){ // 40,40,1.5
          for(x=[-7,7]){ // for 4 tabs use [-15,-5,5,15]
            for(y=[-electricsCarrierWidth/2,electricsCarrierWidth/2]){ // was -14,14
              translate([x,y,0]){
                cube(center=true,[4,6,3]);
              }
            }
          }
        }
        // small cutouts to help hold onto the rubber bands
        translate([motorSpacing/2,motorSpacing/2,1.5]){
          for(x=[-7,7]){ // for 4 tabs use [-15,-5,5,15]
            for(y=[-electricsCarrierWidth/2-1,electricsCarrierWidth/2+1]){
              translate([x,y,2]){
                rotate([0,90,0]){
                  cylinder(center=true,h=4.01,r=1.2);
                }
              }
            }
          }
        }
      }
    }
    if(batteryMountType==1){ // small loops for velcro battery strap
      translate([motorSpacing/2,motorSpacing/2,1.5]){
        difference(){
          cube(center=true,[batteryStrapWidth+2*batteryStrapThickness,electricsCarrierWidth+2*batteryStrapOpening+2*batteryStrapThickness,3]);
          cube(center=true,[batteryStrapWidth,electricsCarrierWidth+2*batteryStrapOpening,3.01]);
          cube(center=true,[electricsCarrierLength,electricsCarrierWidth-0.01,3.02]);
        }
      }
    }
  }
  // fpv camera mount
  if(fpvCameraMount==1){
    union(){
      difference(){
        translate([4,motorSpacing/2,12]){
          difference(){
            translate([0,0,-4]){
              cube(center=true,[5,electricsCarrierWidth,16]);
            }
            translate([0,0,3]){
              rotate([0,90,0]){
                cylinder(center=true,h=5.1,r=4);
              }
            }
            translate([0,0,-12]){
              rotate([0,90,0]){
                cylinder($fn=6,center=true,h=5.1,r=6);
              }
            }
            for(y=[-18,18]){
              translate([0,y,2]){
                rotate([0,90,0]){
                  cylinder($fn=6,center=true,h=35.1,r=10);
                }
              }
            }
          }
        }
      }
      /*
      difference(){
        translate([-3,motorSpacing/2,electricsCarrierThickness/2]){
          cube(center=true,[16,electricsCarrierWidth,electricsCarrierThickness]);
        }
        translate([-3,motorSpacing/2,electricsCarrierThickness/2]){
          cube(center=true,[16.01,electricsCarrierWidth-5,electricsCarrierThickness+.01]);
        }      
      }
      */
    }
  }
  // posts and holes for M3 fasteners to connect lower base frame to upper frame (for additional modules such as FPV, OSD, etc)
  difference(){
    union(){
      for(x=[(.5*motorSpacing)-electricsCarrierHoleSpacingX/2,(.5*motorSpacing)+electricsCarrierHoleSpacingX/2]){
        for(y=[(.5*motorSpacing)-electricsCarrierHoleSpacingY/2,(.5*motorSpacing)+electricsCarrierHoleSpacingY/2]){
          translate([x,y,0]){
            cylinder(h=3,r=electricsCarrierM3ScrewHolePadding+1.7);
          }
        }
      }
      /*
      difference(){ // rubberband loops for connecting motor arms and electrics carrier
        for(x=[(.5*motorSpacing)-(electricsCarrierLength/2)-1,(.5*motorSpacing)+(electricsCarrierLength/2)+1]){
          for(y=[(.5*motorSpacing)-(electricsCarrierWidth/2)-1,(.5*motorSpacing)+(electricsCarrierWidth/2)+1]){
            translate([x,y,0]){
              cylinder(h=3,r=3); // slightly smaller as these are for rubber bands
            }
          }
        }
        for(x=[(.5*motorSpacing)-(electricsCarrierLength/2)-1,(.5*motorSpacing)+(electricsCarrierLength/2)+1]){
          for(y=[(.5*motorSpacing)-(electricsCarrierWidth/2)-1,(.5*motorSpacing)+(electricsCarrierWidth/2)+1]){
            translate([x,y,-0.1]){
              cylinder(h=3.2,r=1.5); // slightly smaller as these are for rubber bands
            }
          }
        }      
      }
      */
    }
    union(){
      for(x=[(.5*motorSpacing)-electricsCarrierHoleSpacingX/2,(.5*motorSpacing)+electricsCarrierHoleSpacingX/2]){
        for(y=[(.5*motorSpacing)-electricsCarrierHoleSpacingY/2,(.5*motorSpacing)+electricsCarrierHoleSpacingY/2]){
          translate([x,y,-0.1]){
            cylinder(h=3.2,r=1.7); // should be r=1.7 for a nice fit with M3 screws
          }
        }
      }      
    }
  }
  
}
module electricsCarrierUpper(){
  translate([0,0,electricsCarrierUpperLift]){
    rotate([0,0,0]){
      union(){
        difference(){
          translate([motorSpacing/2,motorSpacing/2,electricsCarrierThickness/2]){
            cube(center=true,[electricsCarrierLength,electricsCarrierWidth,electricsCarrierThickness]);
          }
          translate([motorSpacing/2-electricsCarrierFrameOuterWidth,motorSpacing/2,electricsCarrierThickness/2]){
            cube(center=true,[electricsCarrierLength,electricsCarrierWidth-2*electricsCarrierFrameOuterWidth,electricsCarrierThickness+2]);
          }
          for(x=[(.5*motorSpacing)-electricsCarrierHoleSpacingX/2,(.5*motorSpacing)+electricsCarrierHoleSpacingX/2]){
            for(y=[(.5*motorSpacing)-electricsCarrierHoleSpacingY/2,(.5*motorSpacing)+electricsCarrierHoleSpacingY/2]){
              translate([x,y,-0.1]){
                cylinder(h=8.2,r=1.7);
              }
            }
          }
        }
        translate([motorSpacing/2-electricsCarrierLength/3.5,motorSpacing/2,4]){ // mounting opening for FPV camera
          difference(){
            rotate([0,cameraAngle,0]){
              difference(){
                translate([-1.5,0,-4]){
                  rotate([0,90,0]){
                    scale([.5,1,1]){
                      cylinder(r=electricsCarrierWidth/2,h=3);
                    }
                  }
                }
                translate([0,0,3]){
                  rotate([0,90,0]){
                    cylinder(center=true,h=3.1,r=4);
                  }
                }
              }
            }
            
            translate([-10,0,-9]){
              cube(center=true,[40,electricsCarrierWidth,10]);
            }
          }
        }
      }
      // posts and holes for M3 fasteners to connect lower base frame to upper frame (for additional modules such as FPV, OSD, etc)
      difference(){
        union(){
          for(x=[(.5*motorSpacing)-electricsCarrierHoleSpacingX/2,(.5*motorSpacing)+electricsCarrierHoleSpacingX/2]){
            for(y=[(.5*motorSpacing)-electricsCarrierHoleSpacingY/2,(.5*motorSpacing)+electricsCarrierHoleSpacingY/2]){
              translate([x,y,0]){
                cylinder(h=3,r=electricsCarrierM3ScrewHolePadding+1.7);
              }
            }
          }
        }
        union(){
          for(x=[(.5*motorSpacing)-electricsCarrierHoleSpacingX/2,(.5*motorSpacing)+electricsCarrierHoleSpacingX/2]){
            for(y=[(.5*motorSpacing)-electricsCarrierHoleSpacingY/2,(.5*motorSpacing)+electricsCarrierHoleSpacingY/2]){
              translate([x,y,-0.1]){
                cylinder(h=3.2,r=1.7); // should be r=1.7 for a nice fit with M3 screws
              }
            }
          }      
        }
      }
    }
  }
}

