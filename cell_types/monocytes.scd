// MONOCYTES:
// ***Uses same synth as macrophages***
// arg out, amp, filter_freq, texture_speed=5, attack=0.1, texture_dur=0.4, trig=0, dur=15, rq=0.001, pos=0;
// EXAMPLE:
// ~monocytes = Group.new;
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
//      ~monocytes, \addToHead)
// });


(
var stream_length, subdiv;
stream_length = 120;
subdiv = stream_length/4;

~monocytes = Group.new;

~monocyte_amp = Pseq([
	Prand(List.fill(1, { 0 }), 20), // Nothing
	Prand(List.fill(4, {0.02.rand}), 20), // defense response
	Prand(List.fill(1, { 0 }), 20), // Nothing
	Prand(List.fill(5, {0.01.rand}), 20), // peptide biosynthesis (repair)
	],
1).asStream;

~monocyte_attack = Pseq([
	Prand(List.fill(1, { 0 }), 20), // Nothing
	Prand(List.fill(4, {0.1.rand+0.01}), 20), // defense response
	Prand(List.fill(1, { 0 }), 20), // Nothing
	Prand(List.fill(5, {0.1.rand+0.1}), 20), // peptide biosynthesis (repair)
	],
1).asStream;

~monocyte_filter_freq = Pseq([
	Prand(List.fill(1, { 0 }), 20), // Nothing
	Prand(List.fill(30, { rrand(550, 600)+40 }), 20), // defense response
	Prand(List.fill(1, { 0 }), 20), // Nothing
	Prand(List.fill(30, { rrand(550, 600)+40 }), 20), // peptide biosynthesis (repair)
	],
1).asStream;

~monocyte_texture_dur = Pseq([
	Prand(List.fill(1, { 0 }), 20), // Nothing
	Prand(List.fill(10, {0.2.rand+0.1}), 20), // defense response
	Prand(List.fill(1, { 0 }), 20), // Nothing
	Prand(List.fill(10, {0.4.rand+0.1}), 20), // peptide biosynthesis (repair)
	],
1).asStream;

~monocyte_texture_speed = Pseq([
	Prand(List.fill(1, { 0 }), 20), // Nothing
	Prand(List.fill(10, {5.rand}), 20), // defense response
	Prand(List.fill(1, { 0 }), 20), // Nothing
	Prand(List.fill(10, {2.rand}), 20), // peptide biosynthesis (repair)
	],
1).asStream;

~monocyte_rq = Pseq([
	Prand(List.fill(1, { 0 }), 20), // Nothing
	Prand(List.fill(10, {0.2.rand}), 20), // defense response
	Prand(List.fill(1, { 0 }), 20), // Nothing
	Prand(List.fill(10, {0.4.rand}), 20), // peptide biosynthesis (repair)
	],
1).asStream;

Routine({
	Array.fill(20, {arg i;
		Synth(\macrophages, [
			\out, 0,
			\amp, ~monocyte_amp,
			\filter_freq, i * ~monocyte_filter_freq,
			\trig, 1,
			\texture_speed, ~monocyte_texture_speed,
			\texture_dur, ~monocyte_texture_dur,
			\attack, ~monocyte_attack,
			\rq, ~monocyte_rq,
			\pos, 1.0.xrand2,
			\dur, subdiv
		],
		~monocytes, \addToHead)
	});
	subdiv.wait;
	loop({
		Array.fill(20, {arg i;
			Synth(\macrophages, [
				\out, 0,
				\amp, ~monocyte_amp,
				\filter_freq, i * ~monocyte_filter_freq,
				\trig, 1,
				\texture_speed, ~monocyte_texture_speed,
				\texture_dur, ~monocyte_texture_dur,
				\attack, ~monocyte_attack,
				\rq, ~monocyte_rq,
				\pos, 1.0.xrand2,
				\dur, subdiv
			],
			~monocytes, \addToHead)
		});
		subdiv.wait;
	});
}).play;
)