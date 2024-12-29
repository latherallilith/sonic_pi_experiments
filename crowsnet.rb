#Crow`s Nets
in_thread do
  loop do
    play_chord choose([[62,55,86],[55,66,88],[20,42,100]]), amp: 1.1
    sleep rrand(1,100)
  end
end
in_thread do
  loop do
    s = synth [:pretty_bell, :pluck, :chipbass, :pulse,
               :dull_bell,:blade, :blade, :pluck, :hoover, :pluck, :blade,
               :growl, :blade, :pluck].choose, amp: rrand(0.5, 1.5), attack: rrand(0, 1), cutoff_slide: rrand(0, 5), cutoff: rrand(60, 100), pan: rrand(-1, 1), pan_slide: 1
    control s, pan: rrand(-1, 1), cutoff: rrand(69, 120)
    sleep rrand(0.5, 3)
  end
end
in_thread do
  loop do
    with_fx :whammy do
      s = sample :bass_dnb_f
      a = sample :vinyl_rewind
      b = sample :drum_heavy_kick
      c = sample :drum_splash_hard
      d = sample :drum_bass_hard
      y = sample :glitch_robot1
      cr = sample :misc_crow
      cl = sample :bd_boom
      fd = sample :elec_soft_kick
      rring = (ring s, a, b, c, d, cr, y, cl, fd).mirror.stretch(3)
      puts rring.pick([3,1,7,5,2].choose), pan: rrand(-1, 1)
      sleep [3, 4, 6].choose
    end
  end
end

in_thread do
  loop do
    with_fx :bitcrusher do
      bn = sample :misc_crow
      control bn, pan: rrand(-1, 1)
      sleep 3
    end
  end
end
