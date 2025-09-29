#!/bin/sh

#
# Customizing Mediathekview
#

set -e # Exit immediately if a command exits with a non-zero status.
set -u # Treat unset variables as an error.

#
if [ ! -f /config/bookmarks.json ]; then
    cat <<EOF > /config/bookmarks.json
{
  "bookmarks" : [ ]
}
EOF
fi


#
# https://stackoverflow.com/questions/76328891/how-to-redirect-where-javafx-caches-dll-libraries
if ! grep -q "\-Djavafx.cachedir=${JAVAFX_TMP_DIR}" "/opt/MediathekView/MediathekView.vmoptions"; then

    cat <<EOF >> /opt/MediathekView/MediathekView.vmoptions
#
# Set custom path for the OpenFx cache files
-Djavafx.cachedir=${JAVAFX_TMP_DIR}
EOF
fi


#
# https://stackoverflow.com/questions/65819206/hosting-javafx-project-on-docker-container
if [ "${JAVAFX_GLX_DISABLE:-0}" -eq 1 ]; then

    if ! grep -q "\-Dprism.order=sw" "/opt/MediathekView/MediathekView.vmoptions"; then

        cat <<EOF >> /opt/MediathekView/MediathekView.vmoptions
#
# Disabling the hardware graphics acceleration
-Dprism.order=sw
EOF
    fi

else
    sed -e '/\# Disabling the hardware graphics acceleration/d' -i /opt/MediathekView/MediathekView.vmoptions
    sed -e '/\-Dprism.order=sw/d' -i /opt/MediathekView/MediathekView.vmoptions
fi


# Disable automatic update for Mediathekview
echo "127.0.0.1       download.mediathekview.de" >> /etc/hosts
