use_bpm 82

define :piano_note do |note, amp, length|
  use_synth_defaults sustain: length * 0.6, release: length * 0.4
  synth :beep, note: note - 12 + 0, amp: amp * 0.3, transpose: -12
  synth :beep, note: note + 0.04, amp: amp
  synth :piano, note: note, amp: 0.5 * amp, hard: 0.4
  synth :beep, note: note + 12, amp: amp * 0.2
end

define :seq do |n, a, su, sl|
  n.each do |note|
    piano_note note, a.tick, su
    sleep sl
  end
end

a = [:B3, :B3, :G4, :A4, :Fs4, :E4, :D4, :D5]
aa = [1, 1.25, 1.5, 1.75, 1.5, 1.25].ring
b = [:A2, :A3, :E4, :D4, :Fs4, :A4, :D5, :G4, :E4, :A4, :Fs4, :D4]



with_fx :echo, mix: 0.05, phase: 0.5, decay: 2 do
  with_fx :reverb, room: 1, damp: 1 do
    seq a, aa, 1.5, 1
    sleep 6
    seq b, aa, 1.5, 1
    sleep 8
    live_loop :piano do
      ##| seq a, aa, 1.5, 1
      ##| sleep 4
      ##| seq b, aa, 1.5, 1
      ##| sleep 12
      in_thread do
        sleep 4
        with_transpose -12 do
          seq a, aa, 6, 3
        end
      end
      
      seq a.first(4), aa, 1.5, 1
      sleep 2
      seq a.first(4).last(3), aa, 1.5, 1
      sleep 3
      
      ##| sleep 4
      ##| seq b.last(6), aa, 1.5, 1
      ##| sleep 2
      ##| seq b.first(4).last(3), aa, 1.5, 1
      ##| sleep 3
    end
    
    live_loop :baritone do
      stop
      in_thread do
        with_transpose -24 do
          seq a, aa.map{|a| a/2}, 12, 6
        end
      end
      sleep 4
    end
  end
end
