require 'socket'


Dir["#{File.dirname(__FILE__) + '/memcached_stats'}/**/*"].each do |filter|
  require "#{filter}"
end

#rake gemspec && rake build && rake install && irb
#require 'memcached_stats'; a = MemcachedMultiStats.new([{:hostname => "localhost", :port => 11211}, {:hostname => "beta.my.umbc.edu", :port => 11211}]); a.fetch_stats