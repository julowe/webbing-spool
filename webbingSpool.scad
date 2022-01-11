// webbing spool
//justin lowe 2021-01-11

/* TODO

- fix up comments to support customizer style (line before, not trailing)
- check overlap of circles to remove from spool wheel, increase number for longer webbing lengths (over ~20ft). Or make ovals?
- ugh, add some padding to all differences just so that previews of objects will not have artifcating?
- tweak some built in dimensions - inner hub diam, wheel thickness, hub wall thickness
- clip to snap on to wheel for another attachemtn option (other than/in addition to carabiner hole)

*/
//


/* [Output Options] */

//Cylinder Facets - IMPORTANT: Choose higher (>= 90) for smooth final render/object, smaller for quick draft preview. (Default is set small so Thingiverse will create preview quicker)
Current_Facets = 18; // [18,36,90,180]
//FYI: 18 is what I usually use for previews, 90 or 180 for final renders.
$fn = Current_Facets;

//Make Bottom of Spool Wheel, Top of Spool Wheel, or central joining Peg
Output_Object = "Peg"; // [Bottom, Top, Peg]


/* [Webbing Info] */

//Width of Webbing (in mm)
Webbing_Width = 25.25; 
//actual 25.25mm

//Length of Webbing (in feet) (Longer than 20' currently generates unprintable objects, need to fix that...)
Webbing_Length_ft = 15; // [2:0.5:21]
// [2:0.5:100]
webbingLength = 305 * Webbing_Length_ft; //305mm in one ft

//Thickness of Webbing (in mm)
Webbing_Thickness = 2;

//Space (in mm) to add between Webbing Retaining Clips aroudn central hub and Webbing itself. Changing this will make webbing easier or harder to thread/pull past clip
Webbing_Thickness_Padding_For_Clips = 0.1;
//webbingLength = 305 * .00001; //305mm in one ft

/* [Carabiner Info] */
//most carabiners seem to be 10 to 14mm diameter materials

//Diameter (in mm) of hole for carabiner/attachment point
Carabiner_Hole_Diameter = 18; 
//18mm = 0.7inches

//Distance (in mm) from edge of material to edge of hole for carabiner
Carabiner_Hole_Edge_Threshold_Distance = 5;

/* [Retainer Clips] */
//Number of clips that will hold webbing against central hub of Spool
Webbing_Clip_Number = 2;

module __Just_A_Module_to_stop_below_values_from_showing_in_Customizer__ () {}
//https://en.m.wikibooks.org/wiki/OpenSCAD_User_Manual/Customizer#supported_variables

//still retainer clip info, but probably shouldn't be easily chagned by user/in customizer
webbingClipWidth = 5;
webbingClipDepth = 3;


//spool info
//TODO Change this padding?? Prob don't need quite as much
hubInnerInnerDiameter = 24; //empty space in center of spool, bottom wheel
hubInnerInnerRadius = hubInnerInnerDiameter/2;
//TODO make wall thinner? test print
hubWallThickness = 3;
hubInnerOuterGap = 0.3; //gap for smooth spinning

hubInnerOuterDiameter = hubInnerInnerDiameter + (hubWallThickness * 2) - (hubInnerOuterGap * 2); //bottom wheel, two wheels of walls plus gap on each side

hubOuterInnerDiameter = hubInnerInnerDiameter + (hubWallThickness * 2); //top wheel, two wheels of walls 
hubOuterOuterDiameter = hubOuterInnerDiameter + (hubWallThickness * 2); //top wheel, wall thickness on both sides

//diameter to radius
hubInnerOuterRadius = hubInnerOuterDiameter/2;
hubOuterOuterRadius = hubOuterOuterDiameter/2;
hubOuterInnerRadius = hubOuterInnerDiameter/2;

spoolGapWidth = Webbing_Width + 3; //total gap between two wheels of spool and wide edge of webbing
spoolOuterRadiusPadding = 5; //how much overhang of spool wheels past spooled webbing

//TODO make thinner? 3? 2?
wheelHeight = 4;
wheelSubtractionHoleOuterPadding = 7; //distance between subtracted hole and outer edge of wheel
wheelSubtractionHoleNumber = 5; //7 holes will overlap each other
//could find cirumference of circle at translation point and verify that total diameter of holes does not exceed that, plus fudge since straight line vs circle... worth it?? prob not



//snapfit info
snapFitJointVerticalGap = 0.5; //how much void vertically on bottom and top between peg and spool wheel hub receiver
snapFitPegJoinHeight = 2; //how much soild space at middle vertical of peg shaft
snapFitJointHeight = 5; //how tall is the torus
snapFitPegJointShaftOverlapRadius = snapFitJointHeight/4; //how much overlap between shaft cylinder and torus (not part of overall shaft height calculation) //so 10.5mm diameter shaft
snapFitPegVerticalOverlap = snapFitJointHeight*2/3;
snapFitJointVoidDiameter = 8; //horizontal diameter of void in peg snap fit joint
snapFitJointHorizontalGap = 0.5; //not used for peg, but for voids in spool hubs
snapFitPegJointSeperation = spoolGapWidth - (2*snapFitJointVerticalGap) - (2*snapFitJointHeight); //how tall is shaft connecting two toruses
echo("snap Fit Peg Joint Seperation = ", snapFitPegJointSeperation);
snapFitPegHorizontalGap = 0.5;

//how much of peg radius to chop off the two sides
snapFitSquaring = 0.1*snapFitJointHeight/2;





//snapFitSphereJointWallThickness = 2;
//snapFitSphereJointWallInsideGap = 1; //between ball joint and snap fit receiver
//snapFitSphereJointWallOutsideGap = 1; //between snap fit receiver and outer cylinder, to allow for some flex inside spool central cylinder XX

//FYI
//Webbing_Width = 25.25; //actual 25.25
//hubInnerInnerDiameter = 24; //this could be changed. arbitrary

//snapFitJointVerticalGap = 1;
//snapFitPegJointSeperation = 8; //distance on peg between two toruses
//snapFitPegJoinHeight = 4;
//snapFitJointHeight = (Webbing_Width - snapFitPegJointSeperation - (2*snapFitJointVerticalGap))/2;
//echo("Snap Fit JointHeight = ", snapFitJointHeight);
//snapFitJointHeight



//snapFitSpherePeg = hubInnerInnerDiameter - (2*hubWallThickness) - (2*snapFitSphereJointWallThickness) - (2*snapFitSphereJointWallInsideGap) - (2*snapFitSphereJointWallOutsideGap);
//snapFitSphereJointInsideDiameter = snapFitSpherePeg + (2*snapFitSphereJointWallInsideGap);
//snapFitSphereJointOutsideDiameter = snapFitSpherePeg + (2*snapFitSphereJointWallInsideGap) + (2*snapFitSphereJointWallThickness);
//echo("Snap Fit Sphere Peg Diameter = ", snapFitSpherePeg);
//echo("Snap Fit Sphere Joint Outer Diameter = ", snapFitSphereJointOutsideDiameter);

//TODO remove all falnge code
//flange info
//flangeInsetWidthRadiusX = 2;
//flangeInsetRadiusZ = 2;
//flangeBumpWidthRadiusX = 1.3;
//flangeBumpRadiusZ = 2;
//clipPerfX = hubWallThickness+4;
//clipPerfY = 3;
//clipPerfZFactor = 4;
//clipPerfSolidY = 3;
//clipPerfHubFactor = 0.7;
//hubInnerInnerCircumference = hubInnerInnerDiameter * PI;
//clipPerfNumberCalc = hubInnerInnerCircumference / (clipPerfY + clipPerfSolidY);
//echo("Clip perf calculated number  = ", clipPerfNumberCalc);
//clipPerfNumber = floor(clipPerfNumberCalc);
//echo("Clip perf number  = ", clipPerfNumber);
//clipPerfRotation = 360/clipPerfNumber;

//calculated spool info
WebbingNumberTurns = (Webbing_Thickness - hubOuterOuterDiameter + sqrt(pow(hubOuterOuterDiameter - Webbing_Thickness,2)+((4 * Webbing_Thickness * webbingLength)/PI)))/(2 * Webbing_Thickness);
webbingSpooledDiameter = (2 * WebbingNumberTurns * Webbing_Thickness) + hubOuterOuterDiameter;
SpoolOuterDiameter = webbingSpooledDiameter + (2 * spoolOuterRadiusPadding);
echo("Spool diameter = ", SpoolOuterDiameter);

spoolWorkingRadius = (SpoolOuterDiameter/2) - (hubInnerInnerRadius + 2 * hubWallThickness);
wheelSubtractionHoleDiameter = spoolWorkingRadius - wheelSubtractionHoleOuterPadding;
wheelSubtractionHoleRadius = wheelSubtractionHoleDiameter/2;
wheelSubtractionHoleTranslation = wheelSubtractionHoleRadius + (hubInnerInnerRadius + 2 * hubWallThickness);
wheelSubtractionHoleRotation = 360/wheelSubtractionHoleNumber;

//clip hole info
clipSquareDiagonal = abs(sqrt(pow((SpoolOuterDiameter/2),2) * 2));
clipRoundingHoleDiameter = clipSquareDiagonal - SpoolOuterDiameter/2;
//clipHoleCenterTranslation = SpoolOuterDiameter/2 + (clipRoundingHoleDiameter/2);
clipRoundingHoleCenterTranslation = SpoolOuterDiameter/2 - (clipRoundingHoleDiameter/2);


echo("Clip square diagonal  = ", clipSquareDiagonal);
echo("Clip hole diameter = ", clipRoundingHoleDiameter);
echo("Clip Rounding cylinder translation = ", clipRoundingHoleCenterTranslation);



//
//
// snap fit peg
module snapFitPeg(){
    difference(){
        union(){
            //bottom torus
            translate([0,0,snapFitJointHeight/2]){
                scale([1,1,1]){
                    rotate_extrude(convexity = 10){
                        translate([-snapFitJointVoidDiameter/2,0,0]){
                            difference(){
                                circle(snapFitJointHeight/2);
                                translate([0,-snapFitJointHeight/2,0]){
                                    square(snapFitJointHeight/2*2);
                                }
                            }
                        }
                    }
                }
            }
        
            //shaft joining toruses
    //        snapFitPegJointShaftOverlapRadius = snapFitJointHeight/4;
    //        snapFitPegVerticalOverlap = snapFitJointHeight*2/3;
            translate([0,0,snapFitJointHeight-snapFitPegVerticalOverlap]){
                cylinder(snapFitPegJointSeperation+(2*snapFitPegVerticalOverlap), d1=snapFitJointVoidDiameter+(snapFitPegJointShaftOverlapRadius*2), d2=snapFitJointVoidDiameter+(snapFitPegJointShaftOverlapRadius*2));
            }
            
            //top torus
            translate([0,0,snapFitPegJointSeperation+snapFitJointHeight*3/2]){
                scale([1,1,1]){
                    rotate_extrude(convexity = 10){
                        translate([-snapFitJointVoidDiameter/2,0,0]){
                            difference(){
                                circle(snapFitJointHeight/2);
                                translate([0,-snapFitJointHeight/2,0]){
                                    square(snapFitJointHeight/2*2);
                                }
                            }
                        }
                    }
                }
            }
        } //end union
    
    
        //chop off +X side of peg        
        translate([snapFitJointVoidDiameter/2-snapFitSquaring,-(snapFitJointVoidDiameter/2+snapFitJointHeight),0]){
            cube([snapFitJointHeight*2,snapFitJointHeight*2+snapFitJointVoidDiameter,30]);
        }
        
         //chop off -X side of peg 
        translate([-(snapFitJointVoidDiameter/2-snapFitSquaring)-snapFitJointHeight*2,-(snapFitJointVoidDiameter/2+snapFitJointHeight),0]){
            cube([snapFitJointHeight*2,snapFitJointHeight*2+snapFitJointVoidDiameter,30]);
        }
        
        //remove sphere from bottom side of peg
        translate([0,0,-snapFitJointVoidDiameter/2+snapFitJointHeight+(snapFitPegJointSeperation-snapFitPegJoinHeight)/2]){
            sphere(d=snapFitJointVoidDiameter);
        }
        
        //remove sphere from top side of peg
        translate([0,0,snapFitJointVoidDiameter/2+snapFitJointHeight+snapFitPegJointSeperation-(snapFitPegJointSeperation-snapFitPegJoinHeight)/2]){
            sphere(d=snapFitJointVoidDiameter);
        }
        
        //remove cylinder from bottom side of peg
        translate([0,0,0]){
            cylinder(-snapFitJointVoidDiameter/2+snapFitJointHeight+(snapFitPegJointSeperation-snapFitPegJoinHeight)/2, d1=snapFitJointVoidDiameter, d2=snapFitJointVoidDiameter);
        }
        
        //remove cylinder from top side of peg
        translate([0,0,snapFitJointVoidDiameter/2+snapFitJointHeight+snapFitPegJointSeperation-(snapFitPegJointSeperation-snapFitPegJoinHeight)/2]){
            cylinder(-snapFitJointVoidDiameter/2+snapFitJointHeight+(snapFitPegJointSeperation-snapFitPegJoinHeight)/2, d1=snapFitJointVoidDiameter, d2=snapFitJointVoidDiameter);
        }
    }
}
//whitespace



//spool halves consist of smaller & taller inner cylinder (with one central hole), larger and much shorter wheel cylinder (with holes in wheel cylinder to lighten weight)


//
//
// wheel base - w argument for optional carabiner clip
module wheelBase(clipHoleBool, retainerClipsBool) {
    difference(){
        union(){
            //wheel
            //large spool wheel
            cylinder(wheelHeight, SpoolOuterDiameter/2, SpoolOuterDiameter/2, false, $fn = Current_Facets);
                
            if (clipHoleBool) {
                //clip hole bump out
                translate([0,0,0]){
                    cube([SpoolOuterDiameter/2, SpoolOuterDiameter/2, wheelHeight], false);
                }
            } //end if
            
            if (retainerClipsBool) {
                retainerClips();
            }
        } //end union of wheel base and clip bumpout
        
        if (clipHoleBool) {
            //smooth out clip square corner
            translate([clipRoundingHoleCenterTranslation, clipRoundingHoleCenterTranslation, 0]){
                difference(){
                    cube([clipRoundingHoleDiameter/2, clipRoundingHoleDiameter/2, wheelHeight], false);  
                    cylinder(wheelHeight, clipRoundingHoleDiameter/2, clipRoundingHoleDiameter/2, false, $fn = Current_Facets);
                }
            }
            
            //check that clip isn't messed up in a few ways
            if( (clipRoundingHoleDiameter/2) > (Carabiner_Hole_Diameter/2 + Carabiner_Hole_Edge_Threshold_Distance) ){
                echo("Clip hole Diameter OK");
                clipHoleCenterTranslation = clipRoundingHoleCenterTranslation;
                //make hole in clip hole bump out
                translate([clipHoleCenterTranslation, clipHoleCenterTranslation, 0]){
                    cylinder(wheelHeight, Carabiner_Hole_Diameter/2, Carabiner_Hole_Diameter/2, false, $fn = Current_Facets);
                }
            }
            else
            {
                echo("Clip hole Diameter NOT OK");
                echo("Clip hole was", (clipRoundingHoleDiameter/2) - (Carabiner_Hole_Diameter/2)," away from edge");
                clipHoleCenterTranslation = clipRoundingHoleCenterTranslation - (Carabiner_Hole_Edge_Threshold_Distance - ((clipRoundingHoleDiameter/2) - (Carabiner_Hole_Diameter/2)));
                echo("Clip hole translation now = ", clipHoleCenterTranslation);
                //make hole in clip hole bump out
                translate([clipHoleCenterTranslation, clipHoleCenterTranslation, 0]){
                    cylinder(wheelHeight, Carabiner_Hole_Diameter/2, Carabiner_Hole_Diameter/2, false, $fn = Current_Facets);
                }
            }
        } //end if clipHoleBool
    
        //holes to cut from larger spool wheel (2x wheelHeight to remove overlap from retianer clips)
        for (i = [0:wheelSubtractionHoleNumber-1]) {
            rotate([0,0,wheelSubtractionHoleRotation * i]){
                translate([wheelSubtractionHoleTranslation,0,0]){
                    cylinder(2*wheelHeight, wheelSubtractionHoleRadius, wheelSubtractionHoleRadius, false, $fn = Current_Facets);
                }
            }
        } //end for
    }                      
}
//whitespace at end of wheelBase




//
//
// retainer clips - to hold webbing against central cylinder
module retainerClips() {
    //TODO move clips closer
    //TODO check that fewer clips than holes in spool wheel? Or does the math work that thye will just be placed upon the others?
    //webbing clips
    for (i = [0:Webbing_Clip_Number-1]) {
        rotate([0,0,wheelSubtractionHoleRotation * i
        + 6]){
            translate([-1 * (hubOuterOuterRadius + Webbing_Thickness - Webbing_Thickness_Padding_For_Clips) - webbingClipDepth, 0, 0]) {
                difference(){
                    union(){
                        cube([webbingClipDepth,webbingClipWidth,(0.95*spoolGapWidth) + wheelHeight],false);
                        
                        rotate([0,0,0]){
                            translate([0,webbingClipWidth,wheelHeight]){
                                difference(){
                                    cube([webbingClipDepth,4,4]); //webbingClipDepth,webbingClipWidth
                        
                                    translate([0,3,3]){
                                        rotate([0,90,0]){
                                            cylinder(webbingClipDepth,3,3);
                                        }
                                    }
                                    
                                    translate([0,3,0]){
                                        cube([webbingClipDepth,4,4]);
                                    }
                                    translate([0,0,3]){
                                        cube([webbingClipDepth,4,4]);
                                    }
                                }
                            }
                        } //end rotate
                        
                        rotate([0,0,180]){
                            translate([-webbingClipDepth,0,wheelHeight]){
                                difference(){
                                    cube([webbingClipDepth,4,4]); //webbingClipDepth,webbingClipWidth
                        
                                    translate([0,3,3]){
                                        rotate([0,90,0]){
                                            cylinder(webbingClipDepth,3,3);
                                        }
                                    }
                                    
                                    translate([0,3,0]){
                                        cube([webbingClipDepth,4,4]);
                                    }
                                    translate([0,0,3]){
                                        cube([webbingClipDepth,4,4]);
                                    }
                                }
                            }
                        } //end rotate
                        
                        
//                                    translate([0,0,(0.95*spoolGapWidth) + wheelHeight - webbingClipWidth/2]){
//                                    difference(){
//                                        cube([webbingClipDepth,webbingClipWidth,webbingClipWidth/2],false);
//                            
//                                        translate([0,webbingClipWidth/2,0]){
//                                            rotate([0,90,0]){
//                                                cylinder(webbingClipDepth,webbingClipWidth/2,webbingClipWidth/2);
//                                            }
//                                        }
//                                    }
//                                }
                
                    } //end union
                
                
                    translate([0,0,(0.95*spoolGapWidth) + wheelHeight - webbingClipWidth/2]){
                        difference(){
                            cube([webbingClipDepth,webbingClipWidth,webbingClipWidth/2],false);
                
                            translate([0,webbingClipWidth/2,0]){
                                rotate([0,90,0]){
                                    cylinder(webbingClipDepth,webbingClipWidth/2,webbingClipWidth/2);
                                }
                            }
                            
                        } //end difference
                    } //end translate
                         
                }

            } //end translate
        } //end rotate (of clip(s) around central hub)
    } //end for
}
//whitespace at end of retainerClips


//
//
// hub for bottom wheel - receives webbing, has retainer clips, larger diameter central cylinder - spins freely to spool off the webbing
module hubBottom() {
    
    difference() {
        //outer spool
        cylinder(spoolGapWidth + wheelHeight, hubOuterOuterRadius, hubOuterOuterRadius, false, $fn = Current_Facets);
        
        //larger hub void
        //TODO use if/else to always make this inner wall of the outer hub at least... 45 facets on cylinder so that it spins smoothly? (e.g. even if the rest of the spool is at 18 facets)
        translate([0,0,wheelHeight + (spoolGapWidth * 0.45)]){
            cylinder((spoolGapWidth * 0.55), hubOuterInnerRadius, hubOuterInnerRadius, false, $fn = Current_Facets); 
        }
        
        //snap fit torus
        translate([0,0,wheelHeight+snapFitJointHeight/2+snapFitJointVerticalGap]){
            scale([1,1,1]){
                rotate_extrude(convexity = 10){
                    translate([-snapFitJointVoidDiameter/2,0,0]){
                        difference(){
                            circle(snapFitJointHeight/2+snapFitJointVerticalGap);
                            translate([0,-snapFitJointHeight/2,0]){
                                square((snapFitJointHeight/2+snapFitJointVerticalGap)*2);
                            }
                        }
                    }
                }
            }
        } //end translate (snap fit torus)

        //remove torus center
        translate([0,0,wheelHeight]){
            cylinder(snapFitPegJointSeperation+(2*snapFitPegVerticalOverlap), d1=snapFitJointVoidDiameter*1.1, d2=snapFitJointVoidDiameter*1.1);
        }
        
        //make hole for snap fit shaft (that joins toruses)
        translate([0,0,wheelHeight+snapFitJointHeight-snapFitPegVerticalOverlap]){
            cylinder(snapFitPegJointSeperation+(2*snapFitPegVerticalOverlap), d1=snapFitJointVoidDiameter+(snapFitPegJointShaftOverlapRadius*2)+(snapFitPegHorizontalGap*2), d2=snapFitJointVoidDiameter+(snapFitPegJointShaftOverlapRadius*2)+(snapFitPegHorizontalGap*2));
        }
        
        //make hole for snap fit shaft angles a bit 
        translate([0,0,(spoolGapWidth * 0.45) + wheelHeight-2]){
            cylinder(2, d1=snapFitJointVoidDiameter+(snapFitPegJointShaftOverlapRadius*2)+(snapFitPegHorizontalGap*2), d2=(snapFitJointVoidDiameter+(snapFitPegJointShaftOverlapRadius*2)+(snapFitPegHorizontalGap*2))*1.2);
        }
    
    } //end difference           

}
//whitepace at end of hubBottom


//
//
// hub for top wheel - smaller diameter central cylinder - has clip hole and does not spin when spooling off webbing
module hubTop() {
    difference() {
        //inner spool, outer wall
        //TODO use if/else to always make this outer wall of the inner hub at least... 45 facets on cylinder so that it spins smoothly? (e.g. even if the rest of the spool is at 18 facets)
        cylinder( (spoolGapWidth * 0.45) + wheelHeight, hubInnerOuterRadius, hubInnerOuterRadius, false, $fn = Current_Facets); //double up wheelheight to mate wheels evenly
        
        //snap fit torus
        translate([0,0,wheelHeight+snapFitJointHeight/2+snapFitJointVerticalGap]){
            scale([1,1,1]){
                rotate_extrude(convexity = 10){
                    translate([-snapFitJointVoidDiameter/2,0,0]){
                        difference(){
                            circle(snapFitJointHeight/2+snapFitJointVerticalGap);
                            translate([0,-snapFitJointHeight/2,0]){
                                square((snapFitJointHeight/2+snapFitJointVerticalGap)*2);
                            }
                        }
                    }
                }
            }
        }
        
        //remove torus center
        translate([0,0,wheelHeight]){
            cylinder(snapFitPegJointSeperation+(2*snapFitPegVerticalOverlap), d1=snapFitJointVoidDiameter*1.1, d2=snapFitJointVoidDiameter*1.1);
        }
        
        //make hole for snap fit shaft (that joins toruses)
        translate([0,0,wheelHeight+snapFitJointHeight-snapFitPegVerticalOverlap]){
            cylinder(snapFitPegJointSeperation+(2*snapFitPegVerticalOverlap), d1=snapFitJointVoidDiameter+(snapFitPegJointShaftOverlapRadius*2)+(snapFitPegHorizontalGap*2), d2=snapFitJointVoidDiameter+(snapFitPegJointShaftOverlapRadius*2)+(snapFitPegHorizontalGap*2));
        }
        
        //make hole for snap fit shaft angles a bit 
        translate([0,0,(spoolGapWidth * 0.45) + wheelHeight-2]){
            cylinder(2, d1=snapFitJointVoidDiameter+(snapFitPegJointShaftOverlapRadius*2)+(snapFitPegHorizontalGap*2), d2=(snapFitJointVoidDiameter+(snapFitPegJointShaftOverlapRadius*2)+(snapFitPegHorizontalGap*2))*1.2);
        } 
        
    } //end difference
    
}
//whitespace at end of hubTop

//
// IN PROGRESS
//

webbingClipWheelOffset = 0.2;
wheelClipWheelDepthFactor = 0.75;
//wheelClipSlotDepth = wheelHeight*wheelClipWheelDepthFactor;
wheelClipBaseDepth = 2;
wheelClipDepth = 3;
wheelClipWidth = 25;
wheelClipHeight = SpoolOuterDiameter*3/5;

webbingClipGap = 2; //how much to leave for molle straps?
webbingClipJoinHeight = 7; //how much material to secure clip to spool & base

wheelClipTrapezoidHeight = 10;
wheelClipTrapezoidWidth = wheelClipWidth/2;
wheelClipTrapezoidWidthRatio = 1.3;
wheelClipTrapezoidDepth = wheelHeight;

//
//TODO wheelClip is not finished
//
module wheelClip(){
    
translate([0,200,0]){
    
    //clip
    translate([-SpoolOuterDiameter/4,-wheelClipWidth/2,-wheelClipBaseDepth-webbingClipGap-wheelClipDepth]){
        cube([wheelClipHeight,wheelClipWidth,wheelClipDepth]);
    }
    
    //clip join at top, gap for molle
    translate([-SpoolOuterDiameter/4,-wheelClipWidth/2,-wheelClipBaseDepth-webbingClipGap]){
        cube([webbingClipJoinHeight,wheelClipWidth,webbingClipGap]);
    }
    
    //clip base (that goes into spool wheel)
    translate([-SpoolOuterDiameter/4,-wheelClipWidth/2,-wheelClipBaseDepth]){
        cube([SpoolOuterDiameter/4+(hubInnerInnerRadius + 2 * hubWallThickness),wheelClipWidth,wheelClipBaseDepth]);
    }
    
    intersection(){
        translate([-SpoolOuterDiameter/4,-wheelClipWidth/2,0]){
            cube([SpoolOuterDiameter/4,wheelClipWidth,wheelHeight*wheelClipWheelDepthFactor]);
        }
    
        //originally holes to cut from larger spool wheel, used here to intersect with big block and keep intersections
        for (i = [0:wheelSubtractionHoleNumber-1]) {
            rotate([0,0,wheelSubtractionHoleRotation * i]){
                translate([wheelSubtractionHoleTranslation,0,0]){
                    cylinder(wheelHeight*wheelClipWheelDepthFactor, wheelSubtractionHoleRadius-webbingClipWheelOffset, wheelSubtractionHoleRadius-webbingClipWheelOffset, false, $fn = Current_Facets);
                }
            }
        }
    }
    
    trapezoidPoints = [
  [  -wheelClipTrapezoidHeight,  -(wheelClipTrapezoidWidth/2),  0 ],  //0
  [ 0,  -(wheelClipTrapezoidWidth/2),  0 ],  //1
  [ 0,  (wheelClipTrapezoidWidth/2),  0 ],  //2
  [  -wheelClipTrapezoidHeight,  (wheelClipTrapezoidWidth/2),  0 ],  //3
  [  -wheelClipTrapezoidHeight,  -(wheelClipTrapezoidWidth/2*wheelClipTrapezoidWidthRatio),  wheelClipTrapezoidDepth ],  //4
  [ 0,  -(wheelClipTrapezoidWidth/2*wheelClipTrapezoidWidthRatio),  wheelClipTrapezoidDepth ],  //5
  [ 0,  (wheelClipTrapezoidWidth/2*wheelClipTrapezoidWidthRatio),  wheelClipTrapezoidDepth ],  //6
  [  -wheelClipTrapezoidHeight,  (wheelClipTrapezoidWidth/2*wheelClipTrapezoidWidthRatio),  wheelClipTrapezoidDepth ]]; //7
  
    trapezoidFaces = [
  [0,1,2,3],  // bottom
  [4,5,1,0],  // front
  [7,6,5,4],  // top
  [5,6,2,1],  // right
  [6,7,3,2],  // back
  [7,4,0,3]]; // left
  


    //TODO make trapeoid join / and gap in wheel
    translate([wheelSubtractionHoleTranslation - wheelSubtractionHoleRadius,0,0]){
        polyhedron( trapezoidPoints, trapezoidFaces );
    }
    
    //TODO round edges of clip where outward contatct with molle
    
    translate([0,0,0]){
        rotate([0,0,0]){
            cylinder();
        }
    }
    translate([10,0,0]){
        cylinder(1,1);
    }
    translate([wheelSubtractionHoleTranslation - wheelSubtractionHoleRadius,-(wheelClipWidth/2-wheelClipBaseDepth/2),-wheelClipBaseDepth/2]){
        sphere(wheelClipBaseDepth/2);
    }
}  
}
//whitespace at end of wheelClip

//wheelClip();


//
//actually use modules and make objects here
//
if (Output_Object == "Peg") {
    rotate([0,90,0]) {
        snapFitPeg();
    }
}
else if (Output_Object == "Bottom") {
    union() {
        wheelBase(false, true);
        hubBottom();
    }
}
else if (Output_Object == "Top") {
    union() {
        wheelBase(true, false);
        hubTop();
    }
} //end if Top
