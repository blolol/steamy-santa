module SteamySanta
  class Sorter
    def initialize(io)
      @io = io
    end

    def participants
      @participants ||= shuffled_participants_with_victims
    end

    private

    def csv
      CSV.new(@io, headers: true)
    end

    def csv_rows
      csv.read.select do |row|
        row.field_row?
      end.tap do |rows|
        unless rows.size > 1
          raise NotEnoughParticipantsError
        end
      end
    end

    def participant_from_csv_row(row)
      nickname = row[0]
      email = row[1]
      steam_username = row[2]
      steam_platforms = row[3].split(/\s*,\s*/)
      wearing = row[4]

      Participant.new(nickname, email, steam_username, steam_platforms, wearing)
    end

    def participants_from_csv_rows
      csv_rows.map do |row|
        participant_from_csv_row(row)
      end
    end

    def rotate_participants(participants)
      rotated_indexes = (0...participants.size).to_a
      rotations = participants.size - 1

      rotations.times do
        rotated_indexes << rotated_indexes.shift
      end

      rotated_indexes.map do |index|
        participants[index]
      end
    end

    def shuffled_participants_with_victims
      participants = participants_from_csv_rows.shuffle
      victims = rotate_participants(participants)

      participants.zip(victims).map do |participant, victim|
        participant.victim = victim
      end
    end
  end
end
