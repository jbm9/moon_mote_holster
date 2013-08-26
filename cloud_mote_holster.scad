// A holster for Calvin's moon nightlight remote
//
// Released to the public domain
//
// Remote dimensions:
// 33.33mm wide
// 85mm tall
// 45mm from bottom of mote to bottom of bottommost button
// 20.25mm deep
//

// needs to accept a 6mm diameter screw (will drill out)

// NB: the base_height below is pretty tight, since you have to fit a
// countersunk screw in there.  You might want to beef it up a mm or
// two.

include <moteclip.scad>;


moteW = 33.33+1;
moteH = 20.25 + 2.75; // added slop, since we're capturing it fully now
moteL = 85 + 1;

wallW = 3;
baseH = 3;
clipD = 10;
clipW = 3;
clipA = 45;


notchW = 10;
notchD = baseH/2;

screwR = 4/2;

midline = (moteW+2*wallW)/2;


difference() {

    moteclip(clipD, 
	     moteW, moteH,
	     wallW, baseH,
	     clipW, clipA);

 translate([midline-notchW/2, 0,0]) cube([notchW, notchD, clipD   ], false);
    translate([midline,0,clipD/2]) rotate([-90,0,0]) cylinder(baseH, screwR, screwR, false);
}



translate([-20,-10,0]) difference() {
  moteclip(notchW,
	   moteL, moteH,
	   wallW, baseH, clipW, clipA);

 translate([(85+wallW*2-clipD)/2, baseH/2, 0]) cube([clipD, notchD, notchW], false);
 translate([(85+wallW*2)/2,0,notchW/2]) rotate([-90,0,0]) cylinder(baseH, screwR, screwR, false);
}


