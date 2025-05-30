const std = @import("std");
const c = @import("c_api");

pub fn slice_to_cPtr_array(T: type, size: comptime_int, slice: anytype) [size]?*T {
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

        pub fn seek(self: *@This(), c_inputs: [*c][*c]const T, num_channels: i32, input_samples: i32, playback_rate: f64) void {
            switch (T) {
                f32 => c.signalsmith_stretch_float_seek(@ptrCast(self._ptr), c_inputs, num_channels, input_samples, playback_rate),
                f64 => c.signalsmith_stretch_double_seek(@ptrCast(self._ptr), c_inputs, num_channels, input_samples, playback_rate),
                else => unreachable,
            }
        }

        pub fn process(
            self: *@This(),
            c_inputs: [*c][*c]const T,
            num_input_channels: i32,
            input_samples: i32,
            c_outputs: [*c][*c]T,
            num_output_channels: i32,
            output_samples: i32,
        ) void {
            switch (T) {
                f32 => c.signalsmith_stretch_float_process(@ptrCast(self._ptr), c_inputs, num_input_channels, input_samples, c_outputs, num_output_channels, output_samples),
                f64 => c.signalsmith_stretch_double_process(@ptrCast(self._ptr), c_inputs, num_input_channels, input_samples, c_outputs, num_output_channels, output_samples),
                else => unreachable,
            }
        }

        pub fn flush(self: *@This(), c_outputs: [*c][*c]T, num_output_channels: i32, output_samples: i32) void {
            switch (T) {
                f32 => c.signalsmith_stretch_float_flush(@ptrCast(self._ptr), c_outputs, num_output_channels, output_samples),
                f64 => c.signalsmith_stretch_double_flush(@ptrCast(self._ptr), c_outputs, num_output_channels, output_samples),
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
const expect = std.testing.expect;
const log = std.log;

fn testStretch(comptime T: type) !void {
    const allocator = std.testing.allocator;
    const is_f32 = T == f32;
    const MAX_CHANNELS: comptime_int = 2; // Maximum channels for test

    var s = try Stretch(T).init();
    defer s.deinit();

    var s_seed = try Stretch(T).initSeed(if (is_f32) 12345 else 54321);
    defer s_seed.deinit();

    const n_channels: i32 = if (is_f32) 2 else 1;
    const sample_rate: T = if (is_f32) 44100.0 else 48000.0;
    const split_computation: bool = if (is_f32) true else false;

    s.presetDefault(n_channels, sample_rate, split_computation);

    const block_samples = s.blockSamples();
    log.warn("{s} Block Samples: {d}", .{ @typeName(T), block_samples });
    try expect(block_samples > 0);

    const interval_samples = s.intervalSamples();
    log.warn("{s} Interval Samples: {d}", .{ @typeName(T), interval_samples });
    try expect(interval_samples > 0);

    const input_latency = s.inputLatency();
    log.warn("{s} Input Latency: {d}", .{ @typeName(T), input_latency });
    try expect(input_latency >= 0);

    const output_latency = s.outputLatency();
    log.warn("{s} Output Latency: {d}", .{ @typeName(T), output_latency });
    try expect(output_latency >= 0);

    s.reset();

    s.presetCheaper(n_channels, sample_rate, split_computation);

    s.configure(n_channels, 512, 128, false);
    try expect(s.blockSamples() == 512);
    try expect(s.intervalSamples() == 128);

    s.setTransposeFactor(if (is_f32) 1.5 else 0.8, if (is_f32) 0.5 else 0.2);

    s.setTransposeSemitones(if (is_f32) 3.0 else -2.0, if (is_f32) 0.7 else 0.3);

    s.setFormantFactor(if (is_f32) 1.2 else 0.9, if (is_f32) true else false);

    s.setFormantSemitones(if (is_f32) 2.0 else -1.0, if (is_f32) false else true);

    s.setFormantBase(if (is_f32) 1000.0 else 500.0);

    const input_samples_len: i32 = if (is_f32) 1024 else 512;
    const output_samples_len: i32 = if (is_f32) 2048 else 1024;

    const inputs_data_0 = try allocator.alloc(T, input_samples_len);
    defer allocator.free(inputs_data_0);
    mem_set(T, inputs_data_0, 0.1);

    var inputs_slice: []const []T = undefined;
    if (is_f32) {
        const inputs_data_1 = try allocator.alloc(T, input_samples_len);
        defer allocator.free(inputs_data_1);
        mem_set(T, inputs_data_1, 0.2);
        inputs_slice = &.{ inputs_data_0, inputs_data_1 };
    } else {
        inputs_slice = &.{inputs_data_0};
    }

    const c_inputs_array = slice_to_cPtr_array(T, MAX_CHANNELS, @constCast(inputs_slice));

    const outputs_data_0 = try allocator.alloc(T, output_samples_len);
    defer allocator.free(outputs_data_0);
    mem_set(T, outputs_data_0, 0.0);

    var outputs_slice: []const []T = undefined;
    if (is_f32) {
        const outputs_data_1 = try allocator.alloc(T, output_samples_len);
        defer allocator.free(outputs_data_1);
        mem_set(T, outputs_data_1, 0.0);
        outputs_slice = &.{ outputs_data_0, outputs_data_1 };
    } else {
        outputs_slice = &.{outputs_data_0};
    }

    const c_outputs_array = slice_to_cPtr_array(T, MAX_CHANNELS, @constCast(outputs_slice));

    s.seek(@constCast(@ptrCast(&c_inputs_array)), n_channels, input_samples_len, if (is_f32) 1.0 else 0.5);

    s.process(@constCast(@ptrCast(&c_inputs_array)), n_channels, input_samples_len, @constCast(@ptrCast(&c_outputs_array)), n_channels, output_samples_len);
    try expect(outputs_data_0[0] != 0.0);

    const flush_outputs_data_0 = try allocator.alloc(T, output_samples_len);
    defer allocator.free(flush_outputs_data_0);
    mem_set(T, flush_outputs_data_0, 0.0);

    var flush_outputs_slice: []const []T = undefined;
    if (is_f32) {
        const flush_outputs_data_1 = try allocator.alloc(T, output_samples_len);
        defer allocator.free(flush_outputs_data_1);
        mem_set(T, flush_outputs_data_1, 0.0);
        flush_outputs_slice = &.{ flush_outputs_data_0, flush_outputs_data_1 };
    } else {
        flush_outputs_slice = &.{flush_outputs_data_0};
    }

    const c_flush_outputs_array = slice_to_cPtr_array(T, MAX_CHANNELS, flush_outputs_slice);

    s.flush(@constCast(@ptrCast(&c_flush_outputs_array)), n_channels, output_samples_len);

    const version_info = s.version();
    log.warn("{s} Version: {d}.{d}.{d}", .{ @typeName(T), version_info[0], version_info[1], version_info[2] });
    try expect(version_info[0] >= 0);
}

fn mem_set(T: type, slc: []T, val: T) void {
    for (slc) |*s| s.* = val;
}

test "Stretch f32 all functions test" {
    try testStretch(f32);
}

test "Stretch f64 all functions test" {
    try testStretch(f64);
}
