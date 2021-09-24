#!/usr/bin/bash
echo "Imported packages in r_in_30minutes.Rmd"
egrep "library\\W" r_in_30minutes.Rmd | tr -d \\r | awk '!seen[$0]++' | sed -e s/library/install.packages/g -e 's/[(]/("/g' -e 's/[)]/")/g' -e 's/""/"/g'
echo

echo "Imported packages in r_in_30minutes.Rmd (ordered)"
egrep "library\\W" r_in_30minutes.Rmd | tr -d \\r | sort -f | uniq | sed -e s/library/install.packages/g -e 's/[(]/("/g' -e 's/[)]/")/g' -e 's/""/"/g'
echo

echo "R and C++ package:: names in r_in_30minutes.Rmd"
egrep -o "\\b(\\w*::)" r_in_30minutes.Rmd | tr -d \\r | sort | uniq
echo
