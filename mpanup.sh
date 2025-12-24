#!/bin/bash

# Be sure to add this current filepath to matedisplayrule.rules 
# Also make sure matedisplayrule.rules is in /etc/udex/rules.d/

echo "mpanup starting"

# Gets Displays
displays=$(xrandr --listmonitors)

#checks if theres only one display
if [[ ${#displays[@]} -eq 1 ]]
    #Sets panels back to default
    mate-panel --reset

else
    # Creates a foreach loop
    for display in "{displays[@]}"; do
        echo "Starting  $display"
        # Clears panels
        
        # Sets up panels

        # Creates panels

        # Adds widgets

        echo "Completed $display"
    done
fi
echo "mpanup complete"