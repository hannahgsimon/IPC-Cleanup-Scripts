#!/bin/ksh
#
# Korn Shell script to remove all existing semaphores for a user
#

list=$(ipcs -s | grep "$USER" | cut -d' ' -f2)
count=0

for semaphore in $list
do
    ipcrm sem $semaphore > /dev/null
    ((count=count+1))
done

print "$count semaphore(s) for $USER removed"