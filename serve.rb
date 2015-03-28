#!/usr/bin/env ruby
WEBrick::HTTPServer.new(:Port => 3000, :DocumentRoot => Dir.pwd).start
