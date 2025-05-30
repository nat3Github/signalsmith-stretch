const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});
    const cpp_flags = &.{
        "-std=c++11",
        "-fno-rtti",
    };
    const dep_signalsmith_linear = b.dependency("signalsmith_linear", .{});

    const module = b.addModule("signalsmith_stretch", .{
        .root_source_file = b.path("zig-src/root.zig"),
        .target = target,
        .optimize = optimize,
        .link_libc = true,
        .link_libcpp = true,
    });

    const translate_c = b.addTranslateC(.{
        .link_libc = true,
        .optimize = optimize,
        .root_source_file = b.path("c_api/signalsmith_stretch_c_api.h"),
        .target = target,
        .use_clang = true,
    });
    const c_module = translate_c.createModule();
    c_module.addCSourceFile(.{
        .file = b.path("c_api/signalsmith_stretch_c_api.cpp"),
        .language = .cpp,
        .flags = cpp_flags,
    });

    c_module.addIncludePath(b.path("include"));
    c_module.addIncludePath(dep_signalsmith_linear.path("include"));
    c_module.addIncludePath(dep_signalsmith_linear.path(""));
    module.addImport("c_api", c_module);

    // const audioeffectx_h = b.path("zig-src/shim/");
    // const audioeffectx_cpp = b.path("zig-src/shim/audioeffect.cpp");
    // module.addIncludePath(audioeffectx_h.dirname());
    // module.addCSourceFile(.{
    //     .file = audioeffectx_cpp,
    //     .language = .cpp,
    //     .flags = cpp_flags,
    // });

    const test_c = b.addTest(.{
        .optimize = optimize,
        .target = target,
        .root_module = module,
    });

    const test_run = b.addRunArtifact(test_c);
    const test_step = b.step("test", "Run unit tests");
    test_step.dependOn(&test_run.step);
}
