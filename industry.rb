define :fade_in do
  (range 0, 1, 0.1).each do |volume|
    set_mixer_control! amp: volume
    sleep 0.5
  end
end

# Welcome to Sonic Pi v3.1
l = 0.6
u = 0.7
t = 0.5
n = 8 * t
s = (u - l) / n
a = (range l,u,2*s) + (range u,l,2*-s)
puts a
live_loop :n do
  with_fx :level do |fx|
    control fx, amp: a.tick * 1
    synth :noise, cutoff: 80, attack: 0, sustain: 0.125, decay: 0, release: 0
    sleep 0.125
  end
end
##| set_mixer_control! amp: 0
##| fade_in

notes = [:G2, :C3, :Cs3, :D3, :F3, :G3, :E3, :D3, :Cs3, :C3, :G2, :r].ring
sleeps = [0.25, 0.5, 0.25, 0.25, 0.25, 0.125, 0.250, 0.25, 0.5, 0.25, 1, 0.01].ring
transposes = [0, 4, 7].ring
live_loop :prophet do
  stop
  idx = tick
  use_synth :prophet
  with_fx :lpf, cutoff: 100 do
    play notes[idx] - transposes[idx / 12], amp: 0.2, sustain: 0.2, release: 0, attack: 0.1
    sleep 0.25
  end
end


# Modify


use_bpm 240
notes = (scale :e3, :minor_pentatonic).shuffle
set_mixer_control! amp: 1
live_loop :foo do
  stop
  use_synth :blade
  with_fx :reverb, reps: 8, room: 1 do
    tick
    co = (line 80, 130, steps: 32).tick(:cutoff)
    play (octs :a3, 3).look, cutoff: co, amp: 6
    play notes.look, amp: 4
    sleep 1
  end
end

##| sync :foo
bass_line = [:E2, :E2, :C2, :C2, :A1, :A1].ring
live_loop :bass do
  stop
  use_synth :prophet
  with_fx :lpf, cutoff: 110, mix: 1.0  do
    play bass_line.tick, sustain: 6, release: 1.5, amp: 2
    play bass_line.look - 3, sustain: 6, release: 1.5, amp: 2
  end
  sleep 8
end

sync :bass

live_loop :bar do
  stop
  tick
  sample :bd_ada if (spread 1, 4).look
  use_synth :tb303
  co = (line 90, 130, steps: 16).look
  r = (line 0.1, 0.5, steps: 64).mirror.look
  play notes.look, release: r, cutoff: co
  sleep 0.5
end


live_loop :cowbell do
  stop
  with_swing -0.5 do
    sample :elec_beep, amp: 3
  end
  sleep 1
end


live_loop :foobell do
  stop
  sync :cowbell
  sleep 5
  4.times do
    sample :elec_beep, amp: 0.125, amp: 3, rate: 2
    sleep 0.5
  end
end

live_loop :mel do
  stop
  sync :bass
  s = play :E6, sustain: 16
  use_synth :dtri
  sleep_time = 0.25
  x = 64
  ranges = ((range 0.3,1, 0.7/8) + (range 1, 0.3, 0.7/8))
  (x - 1).times do
    control s, amp: (ranges.tick)
    sleep sleep_time
  end
  
  ##| sleep 1.5
  ##| play_pattern_timed (scale :E5, :minor_pentatonic), 0.1
  
end

define :fade_out do
  (range 1, 0, 0.1).each do |volume|
    set_mixer_control! amp: volume
    sleep 0.5
  end
end
##| fade_out

