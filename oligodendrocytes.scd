// OLIGODENDRICYTES:
// arg out=0, dur=15, amp, attack=0.1, release=0.1, decay_time=0.1, decay_amp=0.7, freq=440, fmod_freq=533, fmod_mul=200, cutoff_freq=880, pos=0, trig=0, texture_speed=3, texture_start_dur=0.5, texture_end_dur=2;
// EXAMPLE:
// Synth(\Oligodendrocytes, [
//      \amp, 0.2,
//      \trig, 1.0,
//      \fmod_freq, 60.midicps,
//      \freq, 36.midicps,
//      \dur, 15,
//      \attack, 0.02,
//      \decay_time, 0.3,
//      \decay_amp, 0.1,
//      \release, 0.05,
//      \out, 99,
//      \pos, 0
// ]);

(
var stream_length, subdiv;
stream_length = 120;
subdiv = stream_length/40;

~oligodendrocyte_amp = Pseq([
	Prand(List.fill(4, {0.2.rand}), subdiv), // development
	Prand(List.fill(4, { 0.3.rand }), subdiv), // peptide bio synthesis (repair)
	Prand(List.fill(1, { 0 }), subdiv), // Nothing
	Prand(List.fill(4, {0.3.rand})++List.fill(4, {0.5.rand}), subdiv), // Synapse pruning (repair), defense response (fight)
	],
1).asStream;

~oligodendrocyte_attack = Pseq([
	Prand(List.fill(20, {0.3.rand+0.01}), subdiv), // development
	Prand(List.fill(20, {0.1.rand+0.01}), subdiv), // peptide bio synthesis (repair)
	Prand(List.fill(1, { 0 }), subdiv), // Nothing
	Prand(List.fill(20, {0.1.rand+0.01})++List.fill(20, {0.01.rand+0.01}), subdiv), // Synapse pruning (repair), defense response (fight)
	],
1).asStream;

~oligodendrocyte_decay_time = Pseq([
	Prand(List.fill(20, {0.2.rand+0.05}), subdiv), // development
	Prand(List.fill(20, {0.1.rand+0.05}), subdiv), // peptide bio synthesis (repair)
	Prand(List.fill(1, { 0 }), subdiv), // Nothing
	Prand(List.fill(20, {0.1.rand+0.05})++List.fill(20, {0.01.rand+0.05}), subdiv), // Synapse pruning (repair), defense response (fight)
	],
1).asStream;

~oligodendrocyte_decay_amp = Pseq([
	Prand(List.fill(5, {arg i; 0.4+(i*0.05)}), subdiv), // development
	Prand(List.fill(5, {arg i; 0.2+(i*0.05)}), subdiv), // peptide bio synthesis (repair)
	Prand(List.fill(1, { 0 }), subdiv), // Nothing
	Prand(List.fill(5, {arg i; 0.2+(i*0.05)})++List.fill(5, {arg i; 0.01+(i*0.05)}), subdiv), // Synapse pruning (repair), defense response (fight)
	],
1).asStream;

~oligodendrocyte_pos = Prand(List.fill(1, {0}), stream_length).asStream;
~oligodendrocyte_texture_speed = 3;
~oligodendrocyte_texture_start_dur = Pseq([
	Prand(List.fill(5, {arg i; 0.1+(i*0.05)}), subdiv), // development
	Prand(List.fill(5, {arg i; 0.05+(i*0.05)}), subdiv), // peptide bio synthesis (repair)
	Prand(List.fill(1, { 0 }), subdiv), // Nothing
	Prand(List.fill(5, {arg i; 0.5+(i*0.05)})++List.fill(5, {arg i; 0.005+(i*0.05)}), subdiv), // Synapse pruning (repair), defense response (fight)
	],
1).asStream;

Routine({
	var start_dur, end_dur;
	start_dur = ~oligodendrocyte_texture_start_dur;
	end_dur = start_dur + 0.1.rand;
	start_dur.postln;
	Synth(\Oligodendrocytes, [
		\out, 98,
		\dur, 11,
		\amp, ~oligodendrocyte_amp,
		\attack, ~oligodendrocyte_attack,
		\release, 0.1,
		\decay_time, ~oligodendrocyte_decay_time,
		\decay_amp, ~oligodendrocyte_decay_amp,
		\freq, 30.midicps,
		\fmod_freq, 54.midicps,
		\pos, ~oligodendrocyte_pos,
		\trig, 1,
		\texture_speed, ~oligodendrocyte_texture_speed,
		\texture_start_dur, start_dur,
		\texture_end_dur, end_dur
	]);
	10.wait;
	loop({
		Synth(\Oligodendrocytes, [
			\out, 98,
			\dur, 11,
			\amp, ~oligodendrocyte_amp,
			\attack, ~oligodendrocyte_attack,
			\release, 0.1,
			\decay_time, ~oligodendrocyte_decay_time,
			\decay_amp, ~oligodendrocyte_decay_amp,
			\freq, 30.midicps,
			\fmod_freq, 54.midicps,
			\pos, ~oligodendrocyte_pos,
			\trig, 1,
			\texture_speed, ~oligodendrocyte_texture_speed,
			\texture_start_dur, start_dur,
			\texture_end_dur, end_dur
		]);
		10.wait;
	});
}).play;
)
~oligodendrocyte.set(\trig, 0);