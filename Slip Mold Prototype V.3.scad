//This is where the part with the hole begins
$fn=100;
render(convexity=100)
union(){
difference(){
    difference(){
        difference(){
                translate([0,0,2.5])
                difference(){
                   
                    cylinder(5,3,3, center=true);
                    cylinder(5,1, center=true);
                            }
                difference(){
                    rotate_extrude(convexity = 15)
                    translate([2, 0, 0])
                    circle(r = 0.75);
                            }
                    }
     translate([0,0,2])
     cube([3,3,5],center=false);
    }
//Pour hole
translate([1.5,1.5,0])
cylinder(3,0.125,0.125, center=false);    
}
}
//This is where the part with the hole ends and the remaining half begins
render(convexity=100)
rotate(a=180,180,180)
translate([0,0,-5])
union(){
        difference(){
        difference(){
                translate([0,0,2.5])
                difference(){
                    cylinder(5,3,3, center=true);
                    cylinder(5,1, center=true);
                            }
                difference(){
                    rotate_extrude(convexity = 15)
                    translate([2, 0, 0])
                    circle(r = 0.75);
                            }
                    }
     translate([0,0,2])
     cube([3,3,5],center=false);
    }
//Connector
        cylinder(10,1, center=true);
}
//This is where the central element is created
