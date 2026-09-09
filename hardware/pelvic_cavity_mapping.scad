// ====================================================================
// DESIGN STANDARDS: RT Biomedical Spatial Infrastructure Block
// Modeling Pelvic Cavity Clearance Boundaries and Organ Symmetry Paths
// ====================================================================

$fn = 100; // Enforce smooth geometry for curved organ boundary fields

// Parametric Dimensional Coordinates (All metrics in millimeters)
pelvic_ring_diam_x = 135.0; // Lateral width of pelvic inlet
pelvic_ring_diam_y = 115.0; // Anteroposterior depth of pelvic inlet
pelvic_wall_height = 50.0;

module structural_pelvic_girdle() {
    // Models the rigid skeletal boundary envelope
    color("GhostWhite", 0.3) {
        difference() {
            ellipse_tube(pelvic_ring_diam_x + 10, pelvic_ring_diam_y + 10, pelvic_wall_height);
            ellipse_tube(pelvic_ring_diam_x, pelvic_ring_diam_y, pelvic_wall_height + 2);
        }
    }
}

module internal_organ_clearance_matrix() {
    // Midline Symmetry Track Reference (Y-axis centerline at X=0)
    
    // 1. Anterior Compartment: Urinary Bladder Clearance Field
    translate([0, -(pelvic_ring_diam_y / 3), -5]) {
        color("Khaki", 0.7)
            scale([1.1, 1.3, 1.0])
                sphere(r = 24.0);
    }
    
    // 2. Central Compartment: Reproductive Cavity Boundary Matrix
    translate([0, 0, 5]) {
        color("LightPink", 0.8) {
            // Symmetrical inverted pear-shaped modeling envelope
            cylinder(h = 35.0, r1 = 8.0, r2 = 18.0, center = true);
            translate([0, 0, 17.5])
                sphere(r = 18.0);
        }
    }
    
    // 3. Posterior Compartment: Lower Digestive Tract (Rectal Corridor)
    translate([0, (pelvic_ring_diam_y / 2.8), 0]) {
        color("BurlyWood", 0.7)
            rotate([8, 0, 0]) // Natural anatomical curvature tilt
                cylinder(h = pelvic_wall_height + 10, r = 16.0, center = true);
    }
}

module ellipse_tube(r1_x, r2_y, height) {
    // Helper module to generate elliptical boundary tracking rings
    scale([r1_x / r2_y, 1, 1])
        cylinder(h = height, r = r2_y / 2, center = true);
}

// System Compilation Assembly
union() {
    structural_pelvic_girdle();
    internal_organ_clearance_matrix();
}
