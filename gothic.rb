# Chord Inversions

# Coded by Adrian Cheater

# (in a single tweet)
# https://twitter.com/wpgFactoid/status/666692596605976576
reverb_mix = 0.7
reverb_room = 0.6

drums = [0, 1, 0, 1, 1, 0, 0, 1, 0, 1, 0, 1].ring
cymbal = [1, 1, 0, 1].ring
live_loop :beats do
  with_fx :reverb, mix: reverb_mix, room: reverb_room do
    sample :drum_heavy_kick
    sleep 0.5
    sample :drum_cymbal_hard, amp: cymbal.tick * 0.5, sustain: 0.25, threshold: 80
    sleep 0.5
  end
end

live_loop :top do
  with_fx :reverb, mix: reverb_mix, room: reverb_room do
    sync :beats
    drums.each do |d|
      sample :drum_bass_hard, amp: drums.tick, rate: 0.5, sustain: 0.0075
      sleep 0.25
    end
  end
end

##| pulse_amps = [0.05, 0.1].ring
##| mnotes = [0, 0, 4, 7, 4, 1, 2, 7, 4].ring
##| live_loop :pulser do
##|   stop
##|   with_fx :reverb, mix: reverb_mix, room: reverb_room do
##|     sync :beats
##|     amp = pulse_amps.tick
##|     note = mnotes.tick
##|     puts note
##|     synth :tb303, note: :E4 + note, amp: amp, sustain: 0.2,  attack: 0, release: 0
##|     sleep 0.25
##|     synth :tb303, note: :E4, amp: amp, sustain: 0.2, attack: 0, release: 0
##|   end
##| end

live_loop :melody_maybe do
  sync :beats
  amp = 0.025
  cutoff = 80
  with_synth :tb303 do
    play_pattern_timed (chord :E4, :m7), 0.25, amp: amp, sustain: 0.25, release: 0, attack: 0, cutoff: cutoff
    play :E4 + 3, amp: amp, sustain: 0.25, release: 0, attack: 0, cutoff: cutoff
  end
end


live_loop :bass do
  with_fx :reverb, mix: reverb_mix, room: reverb_room do
    sync :beats
    with_fx :slicer do
      synth :tb303, note: :E1 + 0, amp: 0.15, sustain: 0.5
      sleep 0.5
    end
  end
end

live_loop :rand_surfer do
  sync :beats
  use_random_seed 1
  #stop
  use_synth :dsaw
  notes = (scale :e2, :minor_pentatonic, num_octaves: 2)
  15.times do
    play notes.choose, release: 0.1, cutoff: rrand(70, 120), amp: 0.35
    sleep 0.125
  end
  play notes.choose, release: 0.1, cutoff: rrand(70, 120), amp: 0.35
end

