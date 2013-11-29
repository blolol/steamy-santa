# Deliver Steamy Santa emails
# Usage: ruby deliver.rb [--deliver] path/to/partners.yml

require "erb"
require "logger"
require "pony"
require "yaml"

def log(*args)
  level = args.first.is_a?(Symbol) ? args.shift : :info
  @logger.send(level, args.join(" "))
end

@options = ARGV.select { |arg| arg =~ /^\-+\w+/ }
@args = ARGV - @options

if @args.size >= 1
  @config = YAML.load_file(File.join(File.dirname(__FILE__), "config.yml"))
  @people = YAML.load_file(File.expand_path(@args[0]))
  @deliver = @options.include?("--deliver")
  @logger = Logger.new(STDOUT)
else
  STDERR.puts "usage: ruby deliver.rb [--deliver] path/to/partners.yml"
  exit 1
end

log "Welcome to the #{Time.now.year} Perkele Steamy Santa magic postman!"
log "This is a dry run. To actually deliver messages, use --deliver." unless @deliver

template = ERB.new(@config["body"], nil, "%<>")
@people.each do |person|
  @person = person
  @victim = @people.find { |p| person[:victim] == p[:id] }
  
  from = @config["from"]
  subject = @config["subject"]
  body = template.result
  
  Pony.mail({
    :to => person[:email],
    :from => from,
    :subject => subject,
    :body => body,
    :via => :smtp,
    :via_options => @config["via"]
  }) if @deliver
  
  puts
  log "From: #{from}"
  log "To: #{person[:nick]} <#{person[:email]}>"
  log "Subject: #{subject}"
end

puts
log "Ho, ho, ho! Merry Steamy Santa!"
