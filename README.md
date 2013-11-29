**Note:** This is old code kept in the `old-scripts` branch for posterity. [Check out master](https://github.com/blolol/steamy-santa) for the latest in Steamy Santa development.

---

These are scripts for choosing and delivering Perkele Steamy Santa partners.

### Usage

1. Rename `config.example.yml` to `config.yml` and customize it.
2. Feed CSV data to `sort.rb` with the following columns:
   1. Timestamp
   2. Friendly name
   3. Steam username
   4. Preferred Steam platform
   5. Email address
   6. (Ignored)
   7. Saucy description of what you're wearing
3. Feed `sort.rb`'s YAML output to `deliver.rb`. Use `--deliver` to actually send emails.

### License <small>(MIT)</small>

<small>Copyright © 2011 Ross Paffett.</small>

<small>Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:</small>

<small>The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.</small>

<small>THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.</small>
