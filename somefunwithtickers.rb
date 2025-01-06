# Welcome to Sonic Pi with Lateral Lilith :)
#learning ticking and loops
#I am in the caffee shop, so... No microphone for this one :(


#counter = 0
#live_loop :birbs do
#play (scale :c2, :lydian_minor, :major_pentatonic) [counter], release: 0.1
# counter += 1
#The boops are booping and beeping
#hmmm. Lets use some samples again tho
#sleep 0.125
#end

bpm_for_this = 100
set :arr, [0.1,0.2,0.3,4, 5].choose
SAMPLE_PATH = "C:/Users/lilit/Music/"

define :random_sample do
  sample SAMPLE_PATH + ["samples/birdchirp.wav", "samples/cfmach.wav", "switch-on-and-off.mp3"].choose, rate: rrand(0.5, 1.5), amp: rrand(0.5, 1.5), release: rrand(0.1, 1.5)
end

in_thread do
  live_loop :birbloop do
    cue :birbs
    with_fx :bitcrusher do |btcrsh|
      sample SAMPLE_PATH + "samples/birdchirp.wav", rate: 0.5, amp: 0.5, release: 0.1
      sleep get[:arr]
      control btcrsh, mix: 0.3
      #birbs are birbing. Let's add random timeouts tho
      #sync_bpm bpm_for_this
    end
  end
end

in_thread do
  live_loop :coffeeloop do
    cue :coffee
    with_fx :bitcrusher do |btcrsh|
      sample SAMPLE_PATH + "samples/cfmach.wav", rate: 0.1, amp: 1.5, release: choose([0.1, 1.5, 0.01])
      sleep get[:arr]
      control btcrsh, mix: 0.9
      #adding some coffeeshop ambience
    end
  end
end


in_thread do
  counter = 0
  live_loop :synth do
    use_synth [:blade, :prophet, :piano, :pluck, :pretty_bell].choose
    play (ring :c3, :e4, :c2) [counter], release: 0.1
    play_pattern_timed chord(:e3, :maj11), get[:arr], release: 0.1
    sync_bpm bpm_for_this
  end
end

in_thread do
  live_loop :dynamic_bpm do
    use_bpm rrand(80, 120)
    sync :birbs #hmmm... using copilot for suggestions here, but ehhh...
    random_sample
    sleep get[:arr]
  end
end

in_thread do
  live_loop :dj_booth do
    with_fx :distortion do |dstrshn|
      sb = sample :bass_dnb_f #I know that single char name vars suck btw
      av = sample :vinyl_rewind #so now they are 2 letter names ;)
      bn = sample :drum_cymbal_open
      ca = sample :elec_pop
      ds = sample :misc_crow
      ys = sample :elec_plip
      cr = sample :ambi_lunar_land
      cl = sample :guit_harmonics
      fd = sample :elec_soft_kick
      rring = (ring sb, av, bn, ca, ds, cr, ys, cl, fd).mirror.stretch(10)
      puts rring.pick(get[:arr]), release: [0.3, 0.1].choose, pan: rrand(-1, 1)
      sleep get[:arr]
      control dstrshn, mix: 0.1, phase: 0.024
    end
  end
end

#default samples go brrrrrr
#now with more whooosh



