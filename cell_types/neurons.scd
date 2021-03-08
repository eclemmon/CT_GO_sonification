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
var stream_length, subdiv;
stream_length = 120;
subdiv = stream_length/4;
~neuron_pitches = Pseq([
	Prand([60, 64, 67, 71].midicps, subdiv), // development
	Prand([60, 62, 64, 68, 70].midicps, subdiv), // response
	Prand([59, 64, 67, 71, 74].midicps, subdiv), // peptide biosynthesis
	Prand([48, 52, 55, 59, 48, 52, 55, 59, 48, 52, 55, 59, 60, 62, 64, 66, 68, 70, 88, 89, 90].midicps, subdiv), // synapse pruning, defense response, cell death
],
1).asStream;

~neuron_texture_speed = Pseq([
	Prand(List.fill(5, {arg i; (i+1)/4}), subdiv), // development
	Prand(List.fill(5, {arg i; (i+5)/4}), subdiv), // response
	Prand(List.fill(5, {arg i; (i+1)/4}), subdiv), // peptide biosynthesis
	Prand(List.fill(5, {arg i; (i+5)/4}), subdiv)  // synapse pruning, defense response, cell death
], 1).asStream;

~neuron_feedback_start = Pseq([
	Prand(List.fill(5, {arg i; (i+1)/10}), stream_length), // development
	Prand(List.fill(5, {arg i; (i+3)/10}), stream_length), // response
	Prand(List.fill(5, {arg i; (i+2)/10}), stream_length), // peptide biosynthesis
	Prand(
		List.fill(5, {arg i; (i+3)/10})++
		List.fill(5, {arg i; (i+1)/10})++
		List.fill(5, {arg i; (i+4)/10}),
		stream_length), // synapse pruning, defense response, cell death
], 1).asStream;

~neuron_feedback_peak = Pseq([
	Prand(List.fill(5, {arg i; (i+1)/5}), stream_length), // development
	Prand(List.fill(5, {arg i; (i+3)/5}), stream_length), // response
	Prand(List.fill(5, {arg i; (i+2)/5}), stream_length), // peptide biosynthesis
	Prand(
		List.fill(5, {arg i; (i+3)/5})++
		List.fill(5, {arg i; (i+1)/5})++
		List.fill(5, {arg i; (i+4)/5}),
		stream_length), // synapse pruning, defense response, cell death
], 1).asStream;

~neuron_texture_dur = Pseq([
	Prand(List.fill(5, {arg i; (i+1)/2}), subdiv), // development
	Prand(List.fill(5, {arg i; (i*0.1+0.1)/2}), subdiv), // response
	Prand(List.fill(5, {arg i; (i+1)/2}), subdiv), // peptide biosynthesis
	Prand(
		List.fill(5, {arg i; (i*0.1+0.1)/2})++
		List.fill(5, {arg i; (i+1)/2})++
		List.fill(5, {arg i; (i+1)/2}),
		subdiv)  // synapse pruning, defense response, cell death
], 1).asStream;

~neuron_amp = Prand(List.fill(4, {arg i; (i+1)/100}), stream_length).asStream;

Routine({
	(stream_length/10).do {
		(stream_length/4).do {
			3.do {
				Synth(\Neuron, [
					\out, 0,
					\trig, 1,
					\freq, ~neuron_pitches,
					\texture_speed, ~neuron_texture_speed,
					\attack, 0.01,
					\dur, stream_length/8,
					\amp, ~neuron_amp,
					\feedback_start, ~neuron_feedback_start,
					\feedback_peak, ~neuron_feedback_peak,
					\texture_dur, ~neuron_texture_dur
				]);
			};
			3.wait;
		};
	};
}).play;
)
