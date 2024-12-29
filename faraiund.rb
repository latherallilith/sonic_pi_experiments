in_thread do
  loop do
    sample :ambi_dark_woosh
    sleep 0.1
  end
end
in_thread do
  with_fx :echo do
    loop do
      sample :ambi_haunted_hum
      sleep 0.3
    end
  end
  in_thread do
    loop do
      sample :elec_chime
      sleep 0.8
    end
  end
end
