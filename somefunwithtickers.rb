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

in_thread do
  live_loop :birbloop do
    cue :birbs
    with_fx :bitcrusher do |btcrsh|
      sample "C:/Users/lilit/Music/samples/birdchirp.wav", rate: 0.5, amp: 0.5, release: 0.1
      sleep get[:arr]
      control btcrsh, mix: 0.3
      #birbs are birbing. Let's add random timeouts tho
      #sync_bpm bpm_for_this
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
  live_loop :dj_booth do
    with_fx :distortion do |dstrshn|
      s = sample :bass_dnb_f #I know that single char name vars suck btw
      a = sample :vinyl_rewind
      b = sample :drum_cymbal_open
      c = sample :drum_splash_hard
      d = sample :misc_crow
      y = sample :mehackit_phone4
      cr = sample :ambi_lunar_land
      cl = sample :guit_harmonics
      fd = sample :elec_soft_kick
      rring = (ring s, a, b, c, d, cr, y, cl, fd).mirror.stretch(10)
      puts rring.pick(get[:arr]), release: [0.3, 0.1].choose, pan: rrand(-1, 1)
      sleep get[:arr]
      control dstrshn, mix: 0.1, phase: 0.01
      #sync_bpm bpm_for_this
    end
  end
end

#default samples go brrrrrr
#now with more whooosh



