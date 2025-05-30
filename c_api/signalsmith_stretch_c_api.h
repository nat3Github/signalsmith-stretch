#ifndef SIGNALSMITH_STRETCH_C_API_H
#define SIGNALSMITH_STRETCH_C_API_H

#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

typedef struct SignalsmithStretch_float SignalsmithStretch_float;
typedef struct SignalsmithStretch_double SignalsmithStretch_double;

void signalsmith_stretch_float_version(size_t *major, size_t *minor,
                                       size_t *patch);
void signalsmith_stretch_double_version(size_t *major, size_t *minor,
                                        size_t *patch);

SignalsmithStretch_float *signalsmith_stretch_float_new();
SignalsmithStretch_float *signalsmith_stretch_float_new_seed(long seed);
void signalsmith_stretch_float_delete(SignalsmithStretch_float *instance);
int signalsmith_stretch_float_blockSamples(
    const SignalsmithStretch_float *instance);
int signalsmith_stretch_float_intervalSamples(
    const SignalsmithStretch_float *instance);
int signalsmith_stretch_float_inputLatency(
    const SignalsmithStretch_float *instance);
int signalsmith_stretch_float_outputLatency(
    const SignalsmithStretch_float *instance);
void signalsmith_stretch_float_reset(SignalsmithStretch_float *instance);
void signalsmith_stretch_float_presetDefault(SignalsmithStretch_float *instance,
                                             int nChannels, float sampleRate,
                                             bool splitComputation);
void signalsmith_stretch_float_presetCheaper(SignalsmithStretch_float *instance,
                                             int nChannels, float sampleRate,
                                             bool splitComputation);
void signalsmith_stretch_float_configure(SignalsmithStretch_float *instance,
                                         int nChannels, int blockSamples,
                                         int intervalSamples,
                                         bool splitComputation);
void signalsmith_stretch_float_setTransposeFactor(
    SignalsmithStretch_float *instance, float multiplier, float tonalityLimit);
void signalsmith_stretch_float_setTransposeSemitones(
    SignalsmithStretch_float *instance, float semitones, float tonalityLimit);
void signalsmith_stretch_float_setFormantFactor(
    SignalsmithStretch_float *instance, float multiplier, bool compensatePitch);
void signalsmith_stretch_float_setFormantSemitones(
    SignalsmithStretch_float *instance, float semitones, bool compensatePitch);
void signalsmith_stretch_float_setFormantBase(
    SignalsmithStretch_float *instance, float baseFreq);
void signalsmith_stretch_float_seek(SignalsmithStretch_float *instance,
                                    const float **inputs_channels,
                                    int num_channels, int inputSamples,
                                    double playbackRate);
void signalsmith_stretch_float_process(SignalsmithStretch_float *instance,
                                       const float **inputs_channels,
                                       int num_input_channels, int inputSamples,
                                       float **outputs_channels,
                                       int num_output_channels,
                                       int outputSamples);
void signalsmith_stretch_float_flush(SignalsmithStretch_float *instance,
                                     float **outputs_channels,
                                     int num_output_channels,
                                     int outputSamples);

SignalsmithStretch_double *signalsmith_stretch_double_new();
SignalsmithStretch_double *signalsmith_stretch_double_new_seed(long seed);
void signalsmith_stretch_double_delete(SignalsmithStretch_double *instance);
int signalsmith_stretch_double_blockSamples(
    const SignalsmithStretch_double *instance);
int signalsmith_stretch_double_intervalSamples(
    const SignalsmithStretch_double *instance);
int signalsmith_stretch_double_inputLatency(
    const SignalsmithStretch_double *instance);
int signalsmith_stretch_double_outputLatency(
    const SignalsmithStretch_double *instance);
void signalsmith_stretch_double_reset(SignalsmithStretch_double *instance);
void signalsmith_stretch_double_presetDefault(
    SignalsmithStretch_double *instance, int nChannels, double sampleRate,
    bool splitComputation);
void signalsmith_stretch_double_presetCheaper(
    SignalsmithStretch_double *instance, int nChannels, double sampleRate,
    bool splitComputation);
void signalsmith_stretch_double_configure(SignalsmithStretch_double *instance,
                                          int nChannels, int blockSamples,
                                          int intervalSamples,
                                          bool splitComputation);
void signalsmith_stretch_double_setTransposeFactor(
    SignalsmithStretch_double *instance, double multiplier,
    double tonalityLimit);
void signalsmith_stretch_double_setTransposeSemitones(
    SignalsmithStretch_double *instance, double semitones,
    double tonalityLimit);
void signalsmith_stretch_double_setFormantFactor(
    SignalsmithStretch_double *instance, double multiplier,
    bool compensatePitch);
void signalsmith_stretch_double_setFormantSemitones(
    SignalsmithStretch_double *instance, double semitones,
    bool compensatePitch);
void signalsmith_stretch_double_setFormantBase(
    SignalsmithStretch_double *instance, double baseFreq);
void signalsmith_stretch_double_seek(SignalsmithStretch_double *instance,
                                     const double **inputs_channels,
                                     int num_channels, int inputSamples,
                                     double playbackRate);
void signalsmith_stretch_double_process(
    SignalsmithStretch_double *instance, const double **inputs_channels,
    int num_input_channels, int inputSamples, double **outputs_channels,
    int num_output_channels, int outputSamples);
void signalsmith_stretch_double_flush(SignalsmithStretch_double *instance,
                                      double **outputs_channels,
                                      int num_output_channels,
                                      int outputSamples);

#ifdef __cplusplus
}
#endif

#endif