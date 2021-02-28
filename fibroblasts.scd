// FIBROBLASTS:
// arg out, trig, texture_speed, dur=15, amp=1.0, buf, bufnum= -1, grain_pb_rate_val=1.0, pos_change_rate=1.0, grain_size;
// EXAMPLE:
// Synth(\fibroblasts, [
//      \out, 0,
//      \trig, 1,
//      \buf, ~grain_buffer,
//      \grain_size, 0.5,
//      \grain_pb_rate_val, 17,
//      \pos_change_rate, 13,
//      \texture_speed, 12,
//      \amp, 0.1
// ]);

(
var stream_length, subdiv;
stream_length = 120;
subdiv = stream_length/40;

~fibroblast_texture_speed = Pseq([
	Prand(List.fill(5, {arg i; (i+1)/10}), subdiv), // ensheathment
	Prand(List.fill(10, {arg i; i+10}), subdiv), // cell death
	Prand(List.fill(5, {arg i; 0.5+(i*0.25)}), subdiv), // cell cycle/genesis/division (repair)
	Prand(List.fill(5, {arg i; 0.5+(i*0.25)}), subdiv), // peptide biosynthesis (repair)
	],
1).asStream;

~fibroblast_grain_size = Pseq([
	Prand(List.fill(5, {arg i; 2.0+(i*0.25)}), subdiv), // ensheathment
	Prand(List.fill(5, {arg i; 1.0+(i*0.1)}), subdiv), // cell death
	Prand(List.fill(5, {arg i; 1.0+(i*0.25)}), subdiv), // cell cycle/genesis/division (repair)
	Prand(List.fill(5, {arg i; 1.0+(i*0.25)}), subdiv), // peptide biosynthesis (repair)
	],
1).asStream;

~fibroblast_amp = Pseq([
	Prand(List.fill(4, {arg i; 0.05+(i*0.025)}), subdiv), // ensheathment
	Prand(List.fill(5, {arg i; 1+(i*0.025)}), subdiv), // cell death
	Prand(List.fill(5, {arg i; 0.05+(i*0.3)}), subdiv), // cell cycle/genesis/division (repair)
	Prand(List.fill(5, {arg i; 0.05+(i*0.3)}), subdiv), // peptide biosynthesis (repair)
	],
1).asStream;

~fibroblast_grain_pb_rate_val = Prand(List.fill(5, {arg i; (i+1)}), stream_length).asStream;
~fibroblast_pos_change_rate = Prand(List.fill(5, {arg i; 0.25+(i*0.25)}), stream_length).asStream;

Routine({
	~fibroblast = Synth(\fibroblasts, [
		\out, 0,
		\trig, 1,
		\dur, stream_length,
		\amp, ~fibroblast_amp,
		\buf, ~grain_buffer,
		\grain_size, ~fibroblast_grain_size,
		\grain_pb_rate_val, ~fibroblast_grain_pb_rate_val,
		\pos_change_rate, ~fibroblast_pos_change_rate,
		\texture_speed, ~fibroblast_texture_speed
	]);
	10.wait;
	loop({
		~fibroblast.set(
			\amp, ~fibroblast_amp,
			\buf, ~grain_buffer,
			\grain_size, ~fibroblast_grain_size,
			\grain_pb_rate_val, ~fibroblast_grain_pb_rate_val,
			\pos_change_rate, ~fibroblast_pos_change_rate,
			\texture_speed, ~fibroblast_texture_speed
		);
		10.wait;
	});

}).play;
)