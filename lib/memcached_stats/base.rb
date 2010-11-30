class MemcachedStats
  attr_reader :host, :port, :identifier, :summary, :slabs, :slab_keys

  def initialize(host = "localhost", port = 11211, identifier = nil)
    @host = host
    @port = port.to_i
    @identifier = identifier.nil? ? host : identifier
    @slab_keys = { }
    self
  end
  
  
  def fetch_stats
    @summary = get_summary
    @slabs = get_slabs
    self
  end
  
  def inspect
    [@host, @port, @summary]
  end
  
  def flush
    service_connection("flush_all")
  end
  
  def fetch_all_slab_keys
    slabs.each do |slab|
      fetch_single_slab_keys(slab)
    end
  end
  
  
  def fetch_single_slab_keys(slab)
    slab_id = slab.is_a?(Fixnum) ? slab : (slab.is_a?(Array) ? slab.first : nil)
    
    service_connection("stats cachedump #{slab_id} 0").sub("END\r\n","").each_line do |line|
      # TODO: Colon might not be delineator 
      tmp = line.sub("ITEM ", "").split(" ").first.split(":")
      record_slab_data(tmp, slab_id)
    end
    true
  end
  
  protected
  
  def get_summary
    a = Hash[*service_connection("stats").sub("END\r\n","").each_line.inject([]){|arr, line| arr.push(line.sub("STAT ", "").split(' '))}.flatten]
    a["hit_ratio"] = a["get_hits"].to_f / a["cmd_get"].to_f
    a["miss_ratio"] = a["get_misses"].to_f / a["cmd_get"].to_f
    a["request_rate"] = a["cmd_get"].to_f / a["uptime"].to_i
    a["hit_rate"] = a["get_hits"].to_f / a["uptime"].to_i
    a["miss_rate"] = a["get_misses"].to_f / a["uptime"].to_i
    a
  end
  
  def get_slabs
    slabs = Hash.new{|h,k| h[k] = {} }
    service_connection("stats items").sub("END\r\n","").each_line do |line|
      l = (line.sub("STAT items:", "").split(' '))
      k,v = l.first.split(":")
      slabs[k][v] = l.last
    end
    slabs
  end
  
  private
  
  def record_slab_data(data, slab_id)
    first = data.shift
    @slab_keys[first] = { } unless @slab_keys[first]
    pointer = @slab_keys[first]
    while elem = data.shift
      pointer[elem] = { } unless pointer[elem]
      pointer = pointer[elem]
    end
    pointer["slab"] = slab_id
    pointer["host"] = @identifier
  end
  
  
  #`stats cachedump SLAB_ID 0` (0 means no limit)

  def service_connection(command, &block)
    begin
      data = ''
      sock = TCPSocket.new(@host, @port)
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
      # TODO: REVISIT LATER, MAYBE RAISE SOMETHING
      puts e
    end
  end


  def method_missing(method, *arguments, &block)
    if @summary.key?(method.to_s)
      @summary[method.to_s]
    else
      super
    end
  end

end
