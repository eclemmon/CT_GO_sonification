// ASTROCYTES:
// trig, freq, out, filter_freq, texture_speed, attack=0.01, dur=15, amp=1.0, texture_dur=0.1;
// EXAMPLE:
// Synth(\Astrocytes, [\out, 99, \trig, 1, \freq, 64.midicps, \filter_freq, 80, \texture_speed, 10, \attack, 0.01, \amp, 5]);

(
~astrocyte_pitches = Pseq([
	Prand([60, 64, 67, 71].midicps, 5),
	Prand([60, 64, 67, 71, 74].midicps, 10),
	Prand([59, 64, 67, 71, 74].midicps, 10),
	Prand([57, 64, 67, 71, 74].midicps, 20),
	Prand([53, 57, 60, 64, 71, 74].midicps, 20)
],
1).asStream;

~astrocyte_texture_speed = Prand(List.fill(5, {arg i; (i+1)*2}), 65).asStream;
~astrocyte_filter_freq = Prand(List.fill(20, {arg i; (i*10)+40}), 65).asStream;
~astrocyte_texture_dur = Prand(List.fill(5, {arg i; (i+1)/2}), 65).asStream;
~astrocyte_amp = Prand(List.fill(4, {arg i; i+2}), 65).asStream;

Routine({
	loop({
		3.do {
			Synth(\Astrocytes, [
				\out, 99,
				\trig, 1,
				\freq, ~astrocyte_pitches,
				\texture_speed, ~astrocyte_texture_speed,
				\attack, 0.01,
				\dur, 15,
				\amp, ~astrocyte_amp,
				\texture_dur, ~astrocyte_texture_dur,
				\filter_freq, ~astrocyte_filter_freq
			]);
		};
		3.wait;
	})
}).play;
)