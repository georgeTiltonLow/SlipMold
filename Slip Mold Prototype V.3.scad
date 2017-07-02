//This is where the part with the hole begins
$fn=20;
dRad=25;
dHeight=15;
dThickness=dHeight;
intRad=5;
moldThickness=3;
moldOuterRad=dRad+moldThickness;

module donutHalf( hole )
{
   render(convexity=100)
   union(){
      difference(){
        difference(){
           difference(){
              translate([0,0,2.5])  difference(){
                    // mold outside cylinder
                    cylinder(dHeight+moldThickness*2,moldOuterRad,moldOuterRad, center=true);
                    // mold hole
                    cylinder(dHeight+moldThickness*2,intRad,intRad, center=true);
                    }
              difference(){
                    // donut
                    rotate_extrude(convexity = 15)
                    translate([dThickness/2+dRad/2, 0, 0])
                    circle(r = dHeight/2);
                  }
            }
        translate([0,0,50])
        cube([200,200,100],center=true);
        }
      //Pour hole
      //if (hole) translate([1.5,1.5,0]) cylinder(3,0.125,0.125, center=false);    
      }
   } 
}

donutHalf(true);

