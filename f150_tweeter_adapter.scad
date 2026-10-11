// 2015-2025 Ford F-150 A-Pillar Tweeter Adapter
// Parametric configuration

/* [Dimensions] */
// Inner diameter to fit the aftermarket tweeter housing
tweeter_id = 45.0;

// Depth of the ring holding the tweeter
tweeter_depth = 15.0;

// Distance between the factory A-pillar mounting posts
mount_spread = 65.0;

// Diameter of the factory screws
mount_hole_dia = 4.5;

// Wall thickness
wall_thickness = 3.0;

// Thickness of the mounting tabs
tab_thickness = 4.0;

/* [Hidden] */
$fn = 100;

module tweeter_bracket() {
    outer_dia = tweeter_id + (2 * wall_thickness);

    difference() {
        // --- ADDITIVE GEOMETRY ---
        union() {
            // 1. The main housing ring
            cylinder(h=tweeter_depth, d=outer_dia);

            // 2. The mounting ears (hulled from the center)
            hull() {
                cylinder(h=tab_thickness, d=outer_dia);

                // Left mounting ear
                translate([-mount_spread/2, 0, 0])
                    cylinder(h=tab_thickness, d=12.0);

                // Right mounting ear
                translate([mount_spread/2, 0, 0])
                    cylinder(h=tab_thickness, d=12.0);
            }
        }

        // --- SUBTRACTIVE GEOMETRY ---
        union() {
            // 3. Center cutout for the tweeter body
            translate([0, 0, -1])
                cylinder(h=tweeter_depth + 2, d=tweeter_id);

            // 4. Left mounting hole
            translate([-mount_spread/2, 0, -1])
                cylinder(h=tab_thickness + 2, d=mount_hole_dia);

            // 5. Right mounting hole
            translate([mount_spread/2, 0, -1])
                cylinder(h=tab_thickness + 2, d=mount_hole_dia);
        }
    }
}

// Generate the part (Printed flat on its mounting tabs)
tweeter_bracket();
