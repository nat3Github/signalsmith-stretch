const std = @import("std");
const c = @import("c_api");

pub fn slice_to_cPtr_array(T: type, size: comptime_int, slice: [][]T) [size]?*T {
    var c_inputs_array: [size]?*T = undefined;
    for (0..slice.len) |i| {
        c_inputs_array[i] = @ptrCast(slice[i].ptr);
    }
    return c_inputs_array;
}

pub fn Stretch(T: type) type {
    return struct {
        _ptr: switch (T) {
            f32 => *c.SignalsmithStretch_float,
            f64 => *c.SignalsmithStretch_double,
            else => unreachable,
        },

        pub fn init() !@This() {
            const ptr = switch (T) {
                f32 => c.signalsmith_stretch_float_new(),
                f64 => c.signalsmith_stretch_double_new(),
                else => unreachable,
            };
            if (ptr == null) {
                return error.InitStretch;
            }
            return @This(){
                ._ptr = ptr.?,
            };
        }

        pub fn initSeed(seed: i64) !@This() {
            const ptr = switch (T) {
                f32 => c.signalsmith_stretch_float_new_seed(seed),
                f64 => c.signalsmith_stretch_double_new_seed(seed),
                else => unreachable,
            };
            if (ptr == null) {
                return error.InitStretch;
            }
            return @This(){
                ._ptr = ptr.?,
            };
        }

        pub fn deinit(self: *@This()) void {
            switch (T) {
                f32 => c.signalsmith_stretch_float_delete(@ptrCast(self._ptr)),
                f64 => c.signalsmith_stretch_double_delete(@ptrCast(self._ptr)),
                else => unreachable,
            }
        }

        pub fn blockSamples(self: *const @This()) i32 {
            return switch (T) {
                f32 => c.signalsmith_stretch_float_blockSamples(@ptrCast(self._ptr)),
                f64 => c.signalsmith_stretch_double_blockSamples(@ptrCast(self._ptr)),
                else => unreachable,
            };
        }

        pub fn intervalSamples(self: *const @This()) i32 {
            return switch (T) {
                f32 => c.signalsmith_stretch_float_intervalSamples(@ptrCast(self._ptr)),
                f64 => c.signalsmith_stretch_double_intervalSamples(@ptrCast(self._ptr)),
                else => unreachable,
            };
        }

        pub fn inputLatency(self: *const @This()) i32 {
            return switch (T) {
                f32 => c.signalsmith_stretch_float_inputLatency(@ptrCast(self._ptr)),
                f64 => c.signalsmith_stretch_double_inputLatency(@ptrCast(self._ptr)),
                else => unreachable,
            };
        }

        pub fn outputLatency(self: *const @This()) i32 {
            return switch (T) {
                f32 => c.signalsmith_stretch_float_outputLatency(@ptrCast(self._ptr)),
                f64 => c.signalsmith_stretch_double_outputLatency(@ptrCast(self._ptr)),
                else => unreachable,
            };
        }

        pub fn reset(self: *@This()) void {
            switch (T) {
                f32 => c.signalsmith_stretch_float_reset(@ptrCast(self._ptr)),
                f64 => c.signalsmith_stretch_double_reset(@ptrCast(self._ptr)),
                else => unreachable,
            }
        }

        pub fn presetDefault(self: *@This(), n_channels: i32, sample_rate: T, split_computation: bool) void {
            switch (T) {
                f32 => c.signalsmith_stretch_float_presetDefault(@ptrCast(self._ptr), n_channels, sample_rate, split_computation),
                f64 => c.signalsmith_stretch_double_presetDefault(@ptrCast(self._ptr), n_channels, sample_rate, split_computation),
                else => unreachable,
            }
        }

        pub fn presetCheaper(self: *@This(), n_channels: i32, sample_rate: T, split_computation: bool) void {
            switch (T) {
                f32 => c.signalsmith_stretch_float_presetCheaper(@ptrCast(self._ptr), n_channels, sample_rate, split_computation),
                f64 => c.signalsmith_stretch_double_presetCheaper(@ptrCast(self._ptr), n_channels, sample_rate, split_computation),
                else => unreachable,
            }
        }

        pub fn configure(self: *@This(), n_channels: i32, block_samples: i32, interval_samples: i32, split_computation: bool) void {
            switch (T) {
                f32 => c.signalsmith_stretch_float_configure(@ptrCast(self._ptr), n_channels, block_samples, interval_samples, split_computation),
                f64 => c.signalsmith_stretch_double_configure(@ptrCast(self._ptr), n_channels, block_samples, interval_samples, split_computation),
                else => unreachable,
            }
        }

        pub fn setTransposeFactor(self: *@This(), multiplier: T, tonality_limit: T) void {
            switch (T) {
                f32 => c.signalsmith_stretch_float_setTransposeFactor(@ptrCast(self._ptr), multiplier, tonality_limit),
                f64 => c.signalsmith_stretch_double_setTransposeFactor(@ptrCast(self._ptr), multiplier, tonality_limit),
                else => unreachable,
            }
        }

        pub fn setTransposeSemitones(self: *@This(), semitones: T, tonality_limit: T) void {
            switch (T) {
                f32 => c.signalsmith_stretch_float_setTransposeSemitones(@ptrCast(self._ptr), semitones, tonality_limit),
                f64 => c.signalsmith_stretch_double_setTransposeSemitones(@ptrCast(self._ptr), semitones, tonality_limit),
                else => unreachable,
            }
        }

        pub fn setFormantFactor(self: *@This(), multiplier: T, compensate_pitch: bool) void {
            switch (T) {
                f32 => c.signalsmith_stretch_float_setFormantFactor(@ptrCast(self._ptr), multiplier, compensate_pitch),
                f64 => c.signalsmith_stretch_double_setFormantFactor(@ptrCast(self._ptr), multiplier, compensate_pitch),
                else => unreachable,
            }
        }

        pub fn setFormantSemitones(self: *@This(), semitones: T, compensate_pitch: bool) void {
            switch (T) {
                f32 => c.signalsmith_stretch_float_setFormantSemitones(@ptrCast(self._ptr), semitones, compensate_pitch),
                f64 => c.signalsmith_stretch_double_setFormantSemitones(@ptrCast(self._ptr), semitones, compensate_pitch),
                else => unreachable,
            }
        }

        pub fn setFormantBase(self: *@This(), base_freq: T) void {
            switch (T) {
                f32 => c.signalsmith_stretch_float_setFormantBase(@ptrCast(self._ptr), base_freq),
                f64 => c.signalsmith_stretch_double_setFormantBase(@ptrCast(self._ptr), base_freq),
                else => unreachable,
            }
        }

        pub fn seek(self: *@This(), inputs: []const []const T, input_samples: i32, playback_rate: f64) void {
            const num_channels: i32 = @intCast(inputs.len);
            var c_inputs: [1024]?*const T = undefined;
            for (inputs, 0..) |channel_slice, i| {
                if (i >= c_inputs.len) {
                    @panic("Too many input channels for fixed-size C array.");
                }
                c_inputs[i] = channel_slice.ptr;
            }
            switch (T) {
                f32 => c.signalsmith_stretch_float_seek(@ptrCast(self._ptr), @ptrCast(&c_inputs), num_channels, input_samples, playback_rate),
                f64 => c.signalsmith_stretch_double_seek(@ptrCast(self._ptr), @ptrCast(&c_inputs), num_channels, input_samples, playback_rate),
                else => unreachable,
            }
        }

        pub fn process(self: *@This(), inputs: []const []const T, outputs: [][]T, input_samples: i32, output_samples: i32) void {
            const num_input_channels: i32 = @intCast(inputs.len);
            const num_output_channels: i32 = @intCast(outputs.len);

            var c_inputs: [1024]?*const T = undefined;
            for (inputs, 0..) |channel_slice, i| {
                if (i >= c_inputs.len) {
                    @panic("Too many input channels for fixed-size C array.");
                }
                c_inputs[i] = channel_slice.ptr;
            }

            var c_outputs: [1024]?*T = undefined;
            for (outputs, 0..) |channel_slice, i| {
                if (i >= c_outputs.len) {
                    @panic("Too many output channels for fixed-size C array.");
                }
                c_outputs[i] = channel_slice.ptr;
            }

            switch (T) {
                f32 => c.signalsmith_stretch_float_process(
                    @ptrCast(self._ptr),
                    @ptrCast(&c_inputs),
                    num_input_channels,
                    input_samples,
                    @ptrCast(&c_outputs),
                    num_output_channels,
                    output_samples,
                ),
                f64 => c.signalsmith_stretch_double_process(
                    @ptrCast(self._ptr),
                    @ptrCast(&c_inputs),
                    num_input_channels,
                    input_samples,
                    @ptrCast(&c_outputs),
                    num_output_channels,
                    output_samples,
                ),
                else => unreachable,
            }
        }

        pub fn flush(self: *@This(), outputs: [][]T, output_samples: i32) void {
            const num_output_channels: i32 = @intCast(outputs.len);
            var c_outputs: [1024]?*T = undefined;
            for (outputs, 0..) |channel_slice, i| {
                if (i >= c_outputs.len) {
                    @panic("Too many output channels for fixed-size C array.");
                }
                c_outputs[i] = channel_slice.ptr;
            }
            switch (T) {
                f32 => c.signalsmith_stretch_float_flush(@ptrCast(self._ptr), @ptrCast(&c_outputs), num_output_channels, output_samples),
                f64 => c.signalsmith_stretch_double_flush(@ptrCast(self._ptr), @ptrCast(&c_outputs), num_output_channels, output_samples),
                else => unreachable,
            }
        }

        pub fn version(_: *const @This()) [3]usize {
            var major: usize = 0;
            var minor: usize = 0;
            var patch: usize = 0;
            switch (T) {
                f32 => c.signalsmith_stretch_float_version(&major, &minor, &patch),
                f64 => c.signalsmith_stretch_double_version(&major, &minor, &patch),
                else => unreachable,
            }
            return .{ major, minor, patch };
        }
    };
}

const root = @This();

test "Stretch f32 basic usage" {
    var s = try Stretch(f32).init();
    defer s.deinit();

    const n_channels: i32 = 1;
    const sample_rate: f32 = 44100.0;
    const split_computation: bool = false;
    s.presetDefault(n_channels, sample_rate, split_computation);

    std.debug.print("Block Samples: {d}\n", .{s.blockSamples()});
    std.debug.print("Interval Samples: {d}\n", .{s.intervalSamples()});
    std.debug.print("Input Latency: {d}\n", .{s.inputLatency()});
    std.debug.print("Output Latency: {d}\n", .{s.outputLatency()});

    const version_info = s.version();
    std.debug.print("Version: {d}.{d}.{d}\n", .{ version_info[0], version_info[1], version_info[2] });
}
