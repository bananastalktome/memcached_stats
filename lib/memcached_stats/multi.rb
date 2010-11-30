class MemcachedMultiStats < MemcachedStats
  attr_reader :hosts, :summary, :slabs, :slab_keys

  def initialize(host = [] )
    @slab_keys = { }
    @summary = { }
    @slabs = { }
    @hosts = []
    host.each do |h|
      identifier = h.key?(:key) ? h[:key] : h[:hostname]
      @hosts.push(MemcachedStats.new(h[:hostname], h[:port], identifier))
    end
  end
  
  def fetch_stats
    cycle_hosts do |host|
      @summary[host.identifier] = host.get_summary
      @slabs[host.identifier] = host.get_slabs
    end
    self
  end
  
  def inspect
    @hosts
  end
  
#   def flush
#     cycle_hosts do |host|
#       host.flush
#     end
#   end
  
  def fetch_all_slab_keys
    cycle_hosts do |host|
      @slabs[host.identifier].each do |slab|
        host.fetch_single_slab_keys(slab)
      end
      #Code Smells Here...
      @slab_keys.merge! host.slab_keys
    end
    true
  end

  
  private
  
  def cycle_hosts(&block)
    @hosts.each do |host|
      @current_host = host
      block.call(host)
    end
  end

  def method_missing(method, *arguments, &block)
    cycle_hosts do |host|
      if @summary[host.identifier].key?(method.to_s)
        @summary[host.identifier][method.to_s]
      end
    end
  end  
end
