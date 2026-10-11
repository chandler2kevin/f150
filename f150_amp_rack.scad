// 2015-2025 Ford F-150 Behind-Seat Modular Amp Rack
// Parametric configuration

/* [Dimensions] */
// Overall width of the rack plate
plate_width = 220.0;

// Overall height of the rack plate
plate_height = 200.0;

// Thickness of the plastic board (needs to hold self-tapping screws)
plate_thickness = 8.0;

// Size of the square grid cutouts for zip-ties and weight reduction
grid_size = 20.0;

// Thickness of the solid plastic webbing between grid holes
webbing_thickness = 8.0;

// Distance between the factory mounting bolts on the X axis
mount_hole_spacing_x = 180.0;

// Distance between the factory mounting bolts on the Y axis
mount_hole_spacing_y = 160.0;

// Diameter of the factory bolts passing through the rack
bolt_dia = 8.5;

// Standoff height to keep the plate off the truck's ribbed metal wall
standoff_height = 15.0;

// Diameter of the standoff pillars
standoff_dia = 25.0;

/* [Hidden] */
$fn = 60;

module amp_rack() {
    difference() {
        // --- ADDITIVE GEOMETRY ---
        union() {
            // 1. The Main Plate
            cube([plate_width, plate_height, plate_thickness]);

            // 2. The Mounting Standoffs (4 corners based on hole spacing)
            for (x = [(plate_width/2 - mount_hole_spacing_x/2), (plate_width/2 + mount_hole_spacing_x/2)]) {
                for (y = [(plate_height/2 - mount_hole_spacing_y/2), (plate_height/2 + mount_hole_spacing_y/2)]) {
                    translate([x, y, plate_thickness])
                        cylinder(h=standoff_height, d=standoff_dia);
                }
            }
        }

        // --- SUBTRACTIVE GEOMETRY ---
        union() {
            // 3. Grid Cutouts
            // Calculate how many holes fit based on size and webbing
            num_x = floor(plate_width / (grid_size + webbing_thickness));
            num_y = floor(plate_height / (grid_size + webbing_thickness));

            // Offset to center the grid on the plate
            offset_x = (plate_width - (num_x * grid_size + (num_x - 1) * webbing_thickness)) / 2;
            offset_y = (plate_height - (num_y * grid_size + (num_y - 1) * webbing_thickness)) / 2;

            for (i = [0 : num_x - 1]) {
                for (j = [0 : num_y - 1]) {
                    // Position each cutout
                    cx = offset_x + i * (grid_size + webbing_thickness);
                    cy = offset_y + j * (grid_size + webbing_thickness);

                    // Punch the hole through the plate
                    translate([cx, cy, -1])
                        cube([grid_size, grid_size, plate_thickness + 2]);
                }
            }

            // 4. Mounting Bolt Holes (drilled through the standoffs and plate)
            for (x = [(plate_width/2 - mount_hole_spacing_x/2), (plate_width/2 + mount_hole_spacing_x/2)]) {
                for (y = [(plate_height/2 - mount_hole_spacing_y/2), (plate_height/2 + mount_hole_spacing_y/2)]) {
                    translate([x, y, -1])
                        cylinder(h=plate_thickness + standoff_height + 2, d=bolt_dia);
                }
            }
        }
    }
}

// Generate the part (Printed flat on its face, standoffs pointing up)
amp_rack();
