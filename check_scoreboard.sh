#!/bin/bash
## NOTICE
# Dirty quick script to track the NPST2020 scoreboard. Buy me a beer :))

## CONSTANTS
SCOREBOARD_URL="https://dass.npst.no/.netlify/functions/scoreboard"
SCRIPT_PATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

## GOGO
echo "Starting script..."
cd $SCRIPT_PATH # dirty

# Download newest scoreboard
wget -q "$SCOREBOARD_URL" -O "$SCRIPT_PATH/scoreboard.min.json"
# Let's "prettify" the json as well
cat "$SCRIPT_PATH/scoreboard.min.json" | jq > "$SCRIPT_PATH/scoreboard.json"

if [[ `git status --porcelain` ]]; then
	echo "There are differences, updating"
	git add -A
	git commit -m "[SCOREBOARD] update"
	git push origin main
else
	echo "No differences"
fi
