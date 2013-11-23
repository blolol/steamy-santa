### Steamy Santa

Each year, Blolol holds a Steamy Santa event, in which moderately-willing participants torture their friends by gifting the worst-looking game they can find on [Steam](http://steampowered.com).

Participants sign up through a Google Form. Their responses are exported to a CSV and fed to these tools to choose victims and notify everyone via email.

### Usage

Get the code.

    git clone https://github.com/blolol/steamy-santa.git

Rename `config/settings.example.json` to `config/settings.json` and edit it.

    cp config/settings.example.json config/settings.json

Prepare CSV data about your participants formatted like this:

    Nickname, Email address, Steam username, Steam platforms, What you're wearing
    Raws, raws@example.com, rawsosaurus, "Mac, Windows", "High heels, suspenders and a bra."

Pipe the CSV data to `bin/steamy-santa sort` to sort participants and choose victims. Save the JSON output to a file.

    bin/steamy-santa sort < responses.csv > victims.json

Pipe the JSON data to `bin/steamy-santa notify` to deliver emails to participants. This command does a dry run by default. Use `--no-dry-run` to actually deliver the emails.

### License

Copyright (c) 2013 Blolol. MIT licensed.
