// OPCS:
// arg 	out=0, dur=15, amp, attack=0.1, release=0.1, decay_time=0.1, decay_amp=0.7, freq=440, fmod_freq=533, fmod_mul=200, sustain_freq=660, pos=0, trig=0, filter_env_start_freq=880, filter_env_end_freq=440, filter_sus_dur=15, filter_decay_dur=0.1, filter_release_time=0.1, tail_length=4, tail_length_level=0.1;
// EXAMPLE:
// Synth(\OPC, [
//      \amp, 0.1,
//      \trig, 1.0,
//      \fmod_freq, 24.midicps,
//      \freq, 60.midicps,
//      \dur, 15,
//      \attack, 0.02,
//      \decay_time, 0.3,
//      \decay_amp, 0.1,
//      \release, 0.05,
//      \out, 0,
//      \pos, 0
// ]);

(
var stream_length, subdiv;
stream_length = 120;
subdiv = stream_length/4;

~opc_amp1 = Prand(List.fill(4, {0.1.rand}), inf).asStream; //development
~opc_amp2 = Prand(List.fill(4, {0.1.rand}), inf).asStream; // development
~opc_amp3 = Prand(List.fill(4, {0.1.rand}), inf).asStream; // repair
~opc_amp4 = Prand(List.fill(4, {0.2.rand}), inf).asStream; // repair

~opc_attack1 = Prand(List.fill(20, {0.1.rand+0.05}), inf).asStream;
~opc_attack2 = Prand(List.fill(20, {0.1.rand+0.05}), inf).asStream;
~opc_attack3 = Prand(List.fill(20, {0.1.rand+0.05}), inf).asStream;
~opc_attack4 = Prand(List.fill(20, {0.1.rand+0.05}), inf).asStream;

~opc_decay_time1 = Prand(List.fill(20, {0.3.rand}), inf).asStream;
~opc_decay_time2 = Prand(List.fill(20, {0.3.rand}), inf).asStream;
~opc_decay_time3 = Prand(List.fill(20, {0.3.rand}), inf).asStream;
~opc_decay_time4 = Prand(List.fill(20, {0.3.rand}), inf).asStream;

~opc_decay_amp1 = Prand(List.fill(5, {arg i; 0.4+(i*0.5)}), inf).asStream;
~opc_decay_amp2 = Prand(List.fill(5, {arg i; 0.4+(i*0.5)}), inf).asStream;
~opc_decay_amp3 = Prand(List.fill(5, {arg i; 0.4+(i*0.5)}), inf).asStream;
~opc_decay_amp4 = Prand(List.fill(5, {arg i; 0.4+(i*0.5)}), inf).asStream;

~opc_sustain_freq1 = Prand(List.fill(20, {2000.rand}), inf).asStream;
~opc_sustain_freq2 = Prand(List.fill(20, {2000.rand}), inf).asStream;
~opc_sustain_freq3 = Prand(List.fill(20, {2000.rand}), inf).asStream;
~opc_sustain_freq4 = Prand(List.fill(20, {2000.rand}), inf).asStream;

~opc_pos1 = Prand(List.fill(20, {1.0.xrand2}), inf).asStream;
~opc_pos2 = Prand(List.fill(20, {1.0.xrand2}), inf).asStream;
~opc_pos3 = Prand(List.fill(20, {1.0.xrand2}), inf).asStream;
~opc_pos4 = Prand(List.fill(20, {1.0.xrand2}), inf).asStream;

~opc_filter_env_start_freq1 = Prand(List.fill(8, {arg i; 660+(110*i)}), inf).asStream;
~opc_filter_env_start_freq2 = Prand(List.fill(8, {arg i; 660+(110*i)}), inf).asStream;
~opc_filter_env_start_freq3 = Prand(List.fill(8, {arg i; 660+(110*i)}), inf).asStream;
~opc_filter_env_start_freq4 = Prand(List.fill(8, {arg i; 660+(110*i)}), inf).asStream;

~opc_filter_env_end_freq1 = Prand(List.fill(8, {arg i; (660+(110*i))/2}), inf).asStream;
~opc_filter_env_end_freq2 = Prand(List.fill(8, {arg i; (660+(110*i))/2}), inf).asStream;
~opc_filter_env_end_freq3 = Prand(List.fill(8, {arg i; (660+(110*i))/2}), inf).asStream;
~opc_filter_env_end_freq4 = Prand(List.fill(8, {arg i; (660+(110*i))/2}), inf).asStream;

~opc_filter_decay_dur1 = Prand(List.fill(5, {arg i; 0.1+(i*0.05)}), inf).asStream;
~opc_filter_decay_dur2 = Prand(List.fill(5, {arg i; 0.1+(i*0.05)}), inf).asStream;
~opc_filter_decay_dur3 = Prand(List.fill(5, {arg i; 0.1+(i*0.05)}), inf).asStream;
~opc_filter_decay_dur4 = Prand(List.fill(5, {arg i; 0.1+(i*0.05)}), inf).asStream;

~opc_filter_release_time1 = Prand(List.fill(20, {1.0.rand}), inf).asStream;
~opc_filter_release_time2 = Prand(List.fill(20, {1.0.rand}), inf).asStream;
~opc_filter_release_time3 = Prand(List.fill(20, {1.0.rand}), inf).asStream;
~opc_filter_release_time4 = Prand(List.fill(20, {1.0.rand}), inf).asStream;

~opc_tail_length1 = Prand(List.fill(20, {10.rand}), inf).asStream;
~opc_tail_length2 = Prand(List.fill(20, {10.rand}), inf).asStream;
~opc_tail_length3 = Prand(List.fill(20, {10.rand}), inf).asStream;
~opc_tail_length4 = Prand(List.fill(20, {10.rand}), inf).asStream;

~opc_tail_length_level1 = Prand(List.fill(4, {arg i; 0.05+(i*0.05)}), inf).asStream;
~opc_tail_length_level2 = Prand(List.fill(4, {arg i; 0.05+(i*0.05)}), inf).asStream;
~opc_tail_length_level3 = Prand(List.fill(4, {arg i; 0.05+(i*0.05)}), inf).asStream;
~opc_tail_length_level4 = Prand(List.fill(4, {arg i; 0.05+(i*0.05)}), inf).asStream;

Routine({
	var section_length = 30.0, time_gen, dur;

	while (
		{ section_length > 0 },
		{
			time_gen = rrand(8.0,12.0);
			dur = time_gen;
			section_length = section_length - time_gen;
			time_gen.postln;
			Synth(\OPC, [
				\amp, ~opc_amp1,
				\dur, 10,
				\attack, ~opc_attack1,
				\decay_time, ~opc_decay_time1,
				\decay_amp, ~opc_decay_amp1,
				\sustain_freq, ~opc_sustain_freq1,
				\pos, ~opc_pos1,
				\filter_env_start_freq, ~opc_filter_env_start_freq1,
				\filter_env_end_freq, ~opc_filter_env_end_freq1,
				\filter_decay_dur, ~opc_filter_decay_dur1,
				\filter_release_time, ~opc_filter_release_time1,
				\tail_length, ~opc_tail_length1,
				\tail_length_level, ~opc_tail_length_level1,
				\trig, 1,
				\freq, 60.midicps,
				\fmod_freq, 24.midicps
			]);

			time_gen.wait;
	});
	"end section 1".postln;

	section_length = 30;
	while (
		{ section_length > 0 },
		{
			time_gen = rrand(8.0,12.0);
			section_length = section_length - time_gen;
			time_gen.postln;
			Synth(\OPC, [
				\amp, ~opc_amp2,
				\dur, 10,
				\attack, ~opc_attack2,
				\decay_time, ~opc_decay_time2,
				\decay_amp, ~opc_decay_amp2,
				\sustain_freq, ~opc_sustain_freq2,
				\pos, ~opc_pos2,
				\filter_env_start_freq, ~opc_filter_env_start_freq2,
				\filter_env_end_freq, ~opc_filter_env_end_freq2,
				\filter_decay_dur, ~opc_filter_decay_dur2,
				\filter_release_time, ~opc_filter_release_time2,
				\tail_length, ~opc_tail_length2,
				\tail_length_level, ~opc_tail_length_level2,
				\trig, 1,
				\freq, 60.midicps,
				\fmod_freq, 24.midicps
			]);

			time_gen.wait;
	});
	"end section 2".postln;

	section_length = 30;
	while (
		{ section_length > 0 },
		{
			time_gen = rrand(3.0,7.0);
			section_length = section_length - time_gen;
			time_gen.postln;
			Synth(\OPC, [
				\amp, ~opc_amp3,
				\dur, 10,
				\attack, ~opc_attack3,
				\decay_time, ~opc_decay_time3,
				\decay_amp, ~opc_decay_amp3,
				\sustain_freq, ~opc_sustain_freq3,
				\pos, ~opc_pos3,
				\filter_env_start_freq, ~opc_filter_env_start_freq3,
				\filter_env_end_freq, ~opc_filter_env_end_freq3,
				\filter_decay_dur, ~opc_filter_decay_dur3,
				\filter_release_time, ~opc_filter_release_time3,
				\tail_length, ~opc_tail_length3,
				\tail_length_level, ~opc_tail_length_level3,
				\trig, 1,
				\freq, 60.midicps,
				\fmod_freq, 24.midicps
			]);

			time_gen.wait;
	});
	"end section 3".postln;

	section_length = 30;
	while (
		{ section_length > 0 },
		{
			time_gen = rrand(3.0,7.0);
			section_length = section_length - time_gen;
			time_gen.postln;
			Synth(\OPC, [
				\amp, ~opc_amp4,
				\dur, 10,
				\attack, ~opc_attack4,
				\decay_time, ~opc_decay_time4,
				\decay_amp, ~opc_decay_amp4,
				\sustain_freq, ~opc_sustain_freq4,
				\pos, ~opc_pos4,
				\filter_env_start_freq, ~opc_filter_env_start_freq4,
				\filter_env_end_freq, ~opc_filter_env_end_freq4,
				\filter_decay_dur, ~opc_filter_decay_dur4,
				\filter_release_time, ~opc_filter_release_time4,
				\tail_length, ~opc_tail_length4,
				\tail_length_level, ~opc_tail_length_level4,
				\trig, 1,
				\freq, 60.midicps,
				\fmod_freq, 24.midicps
			]);

			time_gen.wait;
	});
	"end section 4".postln;

}).play;


)
