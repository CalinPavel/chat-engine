%w[a_to_b.fifo b_to_a.fifo].each do |fifo|
  system("mkfifo #{fifo}") unless File.exist?(fifo)
end

Thread.new do
  File.open("a_to_b.fifo", "r") do |fifo|
    loop do
      msg = fifo.gets
      puts "A: #{msg}" unless msg.nil?
    end
  end
end

loop do
  print "Tu (B): "
  input = gets
  File.open("b_to_a.fifo", "w") { |f| f.puts input }
end

