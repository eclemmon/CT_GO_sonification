// MICROGLIA:
// ***Uses same synth as macrophages***
// arg out, amp, filter_freq, texture_speed=5, attack=0.1, texture_dur=0.4, trig=0, dur=15, rq=0.001, pos=0;
// EXAMPLE:
// ~microglia = Group.new;
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
//      ~microglia, \addToHead)
// });

(
var stream_length, subdiv;
stream_length = 120;
subdiv = stream_length/4;

~microglia = Group.new;

~microglia_amp = Pseq([
	Prand(List.fill(1, { 0 }), 5), // Nothing
	Prand(List.fill(1, { 0 }), 5), // Nothing
	Prand(List.fill(5, {0.1.rand}), 5), // cell death
	Prand(List.fill(5, {0.02.rand}), 5), // development
	],
1).asStream;

~microglia_filter_freq = Pseq([
	Prand(List.fill(1, { 0 }), 5), // Nothing
	Prand(List.fill(1, { 0 }), 5), // Nothing
	Prand([88,89,90].midicps, 5), // cell death
	Prand([60, 64, 67, 71].midicps, 5), // development
	],
1).asStream;

~microglia_attack = Pseq([
	Prand(List.fill(1, { 0 }), 5), // Nothing
	Prand(List.fill(1, { 0 }), 5), // Nothing
	Prand(List.fill(4, {0.01.rand+0.01}), 5), // cell death
	Prand(List.fill(5, {0.2.rand+0.1}), 5), // development
	],
1).asStream;

~microglia_texture_dur = Pseq([
	Prand(List.fill(1, { 0 }), 5), // Nothing
	Prand(List.fill(1, { 0 }), 5), // Nothing
	Prand(List.fill(10, {0.1.rand}), 5), // cell death
	Prand(List.fill(10, {2.0.rand+0.1}), 5), // development
	],
1).asStream;

~microglia_texture_speed = Pseq([
	Prand(List.fill(1, { 0 }), 5), // Nothing
	Prand(List.fill(1, { 0 }), 5), // Nothing
	Prand(List.fill(10, rrand(10, 20)), 5), // cell death
	Prand(List.fill(10, rrand(1.0, 2.0)), 5), // development
	],
1).asStream;

~microglia_rq = Pseq([
	Prand(List.fill(1, { 0 }), 5), // Nothing
	Prand(List.fill(1, { 0 }), 5), // Nothing
	Prand(List.fill(10, {0.1.rand} ), 5), // cell death
	Prand(List.fill(10, { 0.001.rand+0.001  }), 5), // peptide biosynthesis (repair)
	],
1).asStream;

Routine({
	Array.fill(5, {arg i;
		Synth(\macrophages, [
			\out, 0,
			\amp, ~microglia_amp,
			\filter_freq, i * ~microglia_filter_freq,
			\trig, 1,
			\texture_speed, ~microglia_texture_speed,
			\texture_dur, ~microglia_texture_dur,
			\attack, ~microglia_attack,
			\rq, ~microglia_rq,
			\pos, 1.0.xrand2,
			\dur, subdiv+2
		],
		~microglia, \addToHead)
	});
	subdiv.wait;

	loop({
		Array.fill(5, {arg i;
			Synth(\macrophages, [
				\out, 0,
				\amp, ~microglia_amp,
				\filter_freq, i * ~microglia_filter_freq,
				\trig, 1,
				\texture_speed, ~microglia_texture_speed,
				\texture_dur, ~microglia_texture_dur,
				\attack, ~microglia_attack,
				\rq, ~microglia_rq,
				\pos, 1.0.xrand2,
				\dur, subdiv+2
			],
			~microglia, \addToHead)
		});
		subdiv.wait;
	});
}).play;
)