# Welcome to Sonic Pi

#This one uses samples from freesound.com

in_thread do
  loop do
    cue :birb
    with_fx :echo do
      sample "C:/Users/lilit/Music/samples/birdchirp.wav", rate: 0.5, amp: 0.5
      sleep 3
    end
  end
end

in_thread do
  loop do
    cue :guit
    with_fx :distortion do
      sample "C:/Users/lilit/Music/samples/pizzacatosteelstringsguit.wav", rate: 0.5, amp: 0.1
      sleep 1
    end
  end
end

define :selectChord do
  in_thread do
    loop do
      cue :guit_default
      with_fx :echo do
        sample [:guit_harmonics, :guit_e_fifths, :guit_e_slide, :guit_em9].choose, amp: (line 0, 1, steps: 5).tick
        sleep 3
      end
    end
  end
end

live_loop :mel do
  use_synth [:prophet, :piano, :pluck].choose
  play (ring :C2, :Eb4, :g4, :G, :D, :d4, :b4, :C).choose, cutoff: rrand(60, 120)
  selectChord
  sync_bpm 120
  #sleep (ring 0.25, 0.5, 0.75, 0.80).tick
end