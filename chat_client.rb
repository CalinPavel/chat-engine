%w[a_to_b.fifo b_to_a.fifo].each do |fifo|
  system("mkfifo #{fifo}") unless File.exist?(fifo)
end

Thread.new do
  File.open("b_to_a.fifo", "r") do |fifo|
    loop do
      msg = fifo.gets
      puts "B: #{msg}" unless msg.nil?
    end
  end
end

loop do
  print "Tu (A): "
  input = gets
  File.open("a_to_b.fifo", "w") { |f| f.puts input }
end

