egrep '\[ [5-6]\] "PRECIPITATION' 2014*.out  |\
  egrep -o '^([0-9])+\.out:    \[ [5-6]\] "PRECIPITATION \(IN\) YESTERDAY ([^ ]*( )?)+' |\
    sed -e 's/\.out:    \[ [5-6]\] "PRECIPITATION (IN) YESTERDAY//g' |\
    sed -e 's/",//g'
