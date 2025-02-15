!#/usr/bin/env ruby

PROC_NET_TCP = '/proc/net/tcp'  # This should always be the same ...

TCP_STATES = {
 '00' => 'UNKNOWN',  # Bad state ... Impossible to achieve ...
     'FF' => 'UNKNOWN',  # Bad state ... Impossible to achieve ...
     '01' => 'ESTABLISHED',
     '02' => 'SYN_SENT',
     '03' => 'SYN_RECV',
     '04' => 'FIN_WAIT1',
     '05' => 'FIN_WAIT2',
     '06' => 'TIME_WAIT',
     '07' => 'CLOSE',
     '08' => 'CLOSE_WAIT',
     '09' => 'LAST_ACK',
     '0A' => 'LISTEN',
     '0B' => 'CLOSING'
}

SINGLE_ENTRY_PATTERN = Regexp.new(
    /^\s*\d+:\s+(.{8}):(.{4})\s+(.{8}):(.{4})\s+(.{2})/
)

File.open(PROC_NET_TCP).each do |i|
    i = i.strip
      if match = i.match(SINGLE_ENTRY_PATTERN)
      local_IP = match[1].to_i(16)
      local_IP = [local_IP].pack("N").unpack("C4").reverse.join('.')
      local_port = match[2].to_i(16)
      remote_IP = match[3].to_i(16)
      remote_IP = [remote_IP].pack("N").unpack("C4").reverse.join('.')
      remote_port = match[4].to_i(16)
      connection_state = match[5]
      connection_state = TCP_STATES[connection_state]
      puts "#{local_IP}:#{local_port} " +
      "#{remote_IP}:#{remote_port} #{connection_state}"
      end
end

exit(0)
      end
end
