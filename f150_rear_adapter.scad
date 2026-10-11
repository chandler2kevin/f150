// 2015-2025 Ford F-150 REAR Door (SuperCrew) 6.5" Speaker Adapter
// Parametric configuration

/* [Dimensions] */
// The standoff depth (height) of the adapter.
// FLAG: Rear doors have tighter clearance than fronts! Test window roll-down.
baffle_height = 15.0; // [10:0.1:40]

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

// Factory F-150 REAR Door Bolt Hole Coordinates (Relative to center)
// WARNING: Measure your rear door's 3-hole pattern and update these offsets.
// Format: [X, Y]
factory_holes = [
    [0, 80],     // Top mounting hole
    [-70, -40],  // Bottom Left hole
    [70, -40]    // Bottom Right hole
];

factory_screw_dia = 6.0;

/* [Hidden] */
$fn = 100; // High resolution for smooth circles

module rear_adapter_plate() {
    difference() {
        // Base Adapter Body (Hulls the 3 factory ears to the center ring)
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
rear_adapter_plate();
