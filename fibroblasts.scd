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
~fibroblast_texture_speed = Prand(List.fill(5, {arg i; (i+1)}), 65).asStream;
~fibroblast_grain_size = Prand(List.fill(5, {arg i; 0.25+(i*0.25)}), 65).asStream;
~fibroblast_amp = Prand(List.fill(4, {arg i; 0.05+(i*0.025)}), 65).asStream;
~fibroblast_grain_pb_rate_val = Prand(List.fill(5, {arg i; (i+1)}), 65).asStream;
~fibroblast_pos_change_rate = Prand(List.fill(5, {arg i; 0.25*(i*0.25)}), 65).asStream;

Routine({
	~fibroblast = Synth(\fibroblasts, [
		\out, 0,
		\trig, 1,
		\dur, 120,
		\amp, ~fibroblast_amp,
		\buf, ~grain_buffer,
		\grain_size, ~fibroblast_grain_size,
		\grain_pb_rate_val, ~fibroblast_grain_pb_rate_val,
		\pos_change_rate, ~fibroblast_pos_change_rate,
		\texture_speed, ~fibroblast_texture_speed
	]);
	3.wait;
	loop({
		~fibroblast.set(
			\amp, ~fibroblast_amp,
			\buf, ~grain_buffer,
			\grain_size, ~fibroblast_grain_size,
			\grain_pb_rate_val, ~fibroblast_grain_pb_rate_val,
			\pos_change_rate, ~fibroblast_pos_change_rate,
			\texture_speed, ~fibroblast_texture_speed
		);
		3.wait;
	})
}).play;
)