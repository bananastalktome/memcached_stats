class MemcachedStats
  attr_reader :host, :port, :summary, :slabs, :slab_keys
  
  ## Altered code from watsonian/memcache_do gem
  def self.service_connection(command, host, port, &block)
    begin
      data = ''
      sock = TCPSocket.new(host, port)
      sock.print("#{command}\r\n")
      sock.flush
      stats = sock.gets
      while true
        data += stats
        break if ['END', 'OK', 'ERROR'].include? stats.strip
        stats = sock.gets
      end
      sock.close
      data
    rescue => e
      ## ToDo: REVISIT LATER, MAYBE RAISE SOMETHING
      #puts e
    end
  end
  
  def initialize(host = "localhost", port = 11211)
    @host = host
    @port = port.to_i
    @slab_keys = { }
    self
  end
  
  def fetch_stats
    get_summary
    get_slabs
    self
  end
  
  #def inspect
    #[@host, @port, @summary]
  #end

#   # Commented out since I feel (at least at the moment) that it is out of the scope of what
#   #   this gem should do.
#   def flush
#     MemcachedStats.service_connection("flush_all", @host, @port)
#   end
  
  def fetch_all_slab_keys
    get_slabs
    @slabs.each do |slab|
      fetch_single_slab_keys(slab)
    end
    true
  end
  
  
  def fetch_single_slab_keys(slab)
    slab_id = slab.is_a?(Fixnum) ? slab : (slab.is_a?(Array) ? slab.first : nil)
    
    MemcachedStats.service_connection("stats cachedump #{slab_id} 0", @host, @port).sub("END\r\n","").each_line do |line|
      #tmp = line.sub("ITEM ", "").split(" ").first.split(":")
      
      ## ToDo: Colon might not be delineator
      
      tmp = line.match(/ITEM\ (.*?)\ \[(\d*)\ b\;\ (\d*)\ s\]/).to_a[1..-1] # 0:key, 1:size, 2:expires
      #ITEM User:3293:EmailCount [4 b; 1289245903 s]
      #   [size; expires_timestamp]
      
      record_slab_data(tmp, slab_id)
    end
    true
  end


  protected
  
  def get_summary
    stats = []
    MemcachedStats.service_connection("stats", @host, @port).sub("END\r\n","").each_line do |line| 
      stats.push(line.sub("STAT ", "").chomp.split(' ', 2))
    end
    
    @summary = Hash[*stats.flatten]
    @summary["hit_ratio"] = @summary["get_hits"].to_f / @summary["cmd_get"].to_f
    @summary["miss_ratio"] = @summary["get_misses"].to_f / @summary["cmd_get"].to_f
    @summary["request_rate"] = @summary["cmd_get"].to_f / @summary["uptime"].to_i
    @summary["hit_rate"] = @summary["get_hits"].to_f / @summary["uptime"].to_i
    @summary["miss_rate"] = @summary["get_misses"].to_f / @summary["uptime"].to_i
    @summary.freeze
  end
  
  def get_slabs
    @slabs = Hash.new{|h,k| h[k] = {} unless h.frozen? }
    MemcachedStats.service_connection("stats items", @host, @port).sub("END\r\n","").each_line do |line|
      l = (line.sub("STAT items:", "").split(' '))
      k,v = l.first.split(":")
      slabs[k][v] = l.last
    end
    @slabs.freeze
  end
  
  private
  
  def record_slab_data(data, slab_id)
    cache_key = data[0] #data.join(":")
    key = cache_key.split(":")
    first = key.shift
    @slab_keys[first] = { } unless @slab_keys[first]
    pointer = @slab_keys[first]
    while elem = key.shift
      pointer[elem] = { } unless pointer[elem]
      pointer = pointer[elem]
    end
    
    host = @host
    port = @port
    
    pointer.define_singleton_method(:value) do
      Proc.new do
        #a = MemcachedStats.service_connection("get #{cache_key}", host, port).split
        ## a => ["VALUE", "Billy:TestKey", "1", "29", "\x04\bI\"\bHey\x06:", "encoding\"", "US-ASCII", "END"]
        #value = a[4..-4].join(" ")
        #value += "\r#{a[-3]}\r#{a[-2]}"
        
        socket = TCPSocket.new(host, port)
        socket.write("get #{cache_key}\r\n")
        socket.gets
        value = socket.read(data[1].to_i)
        socket.close
        
        begin
          Marshal.load value
        rescue TypeError # Meaning marshalling failed
          value
        end
      end
    end
    
    ## ToDo: Add a delete key method??
    
    #pointer["slab"] = slab_id # Not really useful, I guess
    #pointer["size"] = data[1] # The size (in bytes)
    #pointer["expires"] = data[2] # Unix timestamp of expiration
  end


  def method_missing(method, *arguments, &block)
    if @summary && @summary.key?(method.to_s)
      @summary[method.to_s]
    else
      super
    end
  end

end
