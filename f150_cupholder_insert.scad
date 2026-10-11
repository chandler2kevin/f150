// 2015-2025 Ford F-150 Oversized Cup Holder Insert
// Parametric configuration

/* [Dimensions] */
// Outer diameter of the lower section (fits into the truck's cup holder)
// FLAG: Measure your truck! Rubber liner in = ~81mm. Liner missing = ~86mm.
lower_od = 81.0;

// Depth of the lower section
lower_depth = 60.0;

// Inner diameter of the top section (fits the Yeti/HydroFlask)
// 36oz Yeti is ~95mm. 98mm leaves room for felt tape lining.
upper_id = 98.0;

// Depth of the top section (keeps heavy bottles from tipping)
upper_depth = 65.0;

// Wall thickness
wall_thickness = 3.0;

// Width of the slot for coffee mug handles (set to 0 to remove slot)
handle_slot_width = 28.0;

// Height of the angled transition between lower and upper sections
transition_height = 15.0;

/* [Hidden] */
$fn = 120; // High resolution for smooth curves

module cup_holder() {
    upper_od = upper_id + (2 * wall_thickness);
    lower_id = lower_od - (2 * wall_thickness);

    difference() {
        // --- OUTER SHELL ---
        union() {
            // Lower cylinder
            cylinder(h=lower_depth, d=lower_od);

            // Transition cone
            translate([0, 0, lower_depth])
                cylinder(h=transition_height, d1=lower_od, d2=upper_od);

            // Upper cylinder
            translate([0, 0, lower_depth + transition_height])
                cylinder(h=upper_depth, d=upper_od);
        }

        // --- INNER SHELL (SUBTRACTION) ---
        union() {
            // Inner lower cylinder
            translate([0, 0, wall_thickness])
                cylinder(h=lower_depth, d=lower_id);

            // Inner transition cone
            translate([0, 0, lower_depth])
                cylinder(h=transition_height, d1=lower_id, d2=upper_id);

            // Inner upper cylinder
            translate([0, 0, lower_depth + transition_height - 0.1])
                cylinder(h=upper_depth + 1, d=upper_id);
        }

        // --- MUG HANDLE SLOT ---
        if (handle_slot_width > 0) {
            // Cut a vertical slot down the side of the upper section
            translate([upper_id/2 - 10, -handle_slot_width/2, lower_depth + transition_height])
                cube([upper_od, handle_slot_width, upper_depth + 1]);
        }
    }
}

// Generate the part (Standing upright)
cup_holder();
