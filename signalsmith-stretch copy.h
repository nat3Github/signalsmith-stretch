#ifndef SIGNALSMITH_STRETCH_H
#define SIGNALSMITH_STRETCH_H

#include "signalsmith-linear/stft.h" // https://github.com/Signalsmith-Audio/linear

#include <algorithm>
#include <array>
#include <functional>
#include <limits>
#include <random>
#include <type_traits>
#include <vector>

namespace signalsmith {
namespace stretch {

namespace _impl {
template <bool conjugateSecond = false, typename V>
static std::complex<V> mul(const std::complex<V> &a, const std::complex<V> &b) {

}
template <typename V> static V norm(const std::complex<V> &a) {}
} // namespace _impl

template <typename Sample = float, class RandomEngine = void>
struct SignalsmithStretch {
  static constexpr size_t version[3] = {1, 3, 1};

  SignalsmithStretch() : randomEngine(std::random_device{}()) {}
  SignalsmithStretch(long seed) : randomEngine(seed) {}

  int blockSamples() const { return int(stft.blockSamples()); }
  int intervalSamples() const { return int(stft.defaultInterval()); }
  int inputLatency() const { return int(stft.analysisLatency()); }
  int outputLatency() const {
    return int(stft.synthesisLatency() +
               _splitComputation * stft.defaultInterval());
  }

  void reset() {
    stft.reset(0.1);
    stashedInput = stft.input;
    stashedOutput = stft.output;

    prevInputOffset = -1;
    channelBands.assign(channelBands.size(), Band());
    silenceCounter = 0;
    didSeek = false;
    blockProcess = {};
    freqEstimateWeighted = freqEstimateWeight = 0;
  }

  // Configures using a default preset
  void presetDefault(int nChannels, Sample sampleRate,
                     bool splitComputation = false) {}
  void presetCheaper(int nChannels, Sample sampleRate,
                     bool splitComputation = true) {}

  // Manual setup
  void configure(int nChannels, int blockSamples, int intervalSamples,
                 bool splitComputation = false) {}

  /// Frequency multiplier, and optional tonality limit (as multiple of
  /// sample-rate)
  void setTransposeFactor(Sample multiplier, Sample tonalityLimit = 0) {}
  void setTransposeSemitones(Sample semitones, Sample tonalityLimit = 0) {
    setTransposeFactor(std::pow(2, semitones / 12), tonalityLimit);
  }
  // Sets a custom frequency map - should be monotonically increasing
  void setFreqMap(std::function<Sample(Sample)> inputToOutput) {}

  void setFormantFactor(Sample multiplier, bool compensatePitch = false) {}
  void setFormantSemitones(Sample semitones, bool compensatePitch = false) {}
  // Rough guesstimate of the fundamental frequency, used for formant analysis.
  // 0 means attempting to detect the pitch
  void setFormantBase(Sample baseFreq = 0) { formantBaseFreq = baseFreq; }

  // Provide previous input ("pre-roll"), without affecting the speed
  // calculation.  You should ideally feed it one block-length + one interval
  template <class Inputs>
  void seek(Inputs &&inputs, int inputSamples, double playbackRate) {}

  template <class Inputs, class Outputs>
  void process(Inputs &&inputs, int inputSamples, Outputs &&outputs,
               int outputSamples) {}

  // Read the remaining output, providing no further input.  `outputSamples`
  // should ideally be at least `.outputLatency()`
  template <class Outputs> void flush(Outputs &&outputs, int outputSamples) {}
};

} // namespace stretch
} // namespace signalsmith
#endif // include guard
