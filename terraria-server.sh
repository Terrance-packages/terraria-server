#!/usr/bin/env sh

HOME='/var/lib/terraria'
CONFDIR='/etc/conf.d/terraria-server'

INSTANCE="${2:-default}"
if [ -r "${CONFDIR}/${INSTANCE}.txt" ]; then
    ARGNAME="-config"
    ARGVAL="${CONFDIR}/${INSTANCE}.txt"
else
    ARGNAME="-world"
    ARGVAL="${HOME}/.local/share/Terraria/Worlds/$INSTANCE.wld"
fi

TMUX_CONSOLE=terraria-server-console-${INSTANCE}

## Terraria Server API Command Line:
##   -ip <ipv4>          - Starts the server bound to a given IPv4 address
##   -port <port>        - Starts the server bound to a given port
##   -maxplayers <count> - Starts the server with a given player count
##   -world <file.wld>   - Starts the server and immediately loads a given
##                         world file
##   -worldpath <path>   - Starts the server and changes the world path to a
##                         given path
##   -autocreate <1/2/3> - Starts the server and, if a world file isn't found,
##                         automatically create the world file with a given
##                         size, 1-3, 1 being small.
##   -config <file>      - Starts the server with a given config file
##   -connperip <n>      - Allows n number of connections per IP.
##   -killinactivesocket - Kills connections which have not started the
##                         protocol handshake.
##   -lang <type>        - Sets the server's language.
##   -ignoreversion      - Ignores API version checks for plugins allowing for
##                         old plugins to run.
##   -forceupdate        - Forces the server to continue running, and not
##                         hibernating when no players are on. This results in
##                         time passing, grass growing, and cpu running.

case "$1" in
    start)
        if tmux has-session -t ${TMUX_CONSOLE} &> /dev/null ; then
            echo "Terraria server instance '$INSTANCE' is already running"
            exit 1
        fi
        mkdir -p "${BASEDIR:=${HOME}/servers/${INSTANCE}}"
        tmux new-session -d -s ${TMUX_CONSOLE} -c "${BASEDIR}" \
            /opt/terraria-server/TerrariaServer.bin.x86_64 "${ARGNAME}" "${ARGVAL}"
        if [ $? -gt 0 ]; then
            echo "Could not start instance"
            exit 1
        fi
        ;;

    stop)
        if ! tmux has-session -t ${TMUX_CONSOLE} &> /dev/null ; then
            echo "Terraria server instance '$INSTANCE' is not running"
            exit 1
        fi
        tmux send-keys -t ${TMUX_CONSOLE} 'say Server shutting down in 5 seconds!' C-m
        echo 'Server shutting down in 5 seconds'
        sleep 5
        tmux send-keys -t ${TMUX_CONSOLE} 'exit' C-m
        ;;

    console)
        if ! tmux has-session -t ${TMUX_CONSOLE} &> /dev/null ; then
            echo "Terraria server instance '$INSTANCE' is not running"
            exit 1
        fi
        tmux attach -t ${TMUX_CONSOLE}
        ;;

    *)
        echo "usage: $0 {start|stop|console} [instance]"
esac

exit 0
