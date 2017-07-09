$fn=150;

//Systems of Equations for the variables. The only variables which may be directly altered are the thickness and the outer radius.
dTh=50;
dOutRad=75;
dIntRad=dOutRad-dTh;
dXTrans=dOutRad-dTh/2;

//Here are the moldinder variables; moldThickness is the only one which requires definition

moldThickness=10;
moldH=(dTh/2)+moldThickness;
moldZTrans=moldH/2;
moldRad=dOutRad+moldThickness;

//Here are the variables related to the connector

connectRad=dIntRad-moldThickness;
connectH=2*moldH;
connectZTrans=moldH;

//Here are the variables relating to the smaller positive donut of the convext portion of the mold. The only thing which requires definition is the variable "wallThickness"

wallThickness=5;
sdTh=dTh-2*wallThickness;
sdXTrans=dXTrans;
sdIntRad=dOutRad-dTh;

//The variables relating to the other (smaller and convex) portion of the slip mold body:

hDiffMold1a2= dTh-sdTh;
mold2H=moldH-hDiffMold1a2;
mold2ZTrans=-1*mold2H/2;

//Pour hole varioble

pourHoleRad=7.5;
pourHoleH=sdTh+mold2H;

//Connector buffer

connectBuff=1;

//Components related to the concave portion

//Here is the positive of the full convex donut:
module donutWhole(){
rotate_extrude(convexity=15)
translate([dXTrans,0,0])
circle(r=dTh/2,center=true);
    }
//Here is the cylinder from which the whole donut is being subtracted:
module diffMold(){
translate([0,0,moldZTrans])
cylinder(moldH,moldRad,moldRad, center=true);
}
//Components related to the concave portion
module smallDonutConvex(){
rotate_extrude(convexity=15)
translate([sdXTrans,0,0])
circle(r=sdTh/2, center=true);
}
//Here is the other half of the physical mold (convex section, cont'd from the convex donut. The cylinder is reused from the first, simply the height has been reduced to reduce wasted material.
module diffMold2(){
translate([0,0,mold2ZTrans])
cylinder(mold2H,moldRad,moldRad, center=true);
}
//Here's the connector:
module connector(){
//translate([0,0,connectZTrans])
cylinder(connectH,connectRad,connectRad, center=true);    
}
//Here's the connector with a buffer for the differencing to allow for some more room for a comfortable fit:
module connectorWRoom(){
 cylinder(connectH, connectRad+connectBuff, connectRad+connectBuff, center=true);   
}
//Pour hole cylinder to be cut out of the larger mold
module pourHole(){
translate([dXTrans,0,0])
cylinder(pourHoleH, pourHoleRad, pourHoleRad, center=true);
}
//Calling of previously established functions and operations related to functions

//Below is the whole convex section module.
module convex(){
//This difference cuts out the pour hole
difference(){
union(){    
            //This difference cuts out the hole for the connector from the top part
            difference(){
                    union(){
                    smallDonutConvex();
                    diffMold2();
                    }
            connectorWRoom();
            }
}
pourHole();
}
}
//Below is the whole concave section module.
module concave(){
difference(){
//Below is cutting the donut out of the cylinder
difference(){
diffMold();
donutWhole();
}
connector();
}
connector();
}
//Last call
translate([150,0,0]) //(This is only to get it out of the way)
concave();
//translate([-150,0,0]) //This is only to get it out of the way
convex();
