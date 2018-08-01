# Welcome to Sonic Pi v3.1

use_bpm 190
use_synth :fm

define :bass_note do |note|
  play note, amp: 1, attack: 0.0, sustain: 0.75, release: 0.1
end

live_loop :main do
  sleep 16
end

define :bass_main do
  w = 1.5
  ##| sync :main
  sleep 1
  4.times do
    bass_note :Fs2
    sleep w
  end
  bass_note :E3
  sleep w/3
  bass_note :Fs3
  sleep w
  4.times do
    bass_note :Fs2
    sleep w
  end
  bass_note :E2
  sleep w/3
  bass_note :F2
end

live_loop :bass_loop do
  stop
  sync :main
  bass_main
end

define :drum_main do
  s = :drum_bass_soft
  7.times do
    sample s
    sleep 2
  end
  sample s
end

live_loop :drums do
  stop
  sync :main
  drum_main
end

l1 = [:Fs4, :Fs4, :Fs3, :Fs3, :Fs3, :Fs3]
l2 = [:Fs4, :Fs4, :Fs3, :Fs3]
l2f = [:Fs4, :Fs4, :Fs3]

define :synth_main do
  use_synth :prophet
  [l1, l1, l2].each do |loop|
    loop.each do |note|
      play note, amp: 0.2, sustain: 0.15
      sleep 0.5
    end
  end
  [l1, l1, l2f].each do |loop|
    loop.each do |note|
      play note, amp: 0.2, sustain: 0.15
      sleep 0.5
    end
  end
  play :Fs3, amp: 0.2, sustain: 0.15
end
live_loop :synth_loop do
  stop
  sync :main
  synth_main
end

##| play_chord [:Fs4, :A4, :Cs5, :Fs5], sustain: 2.5
##| sleep 3
##| play_chord [:E4, :Gs4, :B4, :E5], sustain: 2.5
##| sleep 3
##| play_chord [:Ds4, :Fs4, :B4], sustain: 2.5
##| sleep 3
##| play_chord [:Fs4, :A4, :Cs5, :Fs5], sustain: 2.5
##| sleep 3
##| play_chord [:E4, :Gs4, :B4, :E5], sustain: 2.5
##| sleep 3

define :piano_main do
  play (chord :Fs4, :minor), sustain: 3
  sleep 3
  play (chord :e4, :major, invert: 0), sustain: 3
  sleep 3
  play (chord :b3, :major, invert: 1), sustain: 3
  sleep 3
  play (chord :Fs4, :minor, invert: 0), sustain: 3
  sleep 3
  play (chord :Fs4, :minor, invert: 0), sustain: 2
  sleep 2
  play (chord :e4, :major, invert: 0), sustain: 2
end

define :background do
  sync :main
  in_thread do
    drum_main
  end
  bass_main
end

define :intro do
  sync :main
  background
  sync :main
  in_thread do
    synth_main
  end
  in_thread do
    play (chord :Fs4, :minor), release: 16
  end
  in_thread do
    background
  end
  
  4.times do
    sync :main
    in_thread do
      synth_main
    end
    in_thread do
      piano_main
    end
    background
  end
  
end


live_loop :piano do
  stop
  sync :main
  piano_main
end

intro