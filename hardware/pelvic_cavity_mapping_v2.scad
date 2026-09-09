// ====================================================================
// DESIGN STANDARDS: RT Biomedical Spatial Infrastructure Block
// Dynamic JSON Data Parameter Integration Variant
// ====================================================================

$fn = 100;

// Read config parameters dynamically from the external JSON netlist
config = read_json("pelvic_dimensions.json");

// Extract dimensional constants from the mapped config structure
pelvic_ring_diam_x = config.pelvic_ring.diam_x;
pelvic_ring_diam_y = config.pelvic_ring.diam_y;
pelvic_wall_height = config.pelvic_ring.wall_height;

module structural_pelvic_girdle() {
    color("GhostWhite", 0.3) {
        difference() {
            ellipse_tube(pelvic_ring_diam_x + 10, pelvic_ring_diam_y + 10, pelvic_wall_height);
            ellipse_tube(pelvic_ring_diam_x, pelvic_ring_diam_y, pelvic_wall_height + 2);
        }
    }
}

module internal_organ_clearance_matrix() {
    // 1. Anterior Compartment: Urinary Bladder Clearance Field
    translate([0, -(pelvic_ring_diam_y / 3), -5]) {
        color("Khaki", 0.7)
            scale([1.1, 1.3, 1.0])
                sphere(r = config.organ_offsets.bladder_radius);
    }
    
    // 2. Central Compartment: Reproductive Cavity Boundary Matrix
    translate([0, 0, 0]) {
        color("LightPink", 0.8) {
            cylinder(h = config.organ_offsets.reproductive_height, r1 = 8.0, r2 = 18.0, center = true);
            translate([0, 0, config.organ_offsets.reproductive_height / 2])
                sphere(r = 18.0);
        }
    }
    
    // 3. Posterior Compartment: Lower Digestive Tract (Rectal Corridor)
    translate([0, (pelvic_ring_diam_y / 2.8), 0]) {
        color("BurlyWood", 0.7)
            rotate([12, 0, 0])
                cylinder(h = pelvic_wall_height + 10, r = config.organ_offsets.rectal_radius, center = true);
    }
}

module ellipse_tube(r1_x, r2_y, height) {
    scale([r1_x / r2_y, 1, 1])
        cylinder(h = height, r = r2_y / 2, center = true);
}

// Render Geometry
union() {
    structural_pelvic_girdle();
    internal_organ_clearance_matrix();
}
