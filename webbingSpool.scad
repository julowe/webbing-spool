// webbing spool

cylinderFacets = 180; //decrease for quicker rendering
//cylinderFacets = 36; //decrease for quicker rendering

//webbing info
webbingThickness = 2;
webbingWidth = 25.25; //actual 25.25
webbingLength = 305 * 15; //305mm in one ft
//webbingLength = 305 * .00001; //305mm in one ft

//carabiner info
//most carabiners seem to be 10 to 14mm diameter materials
carabinerHoleDiameter = 18; //18mm = 0.7inches
carabinerHoleDistanceEdgeThreshold = 5;

//spool info
hubInnerInnerDiameter = 24; //empty space in center of spool
hubInnerInnerRadius = hubInnerInnerDiameter/2;
hubWallThickness = 5;
hubInnerOuterGap = 0.3;
//TODO find good gap between spool hubs

hubInnerOuterDiameter = hubInnerInnerDiameter + (hubWallThickness * 2) - (hubInnerOuterGap * 2); //two wheels of walls plus gap on each side

hubOuterInnerDiameter = hubInnerInnerDiameter + (hubWallThickness * 2); //two wheels of walls 
hubOuterOuterDiameter = hubOuterInnerDiameter + (hubWallThickness * 2); //wall thickness on both sides
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

//flange info
flangeInsetWidthRadiusX = 2;
flangeInsetRadiusZ = 2;
flangeBumpWidthRadiusX = 1.3;
flangeBumpRadiusZ = 2;
clipPerfX = hubWallThickness+4;
clipPerfY = 3;
clipPerfZFactor = 4;
clipPerfSolidY = 3;
clipPerfHubFactor = 0.7;
hubInnerInnerCircumference = hubInnerInnerDiameter * PI;
clipPerfNumberCalc = hubInnerInnerCircumference / (clipPerfY + clipPerfSolidY);
echo("Clip perf calculated number  = ", clipPerfNumberCalc);
clipPerfNumber = floor(clipPerfNumberCalc);
echo("Clip perf number  = ", clipPerfNumber);
clipPerfRotation = 360/clipPerfNumber;

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


echo("Clip square diagonoal  = ", clipSquareDiagonal);
echo("Clip hole diameter = ", clipRoundingHoleDiameter);
echo("Clip Rounding cylinder translation = ", clipRoundingHoleCenterTranslation);

//spool halves consist of smaller & taller inner cylinder (with one central hole), larger and much shorter wheel cylinder (with holes in wheel cylinder to lighten weight)


//
//
//bottom & stationary wheel of spool
difference(){
    union(){
        //wheel
        //large spool wheel
        cylinder(wheelHeight, SpoolOuterDiameter/2, SpoolOuterDiameter/2, false, $fn = cylinderFacets);
            
         
        //inner spool, outer wall
        cylinder(spoolGapWidth + (2 * wheelHeight), hubInnerOuterRadius, hubInnerOuterRadius, false, $fn = cylinderFacets); //doulbe up wheelheight to mate wheels evenly
        
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
    
    //subtract - inner spool void
    cylinder(spoolGapWidth + (2 * wheelHeight), hubInnerInnerRadius, hubInnerInnerRadius, false, $fn = cylinderFacets);
    
    //smooth outer top edge
    //torus - flange subtraction/negative part
    translate([0, 0, spoolGapWidth + (2 * wheelHeight)]) {
        rotate_extrude(convexity = 10, $fn = cylinderFacets) {
            translate([hubInnerOuterRadius, 0, 0]) {
                scale([flangeInsetWidthRadiusX,flangeInsetRadiusZ]) {
                    circle(r = 1, $fn = 4);
                }
            } 
        }
    }
         
    //subtact - gap to spin around ridge on inner wall of outer spool
    //torus - flange subtraction/negative part
    translate([0, 0, spoolGapWidth + (2 * wheelHeight) - flangeInsetRadiusZ*2 + 1]) {
        rotate_extrude(convexity = 10, $fn = cylinderFacets) {
            translate([hubInnerOuterRadius, 0, 0]) {
                scale([flangeInsetWidthRadiusX,flangeInsetRadiusZ]) {
                    circle(r = 1, $fn = 4);
                }
            } 
        }
    }
    
    //perforations on top of clip inner cylinder
    for (i = [0:clipPerfNumber-1]) {
        rotate([0,0,clipPerfRotation * i]){
//            translate([hubInnerInnerDiameter/2-2,-(clipPerfY/2),spoolGapWidth + (2 * wheelHeight) - flangeInsetRadiusZ*clipPerfZFactor]){ //as percentage of clip
            translate([hubInnerInnerDiameter/2-2,-(clipPerfY/2),spoolGapWidth + (2 * wheelHeight) - (spoolGapWidth + wheelHeight)*clipPerfHubFactor]){ //as percentage of hub
//                cube([clipPerfX,clipPerfY,(flangeInsetRadiusZ)*clipPerfZFactor],false); //as percentage of clip
                cube([clipPerfX,clipPerfY,(spoolGapWidth + wheelHeight)*clipPerfHubFactor],false); //as percentage of hub
            }
        }
    }
    


    
}


//whitespace


//
//
// top & moving wheel of spool
//
//
translate([(SpoolOuterDiameter * 1.1),0,0]){
    union(){
        difference(){
            union(){
                //wheel
                difference(){
                    cylinder(wheelHeight, SpoolOuterDiameter/2, SpoolOuterDiameter/2, false, $fn = cylinderFacets);
                    
                //    translate([wheelSubtractionHoleTranslation,0,0]){
                //        cylinder(wheelHeight, wheelSubtractionHoleRadius, wheelSubtractionHoleRadius, false);
                //    }
                    for (i = [0:wheelSubtractionHoleNumber-1]) {
                        rotate([0,0,wheelSubtractionHoleRotation * i]){
                            translate([wheelSubtractionHoleTranslation,0,0]){
                                cylinder(wheelHeight, wheelSubtractionHoleRadius, wheelSubtractionHoleRadius, false, $fn = cylinderFacets);
                            }
                        }
                    }
                }
                
                //outer spool
                cylinder(spoolGapWidth + wheelHeight, hubOuterOuterRadius, hubOuterOuterRadius, false, $fn = cylinderFacets);
                
                //webbing clips
                for (i = [0:webbingClipNumber-1]) {
                    rotate([0,0,wheelSubtractionHoleRotation * i]){
                        translate([-1 * (hubOuterOuterRadius + webbingThickness) - webbingClipDepth, 0, 0]) {
                            cube([webbingClipDepth,webbingClipWidth,spoolGapWidth + wheelHeight],false);
                        }
                    }
                }
            }
            
            //spool void
            cylinder(spoolGapWidth + wheelHeight, hubOuterInnerRadius, hubOuterInnerRadius, false, $fn = cylinderFacets); 
            
        }
        
        //flange bump out
        //hubOuterInnerDiameter
        translate([0, 0, flangeInsetRadiusZ*2 - 1]) {
            rotate_extrude(convexity = 10, $fn = cylinderFacets) {
                translate([hubInnerOuterRadius, 0, 0]) {
                    scale([flangeBumpWidthRadiusX,flangeBumpRadiusZ]) {
                        circle(r = 1, $fn = 4);
                    }
                } 
            }
        }
    }
}