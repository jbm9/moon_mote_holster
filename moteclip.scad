module cuber(w,d,h, r) {
  myfn = 10;


  difference() {
    cube([w,d,h]);

    // bottom left
    translate([r,r,0])
      difference() {
        translate([-r,-r,0]) cube([r,r,h]);
        cylinder(h, r,r, $fn=myfn);
    }
    
    // top left
    translate([r, d-r,0])
      difference() {
      translate([-r,0,0]) cube([r,r,h]);
      cylinder(h,r,r, $fn=myfn);
      }

    // top right
    translate([w-r, d-r,0])
      difference() {
      translate([0,0,0]) cube([r,r,h]);
      cylinder(h,r,r, $fn=myfn);
      }


    // bottom right
    translate([w-r, r,0])
      difference() {
      translate([0,-r,0]) cube([r,r,h]);
      cylinder(h+2,r,r, $fn=myfn);
      }

  }
}

module moteclip(depth, mote_w, mote_h, wall_width, base_height, clip_depth, clip_angle) {
  // outer bounding width:
  outer_w = mote_w + 2*wall_width;

  echo(outer_w);

  // How high does our clip need to be given the depth and angle?
  clip_height = clip_depth/tan(clip_angle);


  // outer bounding height
  outer_h = mote_h + base_height + clip_height;

  // round the corners by this much
  cornerR = 1;


  // how much to hollow out in the corners to avoid overfill (which
  // breaks the print)
  incornerHollow = 1;

  clipcornerHollow = 1;


  difference() {

      translate([0, 0, 0]) cuber(outer_w, outer_h, depth, cornerR);

    translate([wall_width,base_height,0]) cuber(mote_w, mote_h, depth, cornerR);
    //cube([mote_w, mote_h, depth]);
    

      // remove the parallelogram for the clip gap
      translate([wall_width, outer_h,0]) 
	linear_extrude(height=depth, center=false) 
	polygon( points=[[0,0], [clip_depth,-clip_height], [mote_w-clip_depth,-clip_height], [mote_w,0]]);


      // hollow out the corners, so it doesn't overfill and break itself
      translate([wall_width/2+incornerHollow/2, base_height/2+incornerHollow/2,0]) cylinder(depth, incornerHollow, incornerHollow);
	translate([outer_w-(wall_width/2+incornerHollow/2), base_height/2+incornerHollow/2,0]) cylinder(depth, incornerHollow, incornerHollow);

	translate([wall_width/2+clipcornerHollow/2, outer_h-(base_height/2+clipcornerHollow/2),0]) cylinder(depth, clipcornerHollow, clipcornerHollow);
	translate([outer_w-(wall_width/2+clipcornerHollow/2), outer_h-(base_height/2+clipcornerHollow/2),0]) cylinder(depth, clipcornerHollow, clipcornerHollow);



  }
}



module oldclip() {
    cube([outer_w,outer_h,depth]);
    translate([outer_w-cornerR, outer_h-cornerR, 0]) 
      difference() {
      cube([cornerR, cornerR, depth]);
      cylinder(depth+2, cornerR, cornerR, $fn=10);
    }

    translate([cornerR, outer_h-cornerR, 0]) 
      difference() {
      translate([-cornerR, 0,0])
      cube([cornerR, cornerR, depth]);
      cylinder(depth+2, cornerR, cornerR, $fn=10);
    }

      
    translate([outer_w-cornerR, cornerR, 0]) 
      difference() {
      translate([0, -cornerR, 0])
      cube([cornerR, cornerR, depth]);
      cylinder(depth+2, cornerR, cornerR, $fn=10);
    }


    translate([cornerR, cornerR, 0]) 
      difference() {
      translate([-cornerR, -cornerR,0])
      cube([cornerR, cornerR, depth]);
      cylinder(depth+2, cornerR, cornerR, $fn=10);
    }

}
