// 2015-2025 Ford F-150 Under-Seat Floor Vent Extender
// Parametric configuration

/* [Dimensions] */
// OUTER width of the factory under-seat vent (measure your truck)
vent_od_width = 110.0;

// OUTER height of the factory under-seat vent
vent_od_height = 18.0;

// How far the adapter slides over the factory vent
sleeve_depth = 25.0;

// Wall thickness of the printed part
wall_thickness = 2.0;

// How far the duct extends backward (150mm = 6", 225mm = 9")
extension_len = 150.0;

// Angle upward to clear thick rubber floor mats
lift_angle = 15.0;

/* [Hidden] */
$fn = 60;

module floor_extender() {
    difference() {
        // --- OUTER SHELL ---
        union() {
            // 1. The straight sleeve (slides OVER the factory vent)
            translate([-vent_od_width/2 - wall_thickness, -vent_od_height/2 - wall_thickness, 0])
                cube([vent_od_width + 2*wall_thickness, vent_od_height + 2*wall_thickness, sleeve_depth]);

            // 2. The extended duct (angled upward)
            hull() {
                translate([-vent_od_width/2 - wall_thickness, -vent_od_height/2 - wall_thickness, sleeve_depth - 0.1])
                    cube([vent_od_width + 2*wall_thickness, vent_od_height + 2*wall_thickness, 0.1]);

                translate([0, 0, sleeve_depth])
                    rotate([lift_angle, 0, 0])
                    translate([-vent_od_width/2 - wall_thickness, -vent_od_height/2 - wall_thickness, extension_len])
                    cube([vent_od_width + 2*wall_thickness, vent_od_height + 2*wall_thickness, 0.1]);
            }
        }

        // --- INNER SHELL SUBTRACTION (Hollows it out) ---
        union() {
            // 3. Hollow out the straight sleeve (matches factory vent OD)
            translate([-vent_od_width/2, -vent_od_height/2, -1])
                cube([vent_od_width, vent_od_height, sleeve_depth + 1.1]);

            // 4. Hollow out the extended duct
            hull() {
                translate([-vent_od_width/2, -vent_od_height/2, sleeve_depth - 0.1])
                    cube([vent_od_width, vent_od_height, 0.1]);

                translate([0, 0, sleeve_depth])
                    rotate([lift_angle, 0, 0])
                    translate([-vent_od_width/2, -vent_od_height/2, extension_len + 1])
                    cube([vent_od_width, vent_od_height, 0.1]);
            }
        }
    }
}

// Generate the part (Standing vertically on the sleeve opening)
floor_extender();
