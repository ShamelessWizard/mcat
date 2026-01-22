# mcat

Safe cat-like utility that writes stdin to a file.  
Creates parent directories if needed.  
Uses temporary file + atomic mv for safe overwrites.  
Optional diff preview and confirmation before replacing content.

## Installation

From the repository root (where bin/mcat exists):

    chmod +x install.sh
    sudo ./install.sh

This installs mcat to /usr/local/bin/mcat with executable permissions.

To uninstall later:

    sudo rm /usr/local/bin/mcat

After installation you can run it from anywhere:

    mcat -h

## Usage

mcat [-o|-a] [-d] [-f] [-i] <file>

Options:  
  -o          Overwrite the file (default)  
  -a          Append to the file  
  -d          Show unified diff preview before overwriting + ask to confirm (only in overwrite mode)  
  -f          Force — skip confirmation even when -d is used  
  -i          Preserve original file permissions when overwriting  
  -h          Show help

## Examples

Basic overwrite (creates directories if needed)

    echo "Hello, world!" | mcat config/hello.txt

Append to a log in deep path

    date '+%Y-%m-%d %H:%M:%S - Event' | mcat -a logs/$(date +%Y/%m/%d).log

Safe in-place sort with diff and confirmation

    sort -u hosts.txt | mcat -o -d hosts.txt
    # Shows diff then asks: Apply changes? [Y/n]

Diff preview but no prompt

    jq '.users += ["alice"]' config.json | mcat -o -d -f config.json

Overwrite while preserving permissions

    generate-new-config | mcat -o -i -d server.conf
    # Keeps original chmod (e.g. 600, 755)

Creating a new file (shows note instead of diff)

    cat <<EOF | mcat -o -d new-project/README.md
    # My Project

    Starting fresh.
    EOF

Classic safe replacement

    grep -v '^#' nginx.conf | mcat -o nginx.conf

## License

GPL-3.0-or-later

Copyright © 2026 Cassius

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.
