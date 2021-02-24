s = Server.default.boot;
s.options.outDevice = "multi_output_scarlett";
s.options.display;
(
SynthDef(\reverb1, {
	arg output, mix=0.25, room=0.15, damp=0.5, amp=1.0, input;
	var in, reverb;
	in = In.ar(input, 2);
	reverb = FreeVerb2.ar(in[0], in[1], mix: mix, room: room, damp: damp);
	Out.ar(output*amp, reverb);
}).add;

SynthDef(\Astrocytes, {
	arg trig, freq, out, filter_freq, texture_speed, attack=0.01, dur=15, amp=1.0;
	var env, sig, lfo, filt_lfo, texture, filter, saw, pan;
	env = EnvGen.kr(Env([0,1,1,0], [0.1, dur-0.2, 0.1]), gate: trig, doneAction: Done.freeSelf);
	texture = EnvGen.kr(Env.perc(attack, 0.1), gate: Dust.kr(texture_speed));
	lfo = SinOsc.kr(0.2, mul: 0.2);
	saw = Saw.ar(freq, mul: 0.7);
	filt_lfo = SinOsc.kr(0.7, mul: filter_freq*0.5);
	filter = LPF.ar(saw*lfo, filter_freq + filt_lfo);
	sig = filter * texture * env * 2;
	pan = Pan2.ar(sig, pos: SinOsc.kr(0.2), level: amp);
	Out.ar(out, pan);
}).add;

SynthDef(\Ependymal, {
	arg out, trig, freq, texture_speed, attack=0.01, dur=15, amp=1.0;
	var env, sig, lfo, texture, filter, sin, pan;
	env = EnvGen.kr(Env([0,1,1,0], [0.1, dur-0.2, 0.1]), gate: trig, doneAction: Done.freeSelf);
	texture = EnvGen.kr(Env.perc(attack, 0.1), gate: Dust.kr(texture_speed));
	lfo = SinOsc.kr(0.2, mul: 0.2);
	sin = SinOsc.ar(freq, mul: 0.7, add: lfo);
	sig = sin * texture * env;
	pan = Pan2.ar(sig, pos:SinOsc.kr(0.3), level: amp);
	Out.ar(out, pan);
}).add;

SynthDef(\Neuron, {
	arg out, trig, freq, texture_speed, attack=0.01, dur=15, amp=1.0, feedback_start=0.5, feedback_peak=1.0, texture_dur=0.1;
	var env, sig, lfo, texture, sinfb, pan, feedback_env, texture_trig;
	texture_trig = Dust.kr(texture_speed);
	env = EnvGen.kr(Env([0,1,1,0], [0.1, dur-0.2, 0.1]), gate: trig, doneAction: Done.freeSelf);
	feedback_env = EnvGen.kr(Env([feedback_start+0.01, feedback_peak, feedback_start+0.01], [texture_dur/2, texture_dur/2], curve: 'wel'), gate: texture_trig);
	texture = EnvGen.kr(Env.perc(attack, texture_dur), gate: texture_trig);
	lfo = SinOsc.kr(0.2, mul: 1);
	sinfb = SinOscFB.ar(freq, feedback: feedback_env);
	sig = sinfb * texture * env;
	pan = Pan2.ar(sig, pos: lfo, level: amp);
	Out.ar(out, pan);
}).add;

SynthDef(\fibroblasts, {
	arg out, trig, texture_speed, dur=15, amp=1.0, buf, bufnum= -1, grain_pb_rate_val=1.0, pos_change_rate=1.0, grain_size;
	var env, sig, lfo, texture, grain, pan, texture_trig, grain_pb_rate, grain_start_pos;
	env = EnvGen.kr(Env([0,1,1,0], [0.1, dur-0.2, 0.1]), gate: trig, doneAction: Done.freeSelf);
	lfo = SinOsc.kr(0.7);
	texture_trig = Dust.kr(texture_speed);
	grain_pb_rate = LFNoise0.kr(grain_pb_rate_val);
	grain_start_pos = LFNoise0.kr(pos_change_rate).range(0,1);
	grain = GrainBuf.ar(numChannels: 2, trigger: texture_trig, dur: grain_size, sndbuf: buf, rate: grain_pb_rate, pos: grain_start_pos, envbufnum: bufnum);
	sig = env * grain;
	pan = Pan2.ar(sig, pos: lfo, level: amp);
	Out.ar(out, pan);
}).add;

SynthDef(\endothelial_vocoder, {
	arg input, out, dur=15, amp=1.0, attack=0.01, texture_dur=0.5, texture_speed=3, freq=0, trig;
	var in, carrier, pan, sig, lfo, env, texture_trig, texture, vocoder, filter;
	texture_trig = Dust.kr(texture_speed);
	env = EnvGen.kr(
		Env([0,1,1,0], [0.1, dur-1.2, 1], curve: 'wel'),
		gate: trig,
		doneAction: Done.freeSelf);
	texture = EnvGen.kr(Env.perc(attack, texture_dur), gate: texture_trig, levelScale: LFNoise0.kr(6).range(0.3, 0.9));
	lfo = SinOsc.kr(0.1);
	in = SoundIn.ar(input); // modulator
	carrier = Saw.ar(freq)*texture;
	vocoder = Vocoder.ar(carrier, in, num: 12, low: 100, high: 1000, q:0.02, hpf: 10)*texture;
	// filter = HPF.ar(HPF.ar(in, 5000), 5000);
	pan = Pan2.ar(vocoder, pos: lfo, level: amp*env);
	Out.ar(out, pan);
}).add;

SynthDef(\pericyte_vocoder, {
	arg input, out, dur=15, amp=1.0, attack=0.01, texture_dur=0.5, texture_speed=3, freq=0, trig;
	var in, carrier, pan, sig, lfo, env, texture_trig, texture, vocoder, filter;
	texture_trig = Dust.kr(texture_speed);
	env = EnvGen.kr(
		Env([0,1,1,0], [0.1, dur-1.2, 1], curve: 'wel'),
		gate: trig,
		doneAction: Done.freeSelf);
	texture = EnvGen.kr(Env.perc(attack, texture_dur), gate: texture_trig, levelScale: LFNoise0.kr(6).range(0.3, 0.9));
	lfo = SinOsc.kr(0.1);
	in = SoundIn.ar(input); // modulator
	carrier = SinOsc.ar(freq)*texture;
	vocoder = Vocoder.ar(carrier, in, num: 12, low: 10, high: 7500, q:0.05, hpf: 500)*texture;
	// filter = HPF.ar(HPF.ar(in, 5000), 5000);
	pan = Pan2.ar(vocoder, pos: lfo, level: amp*env);
	Out.ar(out, pan);
}).add;

SynthDef(\OPC, {
	arg out=0, dur=15, amp, attack=0.1, release=0.1, decay_time=0.1, decay_amp=0.7, freq=440, fmod_freq=533, fmod_mul=200, cutoff_freq=880, pos=0, trig=0;
	var pan, sig, env, filter, carrier, modulator, fmod_env;
	fmod_env = EnvGen.kr(Env([0,1,1,0], [attack, dur/2-attack, dur/2], curve: 'wel'), gate: trig);
	modulator = SinOsc.ar(fmod_freq, mul: fmod_mul);
	carrier = SinOsc.ar(freq+(modulator*fmod_env));
	env = EnvGen.kr(
		Env([0,1,decay_amp,1,0], [attack, decay_time, dur-attack-release-decay_time, release], curve: ['wel', -2.0, -3, -4]),
		gate: trig,
		doneAction: Done.freeSelf);
	sig = carrier * env;
	filter = LPF.ar(sig, XLine.kr(cutoff_freq, freq, dur));
	pan = Pan2.ar(filter, pos: pos, level: amp);
	Out.ar(out, pan);
}).add;

SynthDef(\Oligodendrocytes, {
	arg out=0, dur=15, amp, attack=0.1, release=0.1, decay_time=0.1, decay_amp=0.7, freq=440, fmod_freq=533, fmod_mul=200, cutoff_freq=880, pos=0, trig=0, texture_speed=3, texture_dur=0.5;
	var pan, sig, env, filter, carrier, modulator, fmod_env, texture_trig, texture;
	texture_trig = Dust.kr(texture_speed);
	texture = EnvGen.kr(Env.perc(attack, texture_dur), gate: texture_trig, levelScale: LFNoise0.kr(6).range(0.3, 0.9));
	fmod_env = EnvGen.kr(Env([0,1,1,0], [attack, dur/2-attack, dur/2], curve: 'wel'), gate: trig);
	modulator = SinOsc.ar(fmod_freq, mul: fmod_mul);
	carrier = SinOsc.ar(freq+(modulator*fmod_env));
	env = EnvGen.kr(
		Env([0,1,decay_amp,1,0], [attack, decay_time, dur-attack-release-decay_time, release], curve: ['wel', -2.0, -3, -4]),
		gate: trig,
		doneAction: Done.freeSelf);
	sig = carrier * env * texture;
	filter = LPF.ar(sig, XLine.kr(cutoff_freq, freq, dur));
	pan = Pan2.ar(filter, pos: pos, level: amp);
	Out.ar(out, pan);
}).add;

/*SynthDef(\macrophages, {
	arg in1, in2, out, attack=0.1, decay_time=0.1, dur=15, release=0.1, pos=0, amp=0.5, decay_amp=0.7, trig=0, start_co_freq=200, end_co_freq=100;
	var input1, input2, sig, pan, env, filter;
	input1 = In.ar(in1, 2);
	input2 = In.ar(in2, 2);
	env = EnvGen.kr(
		Env([0,1,decay_amp,1,0], [attack, decay_time, dur-attack-release-decay_time, release], curve: ['wel', -2.0, -3, -4]),
		gate: trig,
		doneAction: Done.freeSelf);
	sig = input1 * input2 * env;
	filter = LPF.ar(sig, XLine.kr(start_co_freq, end_co_freq, dur));
	pan = Pan2.ar(filter, pos: pos, level: amp);
	Out.ar(out, pan);
}).add;*/

/*SynthDef(\macrophages, {
	arg out=0, input=0, dur=15, amp, attack=0.1, release=0.1, decay_time=0.1, decay_amp=0.7, freq=440, fmod_mul=200, cutoff_freq=880, pos=0, trig=0;
	var pan, sig, env, filter, carrier, modulator, fmod_env;
	fmod_env = EnvGen.kr(Env([0,1,1,0], [attack, dur/2-attack, dur/2], curve: 'wel'), gate: trig);
	modulator = In.ar(input, 2);
	carrier = SinOsc.ar(freq, mul:(modulator*fmod_mul));
	env = EnvGen.kr(
		Env([0,1,decay_amp,1,0], [attack, decay_time, dur-attack-release-decay_time, release], curve: ['wel', -2.0, -3, -4]),
		gate: trig,
		doneAction: Done.freeSelf);
	sig = carrier * env;
	filter = LPF.ar(sig, XLine.kr(cutoff_freq, freq, dur));
	pan = Pan2.ar(filter, pos: pos, level: amp);
	Out.ar(out, pan);
}).add;*/


SynthDef.new(\macrophages, {
	arg out, amp, time_to_return, filter_freq, texture_speed=5, attack=0.1, texture_dur=0.4, trig=0, dur=15, rq=0.001, pos=0;
	var noise, rand_amp, filter, texture_trig, env, texture, pan;
	texture_trig = Dust.kr(texture_speed);
	env = EnvGen.kr(
		Env([0,1,1,0], [0.1, dur-1.2, 1], curve: 'wel'),
		gate: trig,
		doneAction: Done.freeSelf);
	texture = EnvGen.kr(Env.perc(attack, texture_dur), gate: texture_trig, levelScale: LFNoise0.kr(6).range(0.3, 0.9));
	noise = ClipNoise.ar(1);
	rand_amp = LFNoise0.kr(0.5 + LFNoise0.kr(10).range(-0.1, 0.5));
	filter = RLPF.ar(noise*rand_amp, filter_freq, rq: rq, mul: 1) * env * texture;
	pan = Pan2.ar(filter, pos, amp);
	Out.ar(out, pan);
}).add;


Synth(\reverb1, [\output, 0, \room, 1, \damp, 1, \mix, 0.5, \amp, 0.5, \input, 99]);
)
(
~fibroblast_path = PathName.new(path: "/Users/ericlemmon/Desktop/VPL_Sonification_Project/Samples/final_samples/VPL_Sonification_Project_Samples.wav");
~endothelial_path = PathName.new("/Users/ericlemmon/Desktop/VPL_Sonification_Project/Samples/final_samples/VPL_Sonification_Project_Samples-001.wav");
~grain_buffer = Buffer.readChannel(s, ~fibroblast_path.fullPath, channels: 1);
~endothelial_buffer = Buffer.readChannel(s, ~endothelial_path.fullPath, channels: 1);
)
(
Synth(\Astrocytes, [\out, 99, \trig, 1, \freq, 64.midicps, \filter_freq, 80, \texture_speed, 10, \attack, 0.01, \amp, 5]);
Synth(\Ependymal, [\out, 99, \trig, 1, \freq, 67.midicps, \filter_freq, 80, \texture_speed, 3, \attack, 0.01, \amp, 0.1]);
Synth(\Neuron, [\out, 99, \trig, 1, \freq, 60.midicps, \texture_speed, 4, \amp, 0.1]);
Synth(\fibroblasts, [\out, 0, \trig, 1, \buf, ~grain_buffer, \grain_size, 0.5, \grain_pb_rate_val, 17, \pos_change_rate, 13, \texture_speed, 12, \amp, 0.1]);
//Endothelial Vocoder
Synth(\endothelial_vocoder, [\input, [96,97], \out, 0, \trig, 1, \freq, 64.midicps, \texture_dur, 1, \amp, 10, \texture_speed, 4]);
Synth(\fibroblasts, [\out, 97, \trig, 1, \buf, ~endothelial_buffer, \grain_size, 1, \grain_pb_rate_val, 17, \pos_change_rate, 13, \texture_speed, 12, \amp, 0.3]);
//Pericyte Vocoder
Synth(\pericyte_vocoder, [\input, [94,95], \out, 0, \trig, 1, \freq, 24.midicps, \texture_dur, 1, \amp, 10, \texture_speed, 4]);
Synth(\fibroblasts, [\out, 95, \trig, 1, \buf, ~endothelial_buffer, \grain_size, 1, \grain_pb_rate_val, 17, \pos_change_rate, 13, \texture_speed, 12, \amp, 0.3]);
//OPC
Synth(\OPC, [\amp, 0.1, \trig, 1.0, \fmod_freq, 36.midicps, \freq, 60.midicps, \dur, 15, \attack, 0.02, \decay_time, 0.3, \decay_amp, 0.1, \release, 0.05, \out, 99, \pos, -1.0]);
Synth(\OPC, [\amp, 0.1, \trig, 1.0, \fmod_freq, 24.midicps, \freq, 64.midicps, \dur, 15, \attack, 0.02, \decay_time, 0.3, \decay_amp, 0.1, \release, 0.05, \out, 99]);
Synth(\OPC, [\amp, 0.1, \trig, 1.0, \fmod_freq, 24.midicps, \freq, 67.midicps, \dur, 15, \attack, 0.02, \decay_time, 0.3, \decay_amp, 0.1, \release, 0.05, \out, 99, \pos, 1.0]);
Synth(\OPC, [\amp, 0.5, \trig, 1.0, \fmod_freq, 24.midicps, \freq, 60.midicps, \dur, 15, \attack, 0.02, \decay_time, 0.3, \decay_amp, 0.1, \release, 0.05, \out, 0, \pos, 1.0]);
// Oligodendrocytes
Synth(\Oligodendrocytes, [\amp, 0.2, \trig, 1.0, \fmod_freq, 60.midicps, \freq, 36.midicps, \dur, 15, \attack, 0.02, \decay_time, 0.3, \decay_amp, 0.1, \release, 0.05, \out, 99, \pos, 0]);
// Macrophages
/*(
Synth(\macrophages, [\in1, [92, 91], \in2, [90, 89], \trig, 1, \amp, 1, \start_co_freq, 200, \end_co_freq, 100]);
Synth(\OPC, [\amp, 1, \trig, 1.0, \fmod_freq, 36.midicps, \freq, 60.midicps, \dur, 15, \attack, 0.02, \decay_time, 0.3, \decay_amp, 0.1, \release, 0.05, \out, 90, \pos, 0]);
Synth(\fibroblasts, [\out, 92, \trig, 1, \buf, ~grain_buffer, \grain_size, 0.5, \grain_pb_rate_val, 17, \pos_change_rate, 13, \texture_speed, 12, \amp, 1]);
)*/

(
Synth(\macrophages, [\input, [92, 91], \amp, 0.1, \trig, 1.0, \fmod_mul, 4, \freq, 60.midicps, \dur, 15, \attack, 0.02, \decay_time, 0.3, \decay_amp, 0.1, \release, 1, \out, 0, \pos, 0]);
Synth(\fibroblasts, [\out, 92, \trig, 1, \buf, ~grain_buffer, \grain_size, 0.5, \grain_pb_rate_val, 17, \pos_change_rate, 13, \texture_speed, 12, \amp, 1]);
)

(
~high_old_piano = Group.new;
Array.fill(5, {arg i; Synth(\macrophages, [\out, 0, \amp, 0.005, \filter_freq, i*533+40, \trig, 1, \texture_dur, 0.2, \rq, 0.001, \pan, i/5], ~high_old_piano, \addToHead)});
)

(
~macrophages = Group.new;
Array.fill(20, {arg i; Synth(\macrophages, [\out, 0, \amp, 0.2, \filter_freq, i*100+40, \trig, 1, \texture_dur, 0.5, \attack, 0.01, \rq, 0.1, \pan, i/5], ~macrophages, \addToHead)});
)

(
~monocytes = Group.new;
Array.fill(20, {arg i; Synth(\macrophages, [\out, 0, \amp, 0.02, \filter_freq, i*533+40, \trig, 1, \texture_dur, 0.2, \rq, 0.2, \pan, i/5], ~monocytes, \addToHead)});
)

(
~microglia = Group.new;
Array.fill(5, {arg i; Synth(\macrophages, [\out, 0, \amp, 0.02, \filter_freq, (i*7+60).midicps, \trig, 1, \texture_dur, 2, \texture_speed, 1, \attack, 0.01, \rq, 0.001, \pan, i/5], ~microglia, \addToHead)});
)
)



