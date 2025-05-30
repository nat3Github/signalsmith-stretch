#include "signalsmith-stretch/signalsmith-stretch.h"
#include "signalsmith_stretch_c_api.h"

#include <algorithm>
#include <stdexcept>
#include <vector>

template <typename Sample>
std::vector<std::vector<Sample>>
create_audio_buffer_from_c(const Sample **channels, int num_channels,
                           int samples_per_channel) {
  if (!channels || num_channels <= 0 || samples_per_channel <= 0) {
    return {};
  }

  std::vector<std::vector<Sample>> buffer(num_channels);
  for (int i = 0; i < num_channels; ++i) {
    if (!channels[i]) {
      throw std::runtime_error(
          "Null channel pointer encountered for C API input.");
    }
    buffer[i].assign(channels[i], channels[i] + samples_per_channel);
  }
  return buffer;
}

template <typename Sample>
void copy_audio_buffer_to_c(const std::vector<std::vector<Sample>> &buffer,
                            Sample **channels, int num_channels,
                            int samples_per_channel) {
  if (!channels) {
    return;
  }
  for (int i = 0; i < num_channels; ++i) {
    if (i < buffer.size() && channels[i]) {
      std::copy(buffer[i].begin(), buffer[i].end(), channels[i]);
    }
  }
}

void signalsmith_stretch_float_version(size_t *major, size_t *minor,
                                       size_t *patch) {
  if (major)
    *major = signalsmith::stretch::SignalsmithStretch<float>::version[0];
  if (minor)
    *minor = signalsmith::stretch::SignalsmithStretch<float>::version[1];
  if (patch)
    *patch = signalsmith::stretch::SignalsmithStretch<float>::version[2];
}

void signalsmith_stretch_double_version(size_t *major, size_t *minor,
                                        size_t *patch) {
  if (major)
    *major = signalsmith::stretch::SignalsmithStretch<double>::version[0];
  if (minor)
    *minor = signalsmith::stretch::SignalsmithStretch<double>::version[1];
  if (patch)
    *patch = signalsmith::stretch::SignalsmithStretch<double>::version[2];
}

SignalsmithStretch_float *signalsmith_stretch_float_new() {
  return reinterpret_cast<SignalsmithStretch_float *>(
      new signalsmith::stretch::SignalsmithStretch<float>());
}

SignalsmithStretch_float *signalsmith_stretch_float_new_seed(long seed) {
  return reinterpret_cast<SignalsmithStretch_float *>(
      new signalsmith::stretch::SignalsmithStretch<float>(seed));
}

void signalsmith_stretch_float_delete(SignalsmithStretch_float *instance) {
  delete reinterpret_cast<signalsmith::stretch::SignalsmithStretch<float> *>(
      instance);
}

int signalsmith_stretch_float_blockSamples(
    const SignalsmithStretch_float *instance) {
  return reinterpret_cast<
             const signalsmith::stretch::SignalsmithStretch<float> *>(instance)
      ->blockSamples();
}

int signalsmith_stretch_float_intervalSamples(
    const SignalsmithStretch_float *instance) {
  return reinterpret_cast<
             const signalsmith::stretch::SignalsmithStretch<float> *>(instance)
      ->intervalSamples();
}

int signalsmith_stretch_float_inputLatency(
    const SignalsmithStretch_float *instance) {
  return reinterpret_cast<
             const signalsmith::stretch::SignalsmithStretch<float> *>(instance)
      ->inputLatency();
}

int signalsmith_stretch_float_outputLatency(
    const SignalsmithStretch_float *instance) {
  return reinterpret_cast<
             const signalsmith::stretch::SignalsmithStretch<float> *>(instance)
      ->outputLatency();
}

void signalsmith_stretch_float_reset(SignalsmithStretch_float *instance) {
  reinterpret_cast<signalsmith::stretch::SignalsmithStretch<float> *>(instance)
      ->reset();
}

void signalsmith_stretch_float_presetDefault(SignalsmithStretch_float *instance,
                                             int nChannels, float sampleRate,
                                             bool splitComputation) {
  reinterpret_cast<signalsmith::stretch::SignalsmithStretch<float> *>(instance)
      ->presetDefault(nChannels, sampleRate, splitComputation);
}

void signalsmith_stretch_float_presetCheaper(SignalsmithStretch_float *instance,
                                             int nChannels, float sampleRate,
                                             bool splitComputation) {
  reinterpret_cast<signalsmith::stretch::SignalsmithStretch<float> *>(instance)
      ->presetCheaper(nChannels, sampleRate, splitComputation);
}

void signalsmith_stretch_float_configure(SignalsmithStretch_float *instance,
                                         int nChannels, int blockSamples,
                                         int intervalSamples,
                                         bool splitComputation) {
  reinterpret_cast<signalsmith::stretch::SignalsmithStretch<float> *>(instance)
      ->configure(nChannels, blockSamples, intervalSamples, splitComputation);
}

void signalsmith_stretch_float_setTransposeFactor(
    SignalsmithStretch_float *instance, float multiplier, float tonalityLimit) {
  reinterpret_cast<signalsmith::stretch::SignalsmithStretch<float> *>(instance)
      ->setTransposeFactor(multiplier, tonalityLimit);
}

void signalsmith_stretch_float_setTransposeSemitones(
    SignalsmithStretch_float *instance, float semitones, float tonalityLimit) {
  reinterpret_cast<signalsmith::stretch::SignalsmithStretch<float> *>(instance)
      ->setTransposeSemitones(semitones, tonalityLimit);
}

void signalsmith_stretch_float_setFormantFactor(
    SignalsmithStretch_float *instance, float multiplier,
    bool compensatePitch) {
  reinterpret_cast<signalsmith::stretch::SignalsmithStretch<float> *>(instance)
      ->setFormantFactor(multiplier, compensatePitch);
}

void signalsmith_stretch_float_setFormantSemitones(
    SignalsmithStretch_float *instance, float semitones, bool compensatePitch) {
  reinterpret_cast<signalsmith::stretch::SignalsmithStretch<float> *>(instance)
      ->setFormantSemitones(semitones, compensatePitch);
}

void signalsmith_stretch_float_setFormantBase(
    SignalsmithStretch_float *instance, float baseFreq) {
  reinterpret_cast<signalsmith::stretch::SignalsmithStretch<float> *>(instance)
      ->setFormantBase(baseFreq);
}

void signalsmith_stretch_float_seek(SignalsmithStretch_float *instance,
                                    const float **inputs_channels,
                                    int num_channels, int inputSamples,
                                    double playbackRate) {
  auto cpp_inputs =
      create_audio_buffer_from_c(inputs_channels, num_channels, inputSamples);
  reinterpret_cast<signalsmith::stretch::SignalsmithStretch<float> *>(instance)
      ->seek(cpp_inputs, inputSamples, playbackRate);
}

void signalsmith_stretch_float_process(SignalsmithStretch_float *instance,
                                       const float **inputs_channels,
                                       int num_input_channels, int inputSamples,
                                       float **outputs_channels,
                                       int num_output_channels,
                                       int outputSamples) {
  auto cpp_inputs = create_audio_buffer_from_c(
      inputs_channels, num_input_channels, inputSamples);

  std::vector<std::vector<float>> cpp_outputs(num_output_channels);
  for (int i = 0; i < num_output_channels; ++i) {
    cpp_outputs[i].resize(outputSamples);
  }

  reinterpret_cast<signalsmith::stretch::SignalsmithStretch<float> *>(instance)
      ->process(cpp_inputs, inputSamples, cpp_outputs, outputSamples);

  copy_audio_buffer_to_c(cpp_outputs, outputs_channels, num_output_channels,
                         outputSamples);
}

void signalsmith_stretch_float_flush(SignalsmithStretch_float *instance,
                                     float **outputs_channels,
                                     int num_output_channels,
                                     int outputSamples) {
  std::vector<std::vector<float>> cpp_outputs(num_output_channels);
  for (int i = 0; i < num_output_channels; ++i) {
    cpp_outputs[i].resize(outputSamples);
  }

  reinterpret_cast<signalsmith::stretch::SignalsmithStretch<float> *>(instance)
      ->flush(cpp_outputs, outputSamples);

  copy_audio_buffer_to_c(cpp_outputs, outputs_channels, num_output_channels,
                         outputSamples);
}

SignalsmithStretch_double *signalsmith_stretch_double_new() {
  return reinterpret_cast<SignalsmithStretch_double *>(
      new signalsmith::stretch::SignalsmithStretch<double>());
}

SignalsmithStretch_double *signalsmith_stretch_double_new_seed(long seed) {
  return reinterpret_cast<SignalsmithStretch_double *>(
      new signalsmith::stretch::SignalsmithStretch<double>(seed));
}

void signalsmith_stretch_double_delete(SignalsmithStretch_double *instance) {
  delete reinterpret_cast<signalsmith::stretch::SignalsmithStretch<double> *>(
      instance);
}

int signalsmith_stretch_double_blockSamples(
    const SignalsmithStretch_double *instance) {
  return reinterpret_cast<
             const signalsmith::stretch::SignalsmithStretch<double> *>(instance)
      ->blockSamples();
}

int signalsmith_stretch_double_intervalSamples(
    const SignalsmithStretch_double *instance) {
  return reinterpret_cast<
             const signalsmith::stretch::SignalsmithStretch<double> *>(instance)
      ->intervalSamples();
}

int signalsmith_stretch_double_inputLatency(
    const SignalsmithStretch_double *instance) {
  return reinterpret_cast<
             const signalsmith::stretch::SignalsmithStretch<double> *>(instance)
      ->inputLatency();
}

int signalsmith_stretch_double_outputLatency(
    const SignalsmithStretch_double *instance) {
  return reinterpret_cast<
             const signalsmith::stretch::SignalsmithStretch<double> *>(instance)
      ->outputLatency();
}

void signalsmith_stretch_double_reset(SignalsmithStretch_double *instance) {
  reinterpret_cast<signalsmith::stretch::SignalsmithStretch<double> *>(instance)
      ->reset();
}

void signalsmith_stretch_double_presetDefault(
    SignalsmithStretch_double *instance, int nChannels, double sampleRate,
    bool splitComputation) {
  reinterpret_cast<signalsmith::stretch::SignalsmithStretch<double> *>(instance)
      ->presetDefault(nChannels, sampleRate, splitComputation);
}

void signalsmith_stretch_double_presetCheaper(
    SignalsmithStretch_double *instance, int nChannels, double sampleRate,
    bool splitComputation) {
  reinterpret_cast<signalsmith::stretch::SignalsmithStretch<double> *>(instance)
      ->presetCheaper(nChannels, sampleRate, splitComputation);
}

void signalsmith_stretch_double_configure(SignalsmithStretch_double *instance,
                                          int nChannels, int blockSamples,
                                          int intervalSamples,
                                          bool splitComputation) {
  reinterpret_cast<signalsmith::stretch::SignalsmithStretch<double> *>(instance)
      ->configure(nChannels, blockSamples, intervalSamples, splitComputation);
}

void signalsmith_stretch_double_setTransposeFactor(
    SignalsmithStretch_double *instance, double multiplier,
    double tonalityLimit) {
  reinterpret_cast<signalsmith::stretch::SignalsmithStretch<double> *>(instance)
      ->setTransposeFactor(multiplier, tonalityLimit);
}

void signalsmith_stretch_double_setTransposeSemitones(
    SignalsmithStretch_double *instance, double semitones,
    double tonalityLimit) {
  reinterpret_cast<signalsmith::stretch::SignalsmithStretch<double> *>(instance)
      ->setTransposeSemitones(semitones, tonalityLimit);
}

void signalsmith_stretch_double_setFormantFactor(
    SignalsmithStretch_double *instance, double multiplier,
    bool compensatePitch) {
  reinterpret_cast<signalsmith::stretch::SignalsmithStretch<double> *>(instance)
      ->setFormantFactor(multiplier, compensatePitch);
}

void signalsmith_stretch_double_setFormantSemitones(
    SignalsmithStretch_double *instance, double semitones,
    bool compensatePitch) {
  reinterpret_cast<signalsmith::stretch::SignalsmithStretch<double> *>(instance)
      ->setFormantSemitones(semitones, compensatePitch);
}

void signalsmith_stretch_double_setFormantBase(
    SignalsmithStretch_double *instance, double baseFreq) {
  reinterpret_cast<signalsmith::stretch::SignalsmithStretch<double> *>(instance)
      ->setFormantBase(baseFreq);
}

void signalsmith_stretch_double_seek(SignalsmithStretch_double *instance,
                                     const double **inputs_channels,
                                     int num_channels, int inputSamples,
                                     double playbackRate) {
  auto cpp_inputs =
      create_audio_buffer_from_c(inputs_channels, num_channels, inputSamples);
  reinterpret_cast<signalsmith::stretch::SignalsmithStretch<double> *>(instance)
      ->seek(cpp_inputs, inputSamples, playbackRate);
}

void signalsmith_stretch_double_process(
    SignalsmithStretch_double *instance, const double **inputs_channels,
    int num_input_channels, int inputSamples, double **outputs_channels,
    int num_output_channels, int outputSamples) {
  auto cpp_inputs = create_audio_buffer_from_c(
      inputs_channels, num_input_channels, inputSamples);
  std::vector<std::vector<double>> cpp_outputs(num_output_channels);
  for (int i = 0; i < num_output_channels; ++i) {
    cpp_outputs[i].resize(outputSamples);
  }

  reinterpret_cast<signalsmith::stretch::SignalsmithStretch<double> *>(instance)
      ->process(cpp_inputs, inputSamples, cpp_outputs, outputSamples);

  copy_audio_buffer_to_c(cpp_outputs, outputs_channels, num_output_channels,
                         outputSamples);
}

void signalsmith_stretch_double_flush(SignalsmithStretch_double *instance,
                                      double **outputs_channels,
                                      int num_output_channels,
                                      int outputSamples) {
  std::vector<std::vector<double>> cpp_outputs(num_output_channels);
  for (int i = 0; i < num_output_channels; ++i) {
    cpp_outputs[i].resize(outputSamples);
  }

  reinterpret_cast<signalsmith::stretch::SignalsmithStretch<double> *>(instance)
      ->flush(cpp_outputs, outputSamples);

  copy_audio_buffer_to_c(cpp_outputs, outputs_channels, num_output_channels,
                         outputSamples);
}