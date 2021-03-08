(
s = Server.default;
s.options.outDevice = "multi_output_scarlett";
s.waitForBoot({
	thisProcess.interpreter.executeFile("/Users/ericlemmon/Desktop/VPL_Sonification_Project/project_files/synth_defs.scd");


	// #################
	// Initialize reverb and load buffers.
	// #################
	// Reverbs
	Synth(\reverb1, [\output, 0, \room, 1, \damp, 1, \mix, 0.5, \amp, 0.5, \input, 99]);
	Synth(\reverb1, [\output, 0, \room, 0.4, \damp, 1, \mix, 0.5, \amp, 0.5, \input, 98]);

	// Buffers
	~fibroblast_path = PathName.new(path: "/Users/ericlemmon/Desktop/VPL_Sonification_Project/Samples/samples/VPL_Sonification_Project_Samples.wav");
	~endothelial_path = PathName.new("/Users/ericlemmon/Desktop/VPL_Sonification_Project/Samples/samples/VPL_Sonification_Project_Samples-001.wav");
	~grain_buffer = Buffer.readChannel(s, ~fibroblast_path.fullPath, channels: 1);
	~endothelial_buffer = Buffer.readChannel(s, ~endothelial_path.fullPath, channels: 1);
});
)

// #################
// Processes start here.
// #################
(
// Neuron-like cells
// -----------------
// NEURONS:
thisProcess.interpreter.executeFile("/Users/ericlemmon/Desktop/VPL_Sonification_Project/project_files/cell_types/neurons.scd");

// ASTROCYTES:
thisProcess.interpreter.executeFile("/Users/ericlemmon/Desktop/VPL_Sonification_Project/project_files/cell_types/astrocytes.scd");

// EPENDYMAL:
thisProcess.interpreter.executeFile("/Users/ericlemmon/Desktop/VPL_Sonification_Project/project_files/cell_types/ependymal.scd");

// #################

// Endothelial and Pericyte cells
// ------------------------------
// ENDOTHELIAL:
thisProcess.interpreter.executeFile("/Users/ericlemmon/Desktop/VPL_Sonification_Project/project_files/cell_types/endothelial.scd");

// PERICYTES:
thisProcess.interpreter.executeFile("/Users/ericlemmon/Desktop/VPL_Sonification_Project/project_files/cell_types/pericytes.scd");

// #################

// Fibroblast cells
// ------------------------------
// FIBROBLASTS:
thisProcess.interpreter.executeFile("/Users/ericlemmon/Desktop/VPL_Sonification_Project/project_files/cell_types/fibroblasts.scd");

// #################

// Oligodendrocytes & OPCS
// ------------------------------
// OPCS:
thisProcess.interpreter.executeFile("/Users/ericlemmon/Desktop/VPL_Sonification_Project/project_files/cell_types/opc.scd");

// OLIGODENDROCYTES:
thisProcess.interpreter.executeFile("/Users/ericlemmon/Desktop/VPL_Sonification_Project/project_files/cell_types/opc.scd");

// #################

// Immune Cells
// ------------------------------
// MACROPHAGES
thisProcess.interpreter.executeFile("/Users/ericlemmon/Desktop/VPL_Sonification_Project/project_files/cell_types/macrophages.scd");

// MONOCYTES
thisProcess.interpreter.executeFile("/Users/ericlemmon/Desktop/VPL_Sonification_Project/project_files/cell_types/monocytes.scd");

// MICROGLIA
thisProcess.interpreter.executeFile("/Users/ericlemmon/Desktop/VPL_Sonification_Project/project_files/cell_types/microglia.scd");
)