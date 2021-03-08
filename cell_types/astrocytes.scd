// ASTROCYTES:
// trig, freq, out, filter_freq, texture_speed, attack=0.01, dur=15, amp=1.0, texture_dur=0.1;
// EXAMPLE:
// Synth(\Astrocytes, [\out, 99, \trig, 1, \freq, 64.midicps, \filter_freq, 80, \texture_speed, 10, \attack, 0.01, \amp, 5]);

(
var stream_length, subdiv;
stream_length = 120;
subdiv = stream_length/4;
~astrocyte_pitches = Pseq([
	Prand([60, 64, 67, 71].midicps, subdiv), // development
	Prand([60, 62, 64, 68, 70].midicps, subdiv), // response
	Prand([59, 64, 67, 71, 74].midicps, subdiv), // peptide biosynthesis
	Prand([60, 64, 67, 71].midicps, subdiv), // synapse pruning, development
],
1).asStream;

~astrocyte_texture_speed = Pseq([
	Prand(List.fill(5, {arg i; (i+1)/2}), subdiv), // development
	Prand(List.fill(5, {arg i; (i+5)/2}), subdiv), // response
	Prand(List.fill(5, {arg i; (i+2)/2}), subdiv), // peptide biosynthesis
	Prand(List.fill(5, {arg i; (i+1)/2}), subdiv)  // synapse pruning, development
], 1).asStream;

~astrocyte_filter_freq = Prand(List.fill(20, {arg i; (i*10)+40}), stream_length).asStream;

~astrocyte_texture_dur = Pseq([
	Prand(List.fill(5, {arg i; (i+1)/2}), subdiv), // development
	Prand(List.fill(5, {arg i; (i*0.1+0.1)/2}), subdiv), // response
	Prand(List.fill(5, {arg i; (i+1)/3}), subdiv), // peptide biosynthesis
	Prand(List.fill(5, {arg i; (i+1)/2}), subdiv) // synapse pruning, development
], 1).asStream;

~astrocyte_amp = Prand(List.fill(4, {arg i; i+2}), stream_length).asStream;

Routine({
	(stream_length/10).do {
		(stream_length/4).do {
			3.do {
				Synth(\Astrocytes, [
					\out, 99,
					\trig, 1,
					\freq, ~astrocyte_pitches,
					\texture_speed, ~astrocyte_texture_speed,
					\attack, 0.01,
					\dur, stream_length/8,
					\amp, ~astrocyte_amp,
					\texture_dur, ~astrocyte_texture_dur,
					\filter_freq, ~astrocyte_filter_freq
				]);
			};
			3.wait;
		};
	};
}).play;
)