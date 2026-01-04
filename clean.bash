#!/bin/bash
#
# Bash script to remove IPC facilities for the current user.
# Supports:
#   -q  remove message queues
#   -s  remove semaphores
#   -m  remove shared memory
#   -a  remove all IPC facilities
#

usage() {
    echo "Usage: $0 {-q | -s | -m | -a}"
    echo "    -q  remove message queues"
    echo "    -s  remove semaphores"
    echo "    -m  remove shared memory segments"
    echo "    -a  remove all IPC facilities"
    exit 1
}

# Must provide exactly ONE argument
if [ $# -ne 1 ]; then
    usage
fi

option="$1"

remove_ipc() {
    local type="$1"      # q, s, or m
    local name="$2"      # message queue, semaphore, shared memory

    list=$(ipcs -$type | grep "$USER" | awk '{print $2}')
    count=0

    for id in $list; do
        case "$type" in
            q) ipcrm msg "$id" >/dev/null ;;
            s) ipcrm sem "$id" >/dev/null ;;
            m) ipcrm shm "$id" >/dev/null ;;
        esac
        ((count++))
    done

    echo "$count $name(s) for $USER removed"
}

case "$option" in
    -q)
        remove_ipc q "message queue"
        ;;
    -s)
        remove_ipc s "semaphore"
        ;;
    -m)
        remove_ipc m "shared memory segment"
        ;;
    -a)
        remove_ipc q "message queue"
        remove_ipc s "semaphore"
        remove_ipc m "shared memory segment"
        ;;
    *)
        usage
        ;;
esac
