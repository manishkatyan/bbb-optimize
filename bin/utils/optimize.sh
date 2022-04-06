#!/bin/bash

ENV_FILE=$1

set -a

source <(cat $ENV_FILE | \
    sed -e '/^#/d;/^\s*$/d' -e "s/'/'\\\''/g" -e "s/=\(.*\)/='\1'/g")
set +a 

if [ "$ENABLE_MULTIPLE_KURENTO" = true ]; then
    # Pull in the helper functions for configuring BigBlueButton
    # source /etc/bigbluebutton/bbb-conf/apply-lib.sh
    echo "Running three parallel Kurento media server"
    # enableMultipleKurentos
fi

if [ ! -z $DEFAULT_WELCOME_MESSAGE  ]; then
    echo "Setting Welcome message"
    sed -i "s/defaultWelcomeMessage=.*/defaultWelcomeMessage=$DEFAULT_WELCOME_MESSAGE/g" /usr/share/bbb-web/WEB-INF/classes/bigbluebutton.properties
fi

if [ ! -z $DEFAULT_WELCOME_MESSAGE_FOOTER ]; then 
    echo "Setting Welcome message footer"
    sed -i "s/defaultWelcomeMessageFooter=.*/defaultWelcomeMessageFooter=$DEFAULT_WELCOME_MESSAGE_FOOTER/g" /usr/share/bbb-web/WEB-INF/classes/bigbluebutton.properties
fi


if [ "$ALLOW_MODS_TO_UNMUTE_USERS" = true ]; then
    echo "Let Moderators unmute users"
    sed -i 's/allowModsToUnmuteUsers=.*/allowModsToUnmuteUsers=true/g' /usr/share/bbb-web/WEB-INF/classes/bigbluebutton.properties
fi

if [ "$WEBCAM_ONLY_FOR_MODERATOR" = true ]; then
    echo "See other viewers webcams"
    sed -i 's/webcamsOnlyForModerator=.*/webcamsOnlyForModerator=true/g' /usr/share/bbb-web/WEB-INF/classes/bigbluebutton.properties
fi

if [ "$MUTE_ON_START" = true ]; then
    echo "Don't Mute the class on start"
    sed -i 's/muteOnStart=.*/muteOnStart=true/g' /usr/share/bbb-web/WEB-INF/classes/bigbluebutton.properties
fi

if [ "$DEFAULT_KEEP_EVENTS" = true ]; then
    echo "Saves meeting events even if the meeting is not recorded"
    sed -i 's/defaultKeepEvents=.*/defaultKeepEvents=true/g' /usr/share/bbb-web/WEB-INF/classes/bigbluebutton.properties
fi

if [ ! -z $DEFAULT_MAX_USERS ]; then
    echo "Set maximum users per class to $DEFAULT_MAX_USERS"
    sed -i "s/defaultMaxUsers=.*/defaultMaxUsers=$DEFAULT_MAX_USERS/g" /usr/share/bbb-web/WEB-INF/classes/bigbluebutton.properties
fi

if [ "$LOCK_PRIVATE_CHAT" = true ]; then
    echo "Disable private chat"
    sed -i 's/lockSettingsDisablePrivateChat=.*/lockSettingsDisablePrivateChat=true/g' /usr/share/bbb-web/WEB-INF/classes/bigbluebutton.properties
fi

if [ "$LOCK_PUBLIC_CHAT" = true ]; then
    echo "Disable public chat"
    sed -i 's/lockSettingsDisablePublicChat=.*/lockSettingsDisablePublicChat=true/g' /usr/share/bbb-web/WEB-INF/classes/bigbluebutton.properties
fi

if [ "$LOCK_SHARED_NOTES" = true ]; then
    echo "Disable shared note"
    sed -i 's/lockSettingsDisableNote=.*/lockSettingsDisableNote=true/g' /usr/share/bbb-web/WEB-INF/classes/bigbluebutton.properties
fi

if [ "$LOCK_MICROPHONE" = true ]; then
    echo "Enable mic";
    sed -i 's/lockSettingsDisableMic=.*/lockSettingsDisableMic=true/g' /usr/share/bbb-web/WEB-INF/classes/bigbluebutton.properties
fi

if [ "$HIDE_USER_LIST" = true ]; then
    echo "See other users in the Users list"
    sed -i 's/lockSettingsHideUserList=.*/lockSettingsHideUserList=true/g' /usr/share/bbb-web/WEB-INF/classes/bigbluebutton.properties
fi

if [ "$LOCK_WEBCAM" = true ]; then
    echo "Prevent viewers from sharing webcams"
    sed -i 's/lockSettingsDisableCam=.*/lockSettingsDisableCam=true/g' /usr/share/bbb-web/WEB-INF/classes/bigbluebutton.properties
fi 

if [ "$ALLOW_DUPLICATE_USER_ID" = true ]; then
    echo "Prevent users from joining classes from multiple devices"
    sed -i 's/allowDuplicateExtUserid=.*/allowDuplicateExtUserid=true/g' /usr/share/bbb-web/WEB-INF/classes/bigbluebutton.properties
fi

if [ "$END_WHEN_NO_MODERATOR" = true ]; then
    echo "End the meeting when there are no moderators after a certain period of time. Prevents students from running amok."
    sed -i 's/endWhenNoModerator=.*/endWhenNoModerator=true/g' /usr/share/bbb-web/WEB-INF/classes/bigbluebutton.properties
fi

if [ ! -z $END_WHEN_NO_MODERATOR_DELAY ]; then
    echo "End the meeting duration when there are no moderators after a certain period of time."
    sed -i "s/endWhenNoModeratorDelayInMinutes=.*/endWhenNoModeratorDelayInMinutes=$END_WHEN_NO_MODERATOR_DELAY/g" /usr/share/bbb-web/WEB-INF/classes/bigbluebutton.properties
fi

if [ ! -z $LOG_LEVEL ]; then
    echo "Set log level to $LOG_LEVEL"
    sed -i "s/appLogLevel=.*/appLogLevel=$LOG_LEVEL/g" /usr/share/bbb-web/WEB-INF/classes/bigbluebutton.properties
fi

if [ "$DISABLE_RECORDING" = true  ]; then
    echo "Disable recording"
    sed -i "s/disableRecordingDefault=.*/disableRecordingDefault=true/g" /usr/share/bbb-web/WEB-INF/classes/bigbluebutton.properties
fi

if [ ! -z $MEETING_DURATION ]; then
    echo "Set maximum meeting duration to $MEETING_DURATION minutes"
    sed -i "s/defaultMeetingDuration=.*/defaultMeetingDuration=$MEETING_DURATION/g"  /usr/share/bbb-web/WEB-INF/classes/bigbluebutton.properties
fi

if [ ! -z $LEARNING_DASGBOARD_CLEANUP_DELAY ]; then
    echo "Keep Learning Dashboard data"
    sed -i "s/learningDashboardCleanupDelayInMinutes=.*/learningDashboardCleanupDelayInMinutes=$LEARNING_DASGBOARD_CLEANUP_DELAY/g" /usr/share/bbb-web/WEB-INF/classes/bigbluebutton.properties
fi

if [ "$ENABLE_LISTEN_ONLY_MODE" = true ]; then
    echo "Enable listen only mode"
    sed -i 's/listenOnlyMode:.*/listenOnlyMode: true/g' /usr/share/meteor/bundle/programs/server/assets/app/config/settings.yml
fi

if [ "$SKIP_AUDIO_CHECK" = true ]; then
    echo "Enable audio check otherwise may face audio issue"
    sed -i 's/skipCheck:.*/skipCheck: true/g' /usr/share/meteor/bundle/programs/server/assets/app/config/settings.yml
fi

if [ "$ENABLE_DICTATION" = true ]; then
    echo "Enable dictation"
    sed -i 's/enableDictation:.*/enableDictation: true/g' /usr/share/meteor/bundle/programs/server/assets/app/config/settings.yml
fi

if [ "$CHAT_START_CLOSED" = true ]; then
    echo "Close chat on start"
    sed -i 's/startClosed:.*/startClosed: true/g' /usr/share/meteor/bundle/programs/server/assets/app/config/settings.yml
fi

if [ ! -z $CLIENT_TITLE ]; then
    echo "Set Client Title"
    sed -i "s/clientTitle:.*/clientTitle: $CLIENT_TITLE/g" /usr/share/meteor/bundle/programs/server/assets/app/config/settings.yml
fi 

if [ ! -z $APP_NAME ]; then
    echo "Set App Title"
    sed -i "s/appName:.*/appName: $APP_NAME/g" /usr/share/meteor/bundle/programs/server/assets/app/config/settings.yml
fi

if [ ! -z $COPY_RIGHT ]; then
    echo "Set Copyright"
    sed -i "s/copyright:.*/copyright: \"$COPY_RIGHT\"/g" /usr/share/meteor/bundle/programs/server/assets/app/config/settings.yml
fi

if [ ! -z $HELP_LINK ]; then
    echo "Set Helplink"
    sed -i "s/helpLink:.*/helpLink: $HELP_LINK/g" /usr/share/meteor/bundle/programs/server/assets/app/config/settings.yml
fi


if [ "$FIX_1007_AND_1020" = true ]; then
    echo "Fix for 1007 and 1020 - https://github.com/manishkatyan/bbb-optimize#fix-1007-and-1020-errors"
    xmlstarlet edit --inplace --update '//profile/settings/param[@name="ext-rtp-ip"]/@value' --value "\$\${external_rtp_ip}" /opt/freeswitch/etc/freeswitch/sip_profiles/external.xml
    xmlstarlet edit --inplace --update '//profile/settings/param[@name="ext-sip-ip"]/@value' --value "\$\${external_sip_ip}" /opt/freeswitch/etc/freeswitch/sip_profiles/external.xml
    xmlstarlet edit --inplace --update '//X-PRE-PROCESS[@cmd="set" and starts-with(@data, "external_rtp_ip=")]/@data' --value "external_rtp_ip=$PUBLIC_IP" /opt/freeswitch/etc/freeswitch/vars.xml
    xmlstarlet edit --inplace --update '//X-PRE-PROCESS[@cmd="set" and starts-with(@data, "external_sip_ip=")]/@data' --value "external_sip_ip=$PUBLIC_IP" /opt/freeswitch/etc/freeswitch/vars.xml
fi


if [ ! -z $DEFAULT_LOGO ]; then
    echo "copying logo.png"
    cp -r $DEFAULT_LOGO /var/www/bigbluebutton-default/
    echo "copying logo.png for player"
    cp -r $DEFAULT_LOGO /var/bigbluebutton/playback/presentation/2.3/static/media/logo*
fi

if [ ! -z $DEFAULT_FAVICON ]; then
    echo "copying favicon.ico"
    cp -r $DEFAULT_FAVICON /var/www/bigbluebutton-default/
    cp -r $DEFAULT_FAVICON /var/bigbluebutton/playback/presentation/2.3/favicon.ico
    cp -r $DEFAULT_FAVICON /var/bigbluebutton/learning-dashboard/favicon.ico
fi

if [ ! -z $DEFAULT_PRESENTATION ]; then
    echo "copying $DEFAULT_PRESENTATION"
    cp -r $DEFAULT_PRESENTATION /var/www/bigbluebutton-default/
fi


if [ "$ENABLE_SHARED_NOTES" = true ]; then
    echo "Enable shared notes"
    yq w -i /usr/share/meteor/bundle/programs/server/assets/app/config/settings.yml public.note.enabled true
fi
if [ "$OPTIMIZE_RECORDING_FOR_IOS" = true ]; then
    echo " Use MP4 format for playback of recordings"
    sed -i 's/- webm/# - webm/g' /usr/local/bigbluebutton/core/scripts/presentation.yml
    sed -i 's/# - mp4/- mp4/g' /usr/local/bigbluebutton/core/scripts/presentation.yml
fi


if [ "$ENABLE_MEDIASOUP" = true ]; then
    echo "Enable mediasoup"
    yq w -i /usr/share/meteor/bundle/programs/server/assets/app/config/settings.yml public.kurento.signalCandidates false
    sed -i 's/#mediaServer: Kurento/mediaServer: mediasoup/g' /usr/share/meteor/bundle/programs/server/assets/app/config/settings.yml
    sed -i 's/#videoMediaServer: Kurento/videoMediaServer: mediasoup/g' /usr/share/meteor/bundle/programs/server/assets/app/config/settings.yml
    sed -i 's/#listenOnlyMediaServer: Kurento/listenOnlyMediaServer: mediasoup/g' /usr/share/meteor/bundle/programs/server/assets/app/config/settings.yml
fi


if [ "$LOWER_WEBCAM_RESOLUTION" = true ]; then
    echo "Set default webcam profile as low"
    yq w -i /usr/share/meteor/bundle/programs/server/assets/app/config/settings.yml 'public.kurento.cameraProfiles.(id==low).default' true
    yq w -i /usr/share/meteor/bundle/programs/server/assets/app/config/settings.yml 'public.kurento.cameraProfiles.(id==medium).default' false
    yq w -i /usr/share/meteor/bundle/programs/server/assets/app/config/settings.yml 'public.kurento.cameraProfiles.(id==high).default' false
    yq w -i /usr/share/meteor/bundle/programs/server/assets/app/config/settings.yml 'public.kurento.cameraProfiles.(id==hd).default' false
fi

echo "Please restart the BigBlueButton server"