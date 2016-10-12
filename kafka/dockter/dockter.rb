#!/usr/local/bin/ruby
require 'rubylabs'
include ElizaLab

Eliza.load :doctor

@query = $stdin.gets
$stdout.puts Eliza.transform(@query)
exit
