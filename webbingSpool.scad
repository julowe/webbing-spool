// webbing spool
//justin lowe 20201002

//cylinderFacets = 180; //cylinder facets - for export
cylinderFacets = 36; //cylinder facets - decreased for quicker rendering
$fn = cylinderFacets;

//webbing info in mm
webbingThickness = 2;
webbingThicknessClipAdjustment = 0.1;
webbingWidth = 25.25; //actual 25.25
webbingLength = 305 * 15; //305mm in one ft
//webbingLength = 305 * .00001; //305mm in one ft

//carabiner info
//most carabiners seem to be 10 to 14mm diameter materials
carabinerHoleDiameter = 18; //18mm = 0.7inches
carabinerHoleDistanceEdgeThreshold = 5;

//spool info
hubInnerInnerDiameter = 24; //empty space in center of spool, bottom wheel
hubInnerInnerRadius = hubInnerInnerDiameter/2;
hubWallThickness = 3;
hubInnerOuterGap = 0.3; //gap for smooth spinning

hubInnerOuterDiameter = hubInnerInnerDiameter + (hubWallThickness * 2) - (hubInnerOuterGap * 2); //bottom wheel, two wheels of walls plus gap on each side

hubOuterInnerDiameter = hubInnerInnerDiameter + (hubWallThickness * 2); //top wheel, two wheels of walls 
hubOuterOuterDiameter = hubOuterInnerDiameter + (hubWallThickness * 2); //top wheel, wall thickness on both sides

//diameter to radius
hubInnerOuterRadius = hubInnerOuterDiameter/2;
hubOuterOuterRadius = hubOuterOuterDiameter/2;
hubOuterInnerRadius = hubOuterInnerDiameter/2;

spoolGapWidth = webbingWidth + 3; //total gap between two wheels of spool and wide edge of webbing
spoolOuterRadiusPadding = 5; //how much overhang of spool wheels past spooled webbing
wheelHeight = 4;
wheelSubtractionHoleOuterPadding = 7; //distance between subtracted hole and outer edge of wheel
wheelSubtractionHoleNumber = 5; //7 holes will overlap each other
//could find cirumference of circle at translation point and verify that total diameter of holes does not exceed that, plus fudge since straight line vs circle... worth it?? prob not

//webbing retainer clips on hub info
webbingClipNumber = 2;
webbingClipWidth = 5;
webbingClipDepth = 3;

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
//webbingWidth = 25.25; //actual 25.25
//hubInnerInnerDiameter = 24; //this could be changed. arbitrary

//snapFitJointVerticalGap = 1;
//snapFitPegJointSeperation = 8; //distance on peg between two toruses
//snapFitPegJoinHeight = 4;
//snapFitJointHeight = (webbingWidth - snapFitPegJointSeperation - (2*snapFitJointVerticalGap))/2;
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
WebbingNumberTurns = (webbingThickness - hubOuterOuterDiameter + sqrt(pow(hubOuterOuterDiameter - webbingThickness,2)+((4 * webbingThickness * webbingLength)/PI)))/(2 * webbingThickness);
webbingSpooledDiameter = (2 * WebbingNumberTurns * webbingThickness) + hubOuterOuterDiameter;
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
translate([-(SpoolOuterDiameter * 0.8),0,0]){
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
}



//spool halves consist of smaller & taller inner cylinder (with one central hole), larger and much shorter wheel cylinder (with holes in wheel cylinder to lighten weight)

      

//
//
//bottom & stationary wheel of spool
module wheelBottom(){
difference(){
    union(){
        //wheel
        //large spool wheel
        cylinder(wheelHeight, SpoolOuterDiameter/2, SpoolOuterDiameter/2, false, $fn = cylinderFacets);
            
         
        //inner spool, outer wall
        cylinder( (spoolGapWidth * 0.45) + wheelHeight, hubInnerOuterRadius, hubInnerOuterRadius, false, $fn = cylinderFacets); //doulbe up wheelheight to mate wheels evenly
        
        //clip hole bump out
        translate([0,0,0]){
            cube([SpoolOuterDiameter/2, SpoolOuterDiameter/2, wheelHeight], false);
        }
    }
    
    //smooth out clip square corner
    translate([clipRoundingHoleCenterTranslation, clipRoundingHoleCenterTranslation, 0]){
        difference(){
            cube([clipRoundingHoleDiameter/2, clipRoundingHoleDiameter/2, wheelHeight], false);  
            cylinder(wheelHeight, clipRoundingHoleDiameter/2, clipRoundingHoleDiameter/2, false, $fn = cylinderFacets);
        }
    }
    
    //check that clip isn't messed up in a few ways
    if( (clipRoundingHoleDiameter/2) > (carabinerHoleDiameter/2 + carabinerHoleDistanceEdgeThreshold) ){
        echo("Clip hole Diameter OK");
        clipHoleCenterTranslation = clipRoundingHoleCenterTranslation;
        //make hole in clip hole bump out
        translate([clipHoleCenterTranslation, clipHoleCenterTranslation, 0]){
            cylinder(wheelHeight, carabinerHoleDiameter/2, carabinerHoleDiameter/2, false, $fn = cylinderFacets);
        }
    }
    else
    {
        echo("Clip hole Diameter NOT OK");
        echo("Clip hole was", (clipRoundingHoleDiameter/2) - (carabinerHoleDiameter/2)," away from edge");
        clipHoleCenterTranslation = clipRoundingHoleCenterTranslation - (carabinerHoleDistanceEdgeThreshold - ((clipRoundingHoleDiameter/2) - (carabinerHoleDiameter/2)));
        echo("Clip hole translation now = ", clipHoleCenterTranslation);
        //make hole in clip hole bump out
        translate([clipHoleCenterTranslation, clipHoleCenterTranslation, 0]){
            cylinder(wheelHeight, carabinerHoleDiameter/2, carabinerHoleDiameter/2, false, $fn = cylinderFacets);
        }
    } 

    //holes to cut from larger spool wheel
    for (i = [0:wheelSubtractionHoleNumber-1]) {
        rotate([0,0,wheelSubtractionHoleRotation * i]){
            translate([wheelSubtractionHoleTranslation,0,0]){
                cylinder(wheelHeight, wheelSubtractionHoleRadius, wheelSubtractionHoleRadius, false, $fn = cylinderFacets);
            }
        }
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
    
}
}

//whitespace


//          //make hole for snap fit shaft angles a bit 
//    translate([0,0,(spoolGapWidth * 0.45) + wheelHeight-2]){
//        cylinder(2, d1=snapFitJointVoidDiameter+(snapFitPegJointShaftOverlapRadius*2)+(snapFitPegHorizontalGap*2), d2=snapFitJointVoidDiameter+(snapFitPegJointShaftOverlapRadius*2)+(snapFitPegHorizontalGap*2)+10);
//    } 
        
//
//
// top & moving wheel of spool
//
//
module wheelTop(){
translate([(SpoolOuterDiameter * 1.1),0,0]){
    union(){
        difference(){
            union(){
                //wheel
                cylinder(wheelHeight, SpoolOuterDiameter/2, SpoolOuterDiameter/2, false, $fn = cylinderFacets);
                    
                //outer spool
                cylinder(spoolGapWidth + wheelHeight, hubOuterOuterRadius, hubOuterOuterRadius, false, $fn = cylinderFacets);
                
                
                //TODO move clips closer
                //webbing clips
                for (i = [0:webbingClipNumber-1]) {
                    rotate([0,0,wheelSubtractionHoleRotation * i
                    + 6]){
                        translate([-1 * (hubOuterOuterRadius + webbingThickness - webbingThicknessClipAdjustment) - webbingClipDepth, 0, 0]) {
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
                                    }
                                    
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
                                    }
                                    
                                    
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
                                    }
                                }
                            
                            
                            
                            
                        }


                        }
                    }
                }
                
            } //end union
            
            for (i = [0:wheelSubtractionHoleNumber-1]) {
                rotate([0,0,wheelSubtractionHoleRotation * i]){
                    translate([wheelSubtractionHoleTranslation,0,0]){
                        cylinder(2*wheelHeight, wheelSubtractionHoleRadius, wheelSubtractionHoleRadius, false, $fn = cylinderFacets);
                    }
                }
            }
            
            
            //spool void
            
//            //smaller void
//            translate([0,0,wheelHeight]){
//                cylinder(spoolGapWidth, hubInnerInnerRadius, hubInnerInnerRadius, false, $fn = cylinderFacets); 
//            }
            
            //larger hub void
            translate([0,0,wheelHeight + (spoolGapWidth * 0.45)]){
                cylinder((spoolGapWidth * 0.55), hubOuterInnerRadius, hubOuterInnerRadius, false, $fn = cylinderFacets); 
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
    
        } 
        
    }
}
}
//whitespace


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
                    cylinder(wheelHeight*wheelClipWheelDepthFactor, wheelSubtractionHoleRadius-webbingClipWheelOffset, wheelSubtractionHoleRadius-webbingClipWheelOffset, false, $fn = cylinderFacets);
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
    
    translation([0,0,0]){
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
            
wheelBottom();
//wheelTop();
//rotate([0,90,0])snapFitPeg();
wheelClip();
