// MACROPHAGES:
// arg out, amp, filter_freq, texture_speed=5, attack=0.1, texture_dur=0.4, trig=0, dur=15, rq=0.001, pos=0;
// EXAMPLE:
// ~macrophages = Group.new;
// Array.fill(5, {arg i;
//      Synth(\macrophages, [
//            \out, 0,
//            \amp, 0.2,
//            \filter_freq, i*100+40,
//            \trig, 1,
//            \texture_dur, 0.5,
//            \attack, 0.01,
//            \rq, 0.1,
//            \pos, i/5],
//      ~macrophages, \addToHead)
// });

(
var stream_length, subdiv;
stream_length = 120;
subdiv = stream_length/4;

~macrophages = Group.new;

~macrophage_amp = Pseq([
	Prand(List.fill(1, { 0 }), 5), // Nothing
	Prand(List.fill(4, {0.2.rand}), 5), // defense response
	Prand(List.fill(1, { 0 }), 5), // Nothing
	Prand(List.fill(5, {0.1.rand}), 5), // peptide biosynthesis (repair)
	],
1).asStream;

~macrophage_attack = Pseq([
	Prand(List.fill(1, { 0 }), 5), // Nothing
	Prand(List.fill(4, {0.1.rand+0.01}), 5), // defense response
	Prand(List.fill(1, { 0 }), 5), // Nothing
	Prand(List.fill(5, {0.1.rand+0.1}), 5), // peptide biosynthesis (repair)
	],
1).asStream;

~macrophage_filter_freq = Pseq([
	Prand(List.fill(1, { 0 }), 5), // Nothing
	Prand(List.fill(30, { rrand(100, 200)+40 }), 5), // defense response
	Prand(List.fill(1, { 0 }), 5), // Nothing
	Prand(List.fill(30, { rrand(100, 200)+40 }), 5), // peptide biosynthesis (repair)
	],
1).asStream;

~macrophage_texture_dur = Pseq([
	Prand(List.fill(1, { 0 }), 5), // Nothing
	Prand(List.fill(10, {0.5.rand}), 5), // defense response
	Prand(List.fill(1, { 0 }), 5), // Nothing
	Prand(List.fill(10, {0.5.rand}), 5), // peptide biosynthesis (repair)
	],
1).asStream;

~macrophage_texture_speed = Pseq([
	Prand(List.fill(1, { 0 }), 5), // Nothing
	Prand(List.fill(10, {5.rand}), 5), // defense response
	Prand(List.fill(1, { 0 }), 5), // Nothing
	Prand(List.fill(10, {2.rand}), 5), // peptide biosynthesis (repair)
	],
1).asStream;

~macrophage_rq = Pseq([
	Prand(List.fill(1, { 0 }), 5), // Nothing
	Prand(List.fill(10, {0.1.rand}), 5), // defense response
	Prand(List.fill(1, { 0 }), 5), // Nothing
	Prand(List.fill(10, {0.2.rand}), 5), // peptide biosynthesis (repair)
	],
1).asStream;

Routine({
	Array.fill(5, {arg i;
		Synth(\macrophages, [
			\out, 0,
			\dur, 30,
			\amp, ~macrophage_amp,
			\filter_freq, i * ~macrophage_filter_freq,
			\trig, 1,
			\texture_speed, ~macrophage_texture_speed,
			\texture_dur, ~macrophage_texture_dur,
			\attack, ~macrophage_attack,
			\rq, ~macrophage_rq,
			\pos, 1.0.xrand2],
		~macrophages, \addToHead)
	});
	subdiv.wait;
	loop({
		Array.fill(5, {arg i;
			Synth(\macrophages, [
				\out, 0,
				\dur, 30,
				\amp, ~macrophage_amp,
				\filter_freq, i * ~macrophage_filter_freq,
				\trig, 1,
				\texture_speed, ~macrophage_texture_speed,
				\texture_dur, ~macrophage_texture_dur,
				\attack, ~macrophage_attack,
				\rq, ~macrophage_rq,
				\pos, 1.0.xrand2],
			~macrophages, \addToHead)
		});
		subdiv.wait;
	});
}).play;
)