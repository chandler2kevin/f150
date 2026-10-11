// 2015-2025 Ford F-150 Front Door 6.5" Speaker Adapter
// Parametric configuration

/* [Dimensions] */
// The standoff depth (height) of the adapter. Adjust for window clearance.
baffle_height = 19.05; // [10:0.1:40]

// Inner diameter cutout for the 6.5" speaker basket
speaker_cutout_id = 144;

// Bolt circle diameter for the 6.5" speaker mounting screws
speaker_bcd = 156;

// Diameter of the screws holding the speaker
speaker_screw_dia = 3.5;

// Diameter of the countersink for flush screw heads
speaker_countersink_dia = 7.5;

// Depth of the countersink
countersink_depth = 3.0;

// Factory F-150 Bolt Hole Coordinates (Relative to center)
// WARNING: Verify these against your specific trim (Base 6x9 vs B&O 8")
// Format: [X, Y]
factory_holes = [
    [-85, 110],  // Top Left
    [85, 110],   // Top Right
    [-75, -100], // Bottom Left
    [75, -100]   // Bottom Right
];

factory_screw_dia = 6.0;

/* [Hidden] */
$fn = 100; // High resolution for smooth circles

module adapter_plate() {
    difference() {
        // Base Adapter Body (Matches roughly 6x9 Ford footprint)
        hull() {
            for (pt = factory_holes) {
                translate([pt[0], pt[1], 0]) cylinder(h=baffle_height, d=20);
            }
            // Ensure center is thick enough for the 6.5" ring
            cylinder(h=baffle_height, d=speaker_bcd + 20);
        }

        // 1. Center Cutout for the Speaker Basket
        translate([0, 0, -1])
            cylinder(h=baffle_height + 2, d=speaker_cutout_id);

        // 2. Factory Mounting Holes (to bolt adapter to the door)
        for (pt = factory_holes) {
            translate([pt[0], pt[1], -1])
                cylinder(h=baffle_height + 2, d=factory_screw_dia);
        }

        // 3. Aftermarket Speaker Mounting Holes with Countersinks (8 holes for flexibility)
        for (i = [0 : 45 : 359]) {
            rotate([0, 0, i]) {
                // The screw shaft hole
                translate([speaker_bcd/2, 0, -1])
                    cylinder(h=baffle_height + 2, d=speaker_screw_dia);

                // The countersink for the screw head (cut from the top down)
                translate([speaker_bcd/2, 0, baffle_height - countersink_depth])
                    cylinder(h=countersink_depth + 1, d=speaker_countersink_dia);
            }
        }
    }
}

// Generate the part
adapter_plate();
