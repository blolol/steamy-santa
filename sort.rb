require "csv"
require "logger"
require "yaml"

data_path = File.expand_path(ARGV[0]) || "test.csv"
@logger = Logger.new(STDOUT)

def log(message)
  @logger.info(message)
end

log "Welcome to the #{Time.now.year} Perkele Steamy Santa magic sorting hat!"

people = []
index = -1

CSV.foreach(data_path) do |row|
  # Skip the header row
  if index < 0
    index += 1
    next
  end
  
  people << {
    :id => index,
    :nick => row[1].to_s,
    :steam => row[2].to_s,
    :platform => row[3].to_s,
    :email => row[4].to_s,
    :details => row[6].to_s,
    :victim => index
  }
  
  index += 1
end

log "We have #{people.size} victims--er, participants--this year."
log "Commencing devious sorting algorithm..."

unique = proc do |person|
  victim = people.find { |p| person[:victim] == p[:id] }
  person[:id] != person[:victim] &&
  victim[:victim] != person[:id]
end

until people.all?(&unique) do
  ids = people.collect { |person| person[:id] }.sort_by { rand }
  people.each_with_index do |person, i|
    person[:victim] = ids[i]
  end
end

people.each do |person|
  victim = people.find { |p| person[:victim] == p[:id] }
  log "  #{person[:nick]} will send a gift to #{victim[:nick]}."
end

log "Sorting complete!"

output_path = data_path.sub(/csv$/, "yml")
File.open(output_path, "w") do |f|
  YAML.dump(people, f)
end

log "Results deviously written to #{output_path}!"
