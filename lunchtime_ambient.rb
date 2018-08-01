# Based on Ambient Experiment, by Darin Wilson

use_synth :hollow
with_fx :reverb, mix: 0.7, room: 0.5 do
  
  live_loop :note1 do
    play choose([:D4,:E4]), attack: 6, release: 6
    sleep 8
  end
  
  live_loop :note2 do
    play choose([:Fs4,:G4]), attack: 4, release: 5
    sleep 10
  end
  
  live_loop :note3 do
    play choose([:A4, :Cs5]), attack: 5, release: 5
    sleep 11
  end
  
  live_loop :guitar do
    stop
    sample :guit_e_fifths, rate: -1, amp: 0.5, lpf: 90
    sleep 8
  end
  
  live_loop :drum do
    stop
    with_fx :echo, phase: 2, decay: 0.5 do
      sample :elec_fuzz_tom, rate: 0.05, amp: 0.5, lpf: 90, pan: rrand(-1, 1)
    end
    sleep rrand(6, 12)
  end
  
  c = (chord :E3, :m11).shuffle
  live_loop :piano do
    stop
    with_fx :whammy, mix: 0.8, grainsize: 1 do
      with_synth :piano do
        play_pattern_timed c, 0.5, attack: 0.5, release: 0.25, sustain: 0, amp: 0.5
        sleep 12
      end
    end
  end
end

