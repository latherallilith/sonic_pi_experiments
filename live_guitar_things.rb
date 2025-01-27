# Define getters and setters for arrays/rings
define :melodic_samples do
  @melodic_samples ||= [:bass_hard_c, :bass_woodsy_c, :bass_dnb_f, :bass_trance_c]
end

define :drum_samples do
  @drum_samples ||= [:drum_cymbal_pedal, :drum_roll, :drum_cymbal_soft, :drum_cymbal_hard]
end

define :vari_samples_pretty do
  #will try few options
  @piano_samples ||= [:ambi_piano,:elec_chime,:ambi_glass_hum]
end

define :rhythmic_pattern do
  @rhythmic_pattern ||= (ring 0.5, 0.75, 1, 1.2, 1.3, [0.35, 0.6].choose)
end

define :echo_phases do
  @echo_phases ||= [0.25, 0.5, 0.75]
end

define :synth_scale_notes do
  @scale_notes ||= (scale :e3, :minor_pentatonic)
end

# Threads with modular access to defined variables
in_thread do
  loop do
    cue :guit
    with_fx :gverb do
      sample melodic_samples.choose,
        amp: (line 1, 5, steps: 5).tick,
        rate: [0.5, 1, 1.5, 2].choose
      sync "/cue/drums"
    end
  end
end

in_thread do
  loop do
    cue :vari_noice
    with_fx :echo do
      sample vari_samples_pretty.choose,
        amp: (line 1, 5, steps: 5).tick,
        rate: [0.5, 1, 1.5, 2].choose
      sync "/cue/drums"
    end
  end
end

in_thread do
  loop do
    cue :tick
    # Use the defined rhythmic pattern
    sleep rhythmic_pattern.tick
  end
end

in_thread do
  loop do
    cue :drums
    with_fx :echo, phase: echo_phases.choose do |ech|
      sample drum_samples.choose,
        amp: (line 1, 5, steps: 5).tick
      sync :tick
      control ech, amp: 0.7, mix: [0.5, 0.6, 0.8].choose, decay: [0.5, 1, 1.5].choose
    end
  end
end

in_thread do
  loop do
    cue :live_guit
    with_fx :reverb do
      with_fx :distortion do |dstrshn|
        # Use sound input for the electric guitar
        synth :sound_in_stereo, note: scale_notes.choose,
          sustain: [0.2, 0.5, 1].choose, release: 0.3
        control dstrshn, mix: 0.5, phase: [0.1, 0.3, 1.5].choose
      end
    end
    sync "/cue/drums"
  end
end

in_thread do
  loop do
    cue :synth
    with_fx :reverb do
        # Use the defined scale for melody
        synth :sound_in_stereo, note: scale_notes.choose,
          sustain: [0.2, 0.5, 1].choose, release: 0.3
      end
    end
    sync "/cue/drums"
  end
end


