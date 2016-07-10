#**freeUAV**- a 3d-printable micro brushed quadcopter platform#

freeUAV is an open-source micro quadcopter platform, 3d-printed in carbon-fiber reinforced engineering plastic.

freeUAV is written in OpenSCAD and designed to be parametric, durable, and affordable.

###Why did you make it?###

I've wanted to build a quadcopter for a long time now, but I also wanted to improve my OpenSCAD programming skills. What better way than to design my own frame?

I was inspired by several interesting designs I found on the internet, but none of them seemed exactly what I wanted to fly--so I made my own.
What makes it special?

This design is special for three simple reasons:

**1. It flies well**

Because of the rigidity of the frame and the way that the flight controller board is suspended with rubber bands, the freeUAV is both fluid and agile.

**2. It's open-source**

I'm releasing my source code to this frame so everyone is free to make their own, improve it, or even sell it! It's about freedom, baby.

**3. It's durable**

I tested several iterations of this frame, all different thicknesses, curves, and materials. ColorFabb's XT-CF20 carbon fiber composite copolyester is the best material I've found, bar none. This frame held up to my 66-year-old father and my 12-year-old nephew repeatedly crashing it into the driveway. And some fences. And a house.

I'm proud to say that this frame can fly much better than I can pilot it. And because I've made a few design choices (like printing it in carbon-fiber reinforced filament and designing it with internal motor lips to prevent busting open the motor casings), it can handle the worst that I can throw at it.
What about the tech specs?

Here they are:

* Printed and assembled frame weight (inner and outer frame, with six rubber bands): **10 grams**

* Fully build weight without battery: **35 grams**

* Full weight including 300mAh battery: **44 grams**

* Size: **112mm class** (motor-to-motor diagonal distance--this can be changed easily in the OpenSCAD source file)

* Approximate flight time with 300mAh battery: **8-12 minutes**

###What components do you fly?###

Here are the parts are recommended with the current version of freeUAV:

* [Micro Scisky flight controller board](http://www.banggood.com/Micro-Scisky-32bits-Brushed-Flight-Control-Board-Based-On-Naze-32-For-Quadcopters-p-1002341.html)

* [Hubsan X4 8.5mm diameter brushed motors](http://www.ebay.com/itm/141971019583)

* [Walkera QR Spacewalker props](http://www.ebay.com/itm/141735493973)

* [Turnigy nano-tech 300mAh Li-Po batteries](https://www.hobbyking.com/hobbyking/store/%5F%5F59257%5F%5FTurnigy%5Fnano%5Ftech%5F300mah%5F1S%5F45%5F90C%5FLipo%5FPack%5FFits%5FNine%5FEagles%5FSolo%5FPro%5F100%5FAR%5FWarehouse%5F.html)

###Well then, how can I get one?###

Order a frame from me, through [my Tindie store](https://www.tindie.com/stores/C_Blackstone/) (if you want to support the designer) or print it out yourself! The code is [here on my github](https://github.com/kyleseigler/freeUAV). I highly recommend using the most rigid plastic you can find. PLA actually performs well due to its rigidity, it just breaks easily in crashes. I've also flown several test frames printed with ColorFabb's nGen engineering plastic. It's a wonderful material, but not for this; it flexes too much for controlled flight, and it tends to shatter during hard crashes.

I'm only offering this frame in XT-CF20 because it's the best I've found so far.
