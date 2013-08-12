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


moteclip(15, 33.33, 20.25,   3, 3,  3,  45);


module moteclip(depth, mote_w, mote_h, wall_width, base_height, clip_depth, clip_angle) {
  // outer bounding width:
  outer_w = mote_w + 2*wall_width;

  // How high does our clip need to be given the depth and angle?
  clip_height = clip_depth/tan(clip_angle);


  // outer bounding height
  outer_h = mote_h + wall_width + clip_height;

  // where to offset for deletion operations
  del_delta = 1;
  // how much z to use for deletions
  del_depth = depth + 2*del_delta; 

  difference() {
    cube([outer_w,outer_h,depth]);
    translate([wall_width,base_height,-del_delta]) cube([mote_w, mote_h, del_depth]);


    // remove the parallelogram for the clip gap
    translate([wall_width, base_height+mote_h+clip+height,-del_delta]) #
      linear_extrude(height=del_depth, center=false) 
      polygon( points=[[0,0], [clip_depth,clip_height], [mote_w-clip_depth,clip_height], [mote_w,0]]);
  }
}
