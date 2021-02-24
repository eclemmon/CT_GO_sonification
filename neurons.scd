// NEURONS:
// arg out, trig, freq, texture_speed, attack=0.01, dur=15, amp=1.0, feedback_start=0.5, feedback_peak=1.0, texture_dur=0.1;
// EXAMPLE:
// Synth(\Neuron, [
//                \out, 99,
//                \trig, 1,
//                \freq, 67.midicps,
//                \texture_speed, 3,
//                \attack, 0.01,
//                \amp, 0.2,
//                \dur, 15,
//                \feedback_start, 0.3,
//                \feedback_peak, 0.7,
//                \texture_dur, 0.12
//                ]
// );

(
~neuron_pitches = Pseq([
	Prand([60, 64, 67, 71].midicps, 5),
	Prand([60, 64, 67, 71, 74].midicps, 10),
	Prand([59, 64, 67, 71, 74].midicps, 10),
	Prand([57, 64, 67, 71, 74].midicps, 20),
	Prand([53, 57, 60, 64, 71, 74].midicps, 20)
],
1).asStream;

~neuron_texture_speed = Prand(List.fill(5, {arg i; (i+1)}), 65).asStream;
~neuron_feedback_start = Prand(List.fill(5, {arg i; (i+1)/10}), 65).asStream;
~neuron_feedback_peak = Prand(List.fill(5, {arg i; (i+1)/5}), 65).asStream;
~neuron_texture_dur = Prand(List.fill(5, {arg i; (i+1)/2}), 65).asStream;
~neuron_amp = Prand(List.fill(4, {arg i; (i+1)/100}), 65).asStream;

Routine({
	loop({
		3.do {
			Synth(\Neuron, [
				\out, 0,
				\trig, 1,
				\freq, ~neuron_pitches,
				\texture_speed, ~neuron_texture_speed,
				\attack, 0.01,
				\dur, 15,
				\amp, ~neuron_amp,
				\feedback_start, ~neuron_feedback_start,
				\feedback_peak, ~neuron_feedback_peak,
				\texture_dur, ~neuron_texture_dur
			]);
		};
		3.wait;
	})
}).play;
)