// PERICYTES:
// Pericyte sonification is a combination of the fibroblast granulator with a sound file loaded into memory and a vocoder that convolves
// grains with a saw wave. It uses low pitches.
//
// fibroblast args:
// arg out, trig, texture_speed, dur=15, amp=1.0, buf, bufnum= -1, grain_pb_rate_val=1.0, pos_change_rate=1.0, grain_size;
// EXAMPLE:
// Synth(\fibroblasts, [\out, 95, \trig, 1, \buf, ~endothelial_buffer, \grain_size, 1, \grain_pb_rate_val, 17, \pos_change_rate, 13, \texture_speed, 12, \amp, 0.3]);
//
// pericyte vocoder args:
// arg input, out, dur=15, amp=1.0, attack=0.01, texture_dur=0.5, texture_speed=3, freq=0, trig;
// EXAMPLE:
// Synth(\pericyte_vocoder, [\input, [94,95], \out, 0, \trig, 1, \freq, 24.midicps, \texture_dur, 1, \amp, 10, \texture_speed, 4]);

(
var stream_length, subdiv;
stream_length = 120;
subdiv = stream_length/4;

~fibroblast_pericyte_grain_size = Pseq([
	Prand(List.fill(5, {arg i; 0.75+(i*0.1)}), subdiv), // development
	Prand(List.fill(5, {arg i; 0.75+(i*0.1)}), subdiv), // development
	Prand(List.fill(5, {arg i; 0.75+(i*0.25)}), subdiv), // peptide biosynthesis
	Prand(List.fill(5, {arg i; 0.75+(i*0.25)}), subdiv), // peptide biosynthesis
	],
1).asStream;

~fibroblast_pericyte_texture_speed = Pseq([
	Prand(List.fill(2, {arg i; 12+(i*6)}), subdiv), // development
	Prand(List.fill(5, {arg i; 12+(i*6)}), subdiv), // development
	Prand(List.fill(5, {arg i; 12+(i*12)}), subdiv), // peptide biosynthesis
	Prand(List.fill(5, {arg i; 12+(i*12)}), subdiv), // peptide biosynthesis
],
1).asStream;

~fibroblast_pericyte_amp = Pseq([
	Prand(List.fill(4, {arg i; 0.3+(i*0.01)}), subdiv), // development
	Prand(List.fill(4, {arg i; 0.3+(i*0.01)}), subdiv), // development
	Prand(List.fill(4, {arg i; 0.3+(i*0.02)}), subdiv), // peptide biosynthesis
	Prand(List.fill(4, {arg i; 0.3+(i*0.02)}), subdiv) // peptide biosynthesis
	],
1).asStream;

~pericyte_vocoder_pitches = Pseq([
	Prand([36, 40, 43, 47].midicps, subdiv),
	Prand([36, 40, 43, 47].midicps, subdiv),
	Prand(([59, 64, 67, 71, 74]-24).midicps, subdiv),
	Prand(([59, 64, 67, 71, 74]-24).midicps, subdiv)
],
1).asStream;

~pericyte_texture_speed = Pseq([
	Prand(List.fill(4, {arg i; (i+1)*0.5}), subdiv), // development
	Prand(List.fill(4, {arg i; (i+1)*0.5}), subdiv), // response
	Prand(List.fill(4, {arg i; (i+0.8)}), subdiv), // peptide biosynthesis
	Prand(List.fill(4, {arg i; (i+0.8)}), subdiv), // peptide biosynthesis
],
1).asStream;

~pericyte_texture_dur = Prand(List.fill(5, {arg i; 0.8+(i*0.1)}), stream_length).asStream;
~pericyte_amp = Prand(List.fill(2, {arg i; 1+i}), stream_length).asStream;
~pericyte_attack = Prand([0.01, 0.1, 0.4, 0.01, 0.01, 0.05], stream_length).asStream;

Routine({
	// BE SURE TO CHECK INS AND OUTS SO THAT THERE ARE NO CONFLICTS
	~pericytes = Array.fill(3, {
		arg i;
		Synth(\pericyte_vocoder, [
			\out, 0,
			\input, [80-(i*2), 81-(i*2)],
			\trig, 1,
			\freq, ~pericyte_vocoder_pitches,
			\texture_dur, ~pericyte_texture_speed,
			\texture_speed, ~pericyte_texture_dur,
			\amp, ~pericyte_amp,
			\attack, ~pericyte_attack,
			\dur, stream_length
		]);
	});
	~pericyte_input = Array.fill(3, {
		arg i;
		Synth(\fibroblasts, [
			\out, 81-(i*2),
			\trig, 1,
			\buf, ~endothelial_buffer,
			\grain_size, ~fibroblast_pericyte_grain_size,
			\grain_pb_rate_val, 3,
			\post_change_rate, 4,
			\texture_speed, ~fibroblast_pericyte_texture_speed,
			\amp, ~fibroblast_pericyte_amp,
			\dur, stream_length
		]);
	});
	3.wait;
	(stream_length/10).do {
		(stream_length/4).do {
			~pericytes.do({
				arg item, index;
				item.set(
					\trig, 1,
					\freq, ~pericyte_vocoder_pitches,
					\texture_dur, ~pericyte_texture_speed,
					\texture_speed, ~pericyte_texture_dur,
					\amp, ~pericyte_amp,
					\attack, ~pericyte_attack
				);
			});
			~pericyte_input.do({
				arg item, index;
				item.set(
					\trig, 1,
					\buf, ~endothelial_buffer,
					\grain_size, ~fibroblast_pericyte_grain_size,
					\texture_speed, ~fibroblast_pericyte_texture_speed,
					\amp, ~fibroblast_pericyte_amp
				);
			});
			3.wait;
		};
	};
}).play;
)