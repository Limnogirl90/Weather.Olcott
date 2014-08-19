                            egrep '\[ [0-6]\]' 2014*.out  |\
        grep -v 'MONTH TO DATE'|\
   egrep '(MINIMUM|MAXIMUM|AVERAGE) (-)?([0-9])+'|\
egrep -o '^([0-9])+\.out:    \[ [0-6]\] ".*(MINIMUM|MAXIMUM|AVERAGE) (-)?([0-9])+'|\
                           sed -e 's/\.out:    \[ [0-9]\]//g'|\
                         sed -e 's/TEMPERATURE (F) YESTERDAY //g'|\
                     sed -e s/\"//g
