#!/bin/bash

# Set default VNC password
VNC_PASSWORD=${PASSWORD:-ubuntu}

# Create VNC directory and set password
mkdir -p /root/.vnc
echo "$VNC_PASSWORD" | vncpasswd -f > /root/.vnc/passwd
chmod 600 /root/.vnc/passwd
chown -R root:root /root
sed -i "s/password = WebUtil.getConfigVar('password');/password = '$VNC_PASSWORD'/" /usr/lib/novnc/app/ui.js

# xstartup
XSTARTUP_PATH="/root/.vnc/xstartup"
cat << EOF > "$XSTARTUP_PATH"
#!/bin/sh
unset DBUS_SESSION_BUS_ADDRESS
mate-session
EOF
chmod 755 "$XSTARTUP_PATH"
chown root:root "$XSTARTUP_PATH"

# vncserver launch
VNCRUN_PATH="/root/.vnc/vnc_run.sh"
cat << EOF > "$VNCRUN_PATH"
#!/bin/sh
if [ -e /tmp/.X1-lock ]; then
    rm -f /tmp/.X1-lock
fi
if [ -e /tmp/.X11-unix/X1 ]; then
    rm -f /tmp/.X11-unix/X1
fi

if [ \$(uname -m) = "aarch64" ]; then
    LD_PRELOAD=/lib/aarch64-linux-gnu/libgcc_s.so.1 vncserver :1 -fg -geometry 1920x1080 -depth 24
else
    vncserver :1 -fg -geometry 1920x1080 -depth 24
fi
EOF

# Supervisor
CONF_PATH=/etc/supervisor/conf.d/supervisord.conf
cat << EOF > $CONF_PATH
[supervisord]
nodaemon=true
user=root
[program:vnc]
command=bash '$VNCRUN_PATH'
[program:novnc]
command=bash -c "websockify --web=/usr/lib/novnc 80 localhost:5901"
EOF

# clearup
PASSWORD=
VNC_PASSWORD=

echo "============================================================================================"
echo "NOTE: Before stopping to commit docker container to new docker image, log out first."
echo -e 'See \e]8;;\e\\\e]8;;\e\\'
echo "============================================================================================"

exec tini -- supervisord -n -c /etc/supervisor/supervisord.conf
