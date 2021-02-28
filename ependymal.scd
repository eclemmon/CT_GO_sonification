// EPENDYMAL:
// out, trig, freq, texture_speed, attack=0.01, dur=15, amp=1.0, texture_dur=0.1;
// EXAMPLE:
// Synth(\Ependymal, [\out, 99, \trig, 1, \freq, 67.midicps, \texture_speed, 3, \attack, 0.01, \amp, 0.2]);

(
var stream_length, subdiv;
stream_length = 120;
subdiv = stream_length/4;

~ependymal_pitches = Pseq([
	Prand([0].midicps, subdiv), // No sound
	Prand([60, 64, 67, 71, 74].midicps, subdiv), // peptide biosynthesis
	Prand([60, 64, 67, 71, 74].midicps, subdiv), // peptide biosynthesis
	Prand([0].midicps, subdiv), // No sound
],
1).asStream;

~ependymal_texture_speed = Pseq([
	Prand(List.fill(5, { 0 }), subdiv), // No sound
	Prand(List.fill(5, {arg i; (i+5)/4}), subdiv), // peptide biosynthesis
	Prand(List.fill(5, {arg i; (i+2)/4}), subdiv), // peptide biosynthesis
	Prand(List.fill(5, { 0 }), subdiv)  // No sound
], 1).asStream;

~ependymal_texture_dur = Pseq([
	Prand(List.fill(5, { 0 }), subdiv), // No sound
	Prand(List.fill(5, {arg i; (i+1)/20}), subdiv), // peptide biosynthesis
	Prand(List.fill(5, {arg i; (i+1)/20}), subdiv), // peptide biosynthesis
	Prand(List.fill(5, { 0 }), subdiv) // No sound
], 1).asStream;

~ependymal_texture_attack = Pseq([
	Prand(List.fill(5, { 0 }), subdiv), // No sound
	Prand(List.fill(5, {arg i; (i+1)/50}), subdiv), // peptide biosynthesis
	Prand(List.fill(5, {arg i; (i+1)/50}), subdiv), // peptide biosynthesis
	Prand(List.fill(5, { 0 }), subdiv) // No sound
], 1).asStream;

~ependymal_amp = Pseq([
	Prand([0].midicps, subdiv), // No sound
	Prand(List.fill(4, {arg i; (i+1)*0.05}), subdiv), // peptide biosynthesis
	Prand(List.fill(4, {arg i; (i+1)*0.05}), subdiv), // peptide biosynthesis
	Prand([0].midicps, subdiv), // No sound
],
1).asStream;

Routine({
	(stream_length/10).do {
		(stream_length/4).do {
			3.do {
				Synth(\Ependymal, [
					\out, 98,
					\trig, 1,
					\freq, ~ependymal_pitches,
					\texture_speed, ~ependymal_texture_speed,
					\attack, ~ependymal_texture_attack,
					\dur, 15,
					\amp, ~ependymal_amp,
					\texture_dur, ~ependymal_texture_dur,
				]);
			};
			3.wait;
		};
	};
}).play;
)