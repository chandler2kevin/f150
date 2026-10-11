// 2015-2020 Ford F-150 Coin Holder MagSafe Mount
// Parametric configuration

/* [Dimensions] */
// Diameter of the cylinder that inserts into the dash. Print a test ring first!
insert_dia = 37.5;

// How deep the plug goes into the dashboard
insert_depth = 25.0;

// Outer diameter of the visible face plate
face_dia = 62.0;

// Thickness of the face plate holding the MagSafe puck
face_thickness = 8.0;

// Diameter of the MagSafe puck (Apple OEM is 55.9mm)
magsafe_dia = 56.5;

// How deep the MagSafe puck sits inside the face
magsafe_depth = 5.5;

// Width of the slot for the charging cable to pass through
cable_slot_width = 6.5;

/* [Hidden] */
$fn = 120; // High resolution for smooth friction fit

module magsafe_mount() {
    difference() {
        // --- ADDITIVE GEOMETRY ---
        union() {
            // 1. The Insert Plug (goes into the dash)
            cylinder(h=insert_depth, d=insert_dia);

            // 2. The Face Plate (sits outside the dash)
            translate([0, 0, insert_depth])
                cylinder(h=face_thickness, d=face_dia);
        }

        // --- SUBTRACTIVE GEOMETRY (CUTOUTS) ---

        // 3. MagSafe Puck Recess Cutout
        // Cut from the top down into the face plate
        translate([0, 0, insert_depth + face_thickness - magsafe_depth])
            cylinder(h=magsafe_depth + 1, d=magsafe_dia);

        // 4. Cable Routing Slot Cutout
        // Cuts a channel from the center of the MagSafe down through the bottom lip
        translate([-cable_slot_width/2, 0, insert_depth + face_thickness - magsafe_depth])
            cube([cable_slot_width, face_dia/2 + 1, magsafe_depth + 1]);

        // 5. Center wire push-hole
        // Allows you to poke the MagSafe puck out from the back if you need to remove it
        translate([0, 0, -1])
            cylinder(h=insert_depth + face_thickness + 2, d=15);
    }
}

// Generate the part
// Rotate face-down for printing without supports
rotate([180, 0, 0])
    magsafe_mount();
