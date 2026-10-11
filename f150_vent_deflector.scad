// 2015-2025 Ford F-150 Rear Console A/C Vent Deflector
// Parametric configuration

/* [Dimensions] */
// Width of the factory vent opening (measure the inside lip)
vent_width = 75.0;

// Height of the factory vent opening
vent_height = 45.0;

// How deep the friction-fit sleeve goes into the vent
insert_depth = 15.0;

// Wall thickness of the printed part
wall_thickness = 2.0;

// Angle of the upward scoop (Degrees)
scoop_angle = 40.0;

// How far the scoop extends out from the console
scoop_length = 45.0;

/* [Hidden] */
$fn = 60;

module deflector() {
    difference() {
        // --- OUTER SHELL ---
        union() {
            // 1. The straight insert (slides into the console)
            translate([-vent_width/2, -vent_height/2, 0])
                cube([vent_width, vent_height, insert_depth]);

            // 2. The angled scoop (Smoothly hulls from the insert to the new angle)
            hull() {
                // Base of the scoop (matches the end of the insert)
                translate([-vent_width/2, -vent_height/2, insert_depth - 0.1])
                    cube([vent_width, vent_height, 0.1]);

                // Top of the scoop (rotated upward)
                translate([0, 0, insert_depth])
                    rotate([-scoop_angle, 0, 0])
                    translate([-vent_width/2, -vent_height/2, scoop_length])
                    cube([vent_width, vent_height, 0.1]);
            }
        }

        // --- INNER SHELL SUBTRACTION (Hollows it out) ---
        union() {
            // 3. Hollow out the straight insert
            translate([-(vent_width - 2*wall_thickness)/2, -(vent_height - 2*wall_thickness)/2, -1])
                cube([vent_width - 2*wall_thickness, vent_height - 2*wall_thickness, insert_depth + 1.1]);

            // 4. Hollow out the angled scoop
            hull() {
                translate([-(vent_width - 2*wall_thickness)/2, -(vent_height - 2*wall_thickness)/2, insert_depth - 0.1])
                    cube([vent_width - 2*wall_thickness, vent_height - 2*wall_thickness, 0.1]);

                translate([0, 0, insert_depth])
                    rotate([-scoop_angle, 0, 0])
                    translate([-(vent_width - 2*wall_thickness)/2, -(vent_height - 2*wall_thickness)/2, scoop_length + 1])
                    cube([vent_width - 2*wall_thickness, vent_height - 2*wall_thickness, 0.1]);
            }
        }
    }
}

// Generate the part (Sitting flat on the insert base for support-free printing)
deflector();
