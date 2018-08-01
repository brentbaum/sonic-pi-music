progression = [
  (chord :B3, :minor),
  (chord :C3, :major),
  (chord :F3, :major),
  (chord :E3, :minor)
].ring


live_loop :prog do
  stop
  4.times do
    play_pattern_timed progression.tick, 0.25
    sleep 0.5
  end
end

live_loop :pulse do
  
  sync :prog
  use_synth :noise
  play 40, sustain: 0.25, release: 1.5, amp: 0.25
  sleep 0.5
  play 60, sustain: 0.05, amp: 0.25
  sleep 0.5
  play 60, sustain: 0.05, amp: 0.25
  sleep 1.25
  finish = [0, 1, 0, 1, 0, 1, 1, 1, 1].ring
  finish.each do |amp|
    sleep 0.25
    play 60, sustain: 0.05, release: 0, amp: 0.25 * amp
  end
end

melody = [:B5, :B4].ring

live_loop :mel do
  stop
  sync :prog
  15.times do
    play melody.pick, sustain: 0.1, amp: 0.25
    sleep 0.25
  end
end