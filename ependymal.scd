// EPENDYMAL:
// out, trig, freq, texture_speed, attack=0.01, dur=15, amp=1.0, texture_dur=0.1;
// EXAMPLE:
// Synth(\Ependymal, [\out, 99, \trig, 1, \freq, 67.midicps, \texture_speed, 3, \attack, 0.01, \amp, 0.2]);

(
~ependymal_pitches = Pseq([
	Prand([60, 64, 67, 71].midicps, 5),
	Prand([60, 64, 67, 71, 74].midicps, 10),
	Prand([59, 64, 67, 71, 74].midicps, 10),
	Prand([57, 64, 67, 71, 74].midicps, 20),
	Prand([53, 57, 60, 64, 71, 74].midicps, 20)
],
1).asStream;

~ependymal_texture_speed = Prand(List.fill(3, {arg i; i+1}), 65).asStream;
~ependymal_texture_dur = Prand(List.fill(5, {arg i; (i+1)/20}), 65).asStream;
~ependymal_texture_attack = Prand(List.fill(5, {arg i; (i+1)/50}), 65).asStream;
~ependymal_amp = Prand(List.fill(4, {arg i; (i+1)*0.05}), 65).asStream;

Routine({
	loop({
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
	})
}).play;
)