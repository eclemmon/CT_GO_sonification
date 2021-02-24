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
~opc_amp = Prand(List.fill(4, {0.1.rand}), 65).asStream;
~opc_dur = Prand(List.fill(5, {arg i; 10+i*2}), 65).asStream;
~opc_attack = Prand(List.fill(20, {0.1.rand+0.05}), 65).asStream;
~opc_decay_time = Prand(List.fill(20, {0.3.rand}), 65).asStream;
~opc_decay_amp = Prand(List.fill(5, {arg i; 0.4+(i*0.5)}), 65).asStream;
~opc_sustain_freq = Prand(List.fill(20, {2000.rand}), 65).asStream;
~opc_pos = Prand(List.fill(20, {1.0.xrand2}), 65).asStream;
~opc_filter_env_start_freq = Prand(List.fill(8, {arg i; 660+(110*i)}), 65).asStream;
~opc_filter_env_end_freq = Prand(List.fill(8, {arg i; (660+(110*i))/2}), 65).asStream;
~opc_filter_decay_dur = Prand(List.fill(5, {arg i; 0.1+(i*0.05)}), 65).asStream;
~opc_filter_release_time = Prand(List.fill(20, {1.0.rand}), 65).asStream;
~opc_tail_length = Prand(List.fill(20, {10.rand}), 65).asStream;
~opc_tail_length_level = Prand(List.fill(4, {arg i; 0.05+(i*0.05)}), 65).asStream;

Routine({
	loop({
		Synth(\OPC, [
			\amp, ~opc_amp,
			\dur, ~opc_dur,
			\attack, ~opc_attack,
			\decay_time, ~opc_decay_time,
			\decay_amp, ~opc_decay_amp,
			\sustain_freq, ~opc_sustain_freq,
			\pos, ~opc_pos,
			\filter_env_start_freq, ~opc_filter_env_start_freq,
			\filter_env_end_freq, ~opc_filter_env_end_freq,
			\filter_decay_dur, ~opc_filter_decay_dur,
			\filter_release_time, ~opc_filter_release_time,
			\tail_length, ~opc_tail_length,
			\tail_length_level, ~opc_tail_length_level,
			\trig, 1,
			\freq, 60.midicps,
			\fmod_freq, 24.midicps
			]);
		30.rand.wait;
	})
}).play;
)
