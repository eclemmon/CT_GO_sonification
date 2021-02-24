
s = Server.default;
s.options.outDevice = "multi_output_scarlett";
s.waitForBoot({
		thisProcess.interpreter.executeFile("/Users/ericlemmon/Desktop/VPL_Sonification_Project/project_files/synth_defs.scd");
});

(
// #################
// Initialize reverb and load buffers.
// #################
// Reverbs
Synth(\reverb1, [\output, 0, \room, 1, \damp, 1, \mix, 0.5, \amp, 0.5, \input, 99]);
Synth(\reverb1, [\output, 0, \room, 0.4, \damp, 1, \mix, 0.5, \amp, 0.5, \input, 98]);

// Buffers
~fibroblast_path = PathName.new(path: "/Users/ericlemmon/Desktop/VPL_Sonification_Project/Samples/final_samples/VPL_Sonification_Project_Samples.wav");
~endothelial_path = PathName.new("/Users/ericlemmon/Desktop/VPL_Sonification_Project/Samples/final_samples/VPL_Sonification_Project_Samples-001.wav");
~grain_buffer = Buffer.readChannel(s, ~fibroblast_path.fullPath, channels: 1);
~endothelial_buffer = Buffer.readChannel(s, ~endothelial_path.fullPath, channels: 1);
)

// #################
// Processes start here.
// #################

// Neuron-like cells
// -----------------
// NEURONS:
thisProcess.interpreter.executeFile("/Users/ericlemmon/Desktop/VPL_Sonification_Project/project_files/neurons.scd");

// ASTROCYTES:
thisProcess.interpreter.executeFile("/Users/ericlemmon/Desktop/VPL_Sonification_Project/project_files/astrocytes.scd");

// EPENDYMAL:
thisProcess.interpreter.executeFile("/Users/ericlemmon/Desktop/VPL_Sonification_Project/project_files/ependymal.scd");

// #################

// Endothelial and Pericyte cells
// ------------------------------
// ENDOTHELIAL:
thisProcess.interpreter.executeFile("/Users/ericlemmon/Desktop/VPL_Sonification_Project/project_files/endothelial.scd");

// PERICYTES:
thisProcess.interpreter.executeFile("/Users/ericlemmon/Desktop/VPL_Sonification_Project/project_files/pericytes.scd");

// #################

// Fibroblast cells
// ------------------------------
// FIBROBLASTS:
thisProcess.interpreter.executeFile("/Users/ericlemmon/Desktop/VPL_Sonification_Project/project_files/fibroblasts.scd");

// #################

// Oligodendracytes & OPCS
// ------------------------------
// OPCS:
thisProcess.interpreter.executeFile("/Users/ericlemmon/Desktop/VPL_Sonification_Project/project_files/opc.scd");

(
// Oligodendracytes & OPCS
//arg out=0, dur=15, amp, attack=0.1, release=0.1, decay_time=0.1, decay_amp=0.7, freq=440, fmod_freq=533, fmod_mul=200, sustain_freq=660, pos=0, trig=0, filter_env_start_freq=880, filter_env_end_freq=440, filter_sus_dur=15, filter_decay_dur=0.1, filter_release_time=0.1;
Synth(\OPC, [\amp, 0.1, \trig, 1.0, \fmod_freq, 24.midicps, \freq, 60.midicps, \dur, 15, \attack, 0.02, \decay_time, 0.3, \decay_amp, 0.1, \release, 0.05, \out, 0, \pos, 0, \filter_release_time, 4]);
Synth(\Oligodendrocytes, [\amp, 0.2, \trig, 1.0, \fmod_freq, 60.midicps, \freq, 36.midicps, \dur, 15, \attack, 0.02, \decay_time, 0.3, \decay_amp, 0.1, \release, 0.05, \out, 99, \pos, 0]);
)

(
// Immune Cells
~macrophages = Group.new;
Array.fill(20, {arg i; Synth(\macrophages, [\out, 0, \amp, 0.2, \filter_freq, i*100+40, \trig, 1, \texture_dur, 0.5, \attack, 0.01, \rq, 0.1, \pan, i/5], ~macrophages, \addToHead)});
~monocytes = Group.new;
Array.fill(20, {arg i; Synth(\macrophages, [\out, 0, \amp, 0.02, \filter_freq, i*533+40, \trig, 1, \texture_dur, 0.2, \rq, 0.2, \pan, i/5], ~monocytes, \addToHead)});
~microglia = Group.new;
Array.fill(5, {arg i; Synth(\macrophages, [\out, 0, \amp, 0.02, \filter_freq, (i*7+60).midicps, \trig, 1, \texture_dur, 2, \texture_speed, 1, \attack, 0.01, \rq, 0.001, \pan, i/5], ~microglia, \addToHead)});
)