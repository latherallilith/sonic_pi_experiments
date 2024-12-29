# Welcome to Sonic Pi

# Crushed Acid

# Coded by Sam Aaron, modified by LateralLilith(lilislilit)

use_debug true
load_sample :bd_fat
g_sleep = 5
g_phase = 0.4

in_thread do
  loop do
    with_fx :distortion do
      sample [:guit_harmonics, :guit_em9, :guit_e_slide].choose, amp: (line 0, 5, steps: 5).tick
      sleep 1
    end
  end
end

live_loop :drums do
  sample :bass_hit_c, amp: 1.3
  sleep [1, 4, 6, 5, 1, 5, 8].choose
end

live_loop :acid do
  cue :foo
  with_fx :autotuner do
    loop do |i|
      use_random_seed 556
      128.times do
        use_synth :tb303
        play chord(:a3, :sus4, :add9, :madd9, :dim7,  :minor, :augumented, :major).choose,
          cutoff: rrand(40, 100), amp: 0.5, attack: 0, release: rrand(1, 2),
          cutoff_max: 110
        sleep 0.5
      end
    end
  end
  
  cue :bar
  loop do |i|
    use_synth :tb303
    play chord(:a3, :minor, :dim7, :minor).choose, attack: 0, release: 0.05, cutoff: rrand_i(70, 80) + i, res: rrand(0.7, 0.95)
    sleep 0.5
  end
  
  cue :baz
  with_fx :reverb, mix: 0.3 do |r|
    with_fx(:echo, delay: 0.45, decay: 1) do
      68.times do |m|
        control r, mix: 0.3 + (0.5 * (m.to_f / 32.0)) unless m == 0 if m % 8 == 0
        use_synth :prophet
        play chord((ring '+5', 'm7b5', '1', :major7, :e3, :minor).mirror.shuffle()).choose,
          attack: 0, release: 0.08, cutoff: rrand_i(110, 130)
        sleep 0.125
      end
    end
  end
  
  cue :quux
  in_thread do
    loop do
      use_random_seed 668
      with_fx :distortion, phase: g_phase do
        8.times do
          use_synth :tb303
          play chord(:e3, :minor).choose, attack: 0.5, release: 0.1, cutoff: rrand(50, 70)
          sleep 0.25
        end
      end
    end
  end
  sleep g_sleep
end