def main
  $queue = { 1 => [], 0 => [] }

  proc_a = DuetProcess.new(0)
  proc_b = DuetProcess.new(1)
  while true do
    break if proc_a.is_stopped? && proc_b.is_stopped?
    proc_b.run
    proc_a.run
  end
  puts "Proc 0 sent: #{proc_a.times_sent} times"
  puts "Proc 1 sent: #{proc_b.times_sent} times"
  puts $queue.inspect
end

class DuetProcess
  @@lines = IO.read("duet_input.txt").split("\n")

  def initialize(process_id)
    @stopped = false
    @program_counter = 0
    @process_id = process_id
    @times_sent = 0
    @registers = { "p" => process_id }
  end

  def run
    @stopped = false
    puts "Process #{@process_id} STARTED"
    begin
      line = @@lines[@program_counter].split(" ")
    rescue
      @stopped = true
      puts "Process #{@process_id} STOPPED"
      return
    end
    if line.length == 2
      send(line[0], line[1])
    else
      send(line[0], line[1], get_value(line[2]))
    end
  end

  def is_stopped?
    return @stopped
  end

  def times_sent
    @times_sent
  end

  private

  def get_value(arg)
    begin
      Integer(arg)
    rescue => exception
      @registers[arg] || 0
    end
  end

  def snd(value)
    x = begin
      Integer(value)
    rescue => exception
      @registers[value] || 0
    end
    log_detailed "snd #{value} (#{x})"

    send_to = @process_id == 0 ? 1 : 0
    $queue[send_to] << x

    @program_counter += 1
    @times_sent += 1
  end

  def set(register, value)
    #log_detailed "set #{register} #{value}"
    @registers[register] = value
    @program_counter += 1
  end

  def add(register, value)
    #log_detailed "add #{register} #{value}"
    @registers[register] += value
    @program_counter += 1
  end

  def mul(register, value)
    #log_detailed "mul #{register} #{value}"
    @registers[register] = (@registers[register] || 0) * value
    @program_counter += 1
  end

  def mod(register, value)
    #log_detailed "mod #{register} #{value}"
    @registers[register] = @registers[register] % value
    @program_counter += 1
  end

  def jgz(arg_1, offset)
    x = begin
      Integer(arg_1)
    rescue => exception
      @registers[arg_1] || 0
    end

    log_detailed "jgz #{arg_1} (#{x}) #{offset}"
    if x > 0
      @program_counter += offset
    else
      @program_counter += 1
    end
  end

  def rcv(register)
    log_detailed "rcv #{register}"

    if $queue[@process_id].length == 0
      @stopped = true
      puts "Process #{@process_id} STOPPED"
      log_detailed $queue.inspect
      return
    end

    @registers[register] == $queue[@process_id].shift
    @program_counter += 1
  end

  def log_detailed(x)
    puts("PID: #{@process_id}\tPC: #{@program_counter}\t#{@registers.inspect}\t#{x}")
  end
end


main
