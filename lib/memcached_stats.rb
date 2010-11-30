require 'socket'


Dir["#{File.dirname(__FILE__) + '/memcached_stats'}/**/*"].each do |filter|
  require "#{filter}"
end

