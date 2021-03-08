// ENDOTHELIAL:
// Endothelial sonification is a combination of the fibroblast granulator with a sound file loaded into memory and a vocoder that convolves
// grains with a saw wave. It uses high pitches
//
// fibroblast args:
// arg out, trig, texture_speed, dur=15, amp=1.0, buf, bufnum= -1, grain_pb_rate_val=1.0, pos_change_rate=1.0, grain_size;
// EXAMPLE:
// Synth(\fibroblasts, [\out, 95, \trig, 1, \buf, ~endothelial_buffer, \grain_size, 1, \grain_pb_rate_val, 17, \pos_change_rate, 13, \texture_speed, 12, \amp, 0.3]);
//
// Endothelial vocoder args:
// arg input, out, dur=15, amp=1.0, attack=0.01, texture_dur=0.5, texture_speed=3, freq=0, trig;
// EXAMPLE:
// Synth(\endothelial_vocoder, [\input, [94,95], \out, 0, \trig, 1, \freq, 24.midicps, \texture_dur, 1, \amp, 10, \texture_speed, 4]);

(
var stream_length, subdiv;
stream_length = 120;
subdiv = stream_length/4;

~fibroblast_endothelial_grain_size = Pseq([
	Prand(List.fill(5, {arg i; 0.75+(i*0.1)}), subdiv), // development
	Prand(List.fill(5, {arg i; 0.75+(i*0.5)}), subdiv), // response
	Prand(List.fill(5, {arg i; 0.75+(i*0.25)}), subdiv), // peptide biosynthesis
	Prand(List.fill(5, {arg i; 0.75+(i*0.25)}), subdiv), // peptide biosynthesis
	],
1).asStream;

~fibroblast_endothelial_texture_speed = Pseq([
	Prand(List.fill(2, {arg i; 12+(i*6)}), subdiv), // development
	Prand(List.fill(5, {arg i; 12+(i*24)}), subdiv), // response
	Prand(List.fill(5, {arg i; 12+(i*12)}), subdiv), // peptide biosynthesis
	Prand(List.fill(5, {arg i; 12+(i*12)}), subdiv), // peptide biosynthesis
],
1).asStream;

~fibroblast_endothelial_amp = Pseq([
	Prand(List.fill(4, {arg i; 0.2+(i*0.01)}), subdiv), // development
	Prand(List.fill(4, {arg i; 0.3+(i*0.01)}), subdiv), // response
	Prand(List.fill(4, {arg i; 0.2+(i*0.02)}), subdiv), // peptide biosynthesis
	Prand(List.fill(4, {arg i; 0.2+(i*0.02)}), subdiv), // peptide biosynthesis
	],
1).asStream;

~endothelial_vocoder_pitches = Pseq([
	Prand([72, 76, 79, 83].midicps, subdiv), // development
	Prand([60, 62, 64, 68, 70].midicps, subdiv), // response
	Prand([59, 64, 67, 71, 74].midicps, subdiv), // peptide biosynthesis
	Prand([59, 64, 67, 71, 74].midicps, subdiv), // peptide biosynthesis
],
1).asStream;

~endothelial_texture_speed = Pseq([
	Prand(List.fill(4, {arg i; (i+1)*0.7}), subdiv), // development
	Prand(List.fill(4, {arg i; (i+1)*1.2}), subdiv), // response
	Prand(List.fill(4, {arg i; (i+1)}), subdiv), // peptide biosynthesis
	Prand(List.fill(4, {arg i; (i+1)}), subdiv), // peptide biosynthesis
],
1).asStream;

~endothelial_texture_dur = Prand(List.fill(5, {arg i; 0.8+(i*0.1)}), stream_length).asStream;
~endothelial_amp = Prand(List.fill(2, {arg i; 2+i}), stream_length).asStream;
~endothelial_attack = Prand([0.01, 0.1, 0.4, 0.01, 0.01, 0.05], stream_length).asStream;

Routine({
	// BE SURE TO CHECK INS AND OUTS SO THAT THERE ARE NO CONFLICTS
	~endothelial = Array.fill(3, {
		arg i;
		Synth(\pericyte_vocoder, [
			\out, 0,
			\input, [80-(i*2), 81-(i*2)],
			\trig, 1,
			\freq, ~endothelial_vocoder_pitches,
			\texture_dur, ~endothelial_texture_speed,
			\texture_speed, ~endothelial_texture_dur,
			\amp, ~endothelial_amp,
			\attack, ~endothelial_attack,
			\dur, 120
		]);
	});
	~endothelial_input = Array.fill(3, {
		arg i;
		Synth(\fibroblasts, [
			\out, 81-(i*2),
			\trig, 1,
			\buf, ~endothelial_buffer,
			\grain_size, ~fibroblast_endothelial_grain_size,
			\grain_pb_rate_val, 3,
			\post_change_rate, 4,
			\texture_speed, ~fibroblast_endothelial_texture_speed,
			\amp, ~fibroblast_endothelial_amp,
			\dur, 120
		]);
	});

	3.wait;
	(stream_length/10).do {
		(stream_length/4).do {
			~endothelial.do({
				arg item, index;
				item.set(
					\trig, 1,
					\freq, ~endothelial_vocoder_pitches,
					\texture_dur, ~endothelial_texture_speed,
					\texture_speed, ~endothelial_texture_dur,
					\amp, ~endothelial_amp,
					\attack, ~endothelial_attack
				);
			});
			~endothelial_input.do({
				arg item, index;
				item.set(
					\trig, 1,
					\buf, ~endothelial_buffer,
					\grain_size, ~fibroblast_endothelial_grain_size,
					\texture_speed, ~fibroblast_endothelial_texture_speed,
					\amp, ~fibroblast_endothelial_amp
				);
			});
			3.wait;
		};
	};
}).play;
)