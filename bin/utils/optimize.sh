#!/bin/bash

ENV_FILE=$1

set -a

source <(cat $ENV_FILE | \
    sed -e '/^#/d;/^\s*$/d' -e "s/'/'\\\''/g" -e "s/=\(.*\)/='\1'/g")
set +a 

if [ ! -z "$ENABLE_MULTIPLE_KURENTO" ]; then
    # Pull in the helper functions for configuring BigBlueButton
    source /etc/bigbluebutton/bbb-conf/apply-lib.sh
    echo "Running three parallel Kurento media server"
    enableMultipleKurentos
fi

if [ ! -z "$DEFAULT_WELCOME_MESSAGE"  ]; then
    echo "Setting Welcome message: $DEFAULT_WELCOME_MESSAGE"
    sed -i "s/defaultWelcomeMessage=.*/defaultWelcomeMessage=$DEFAULT_WELCOME_MESSAGE/g" /usr/share/bbb-web/WEB-INF/classes/bigbluebutton.properties
fi

if [ ! -z "$DEFAULT_WELCOME_MESSAGE_FOOTER" ]; then 
    echo "Setting Welcome message footer: $DEFAULT_WELCOME_MESSAGE_FOOTER"
    sed -i "s/defaultWelcomeMessageFooter=.*/defaultWelcomeMessageFooter=$DEFAULT_WELCOME_MESSAGE_FOOTER/g" /usr/share/bbb-web/WEB-INF/classes/bigbluebutton.properties
fi


if [ ! -z "$ALLOW_MODS_TO_UNMUTE_USERS" ]; then
    echo "Let Moderators unmute users: $ALLOW_MODS_TO_UNMUTE_USERS"
    sed -i "s/allowModsToUnmuteUsers=.*/allowModsToUnmuteUsers=$ALLOW_MODS_TO_UNMUTE_USERS/g" /usr/share/bbb-web/WEB-INF/classes/bigbluebutton.properties
fi

if [ ! -z "$WEBCAM_ONLY_FOR_MODERATOR" ]; then
    echo "See other viewers webcams: $WEBCAM_ONLY_FOR_MODERATOR"
    sed -i "s/webcamsOnlyForModerator=.*/webcamsOnlyForModerator=$WEBCAM_ONLY_FOR_MODERATOR/g" /usr/share/bbb-web/WEB-INF/classes/bigbluebutton.properties
fi

if [ ! -z "$MUTE_ON_START" ]; then
    echo "Mute the class on start: $MUTE_ON_START"
    sed -i "s/muteOnStart=.*/muteOnStart=$MUTE_ON_START/g" /usr/share/bbb-web/WEB-INF/classes/bigbluebutton.properties
fi

if [ ! -z "$DEFAULT_KEEP_EVENTS" ]; then
    echo "Saves meeting events even if the meeting is not recorded: $DEFAULT_KEEP_EVENTS"
    sed -i "s/defaultKeepEvents=.*/defaultKeepEvents=$DEFAULT_KEEP_EVENTS/g" /usr/share/bbb-web/WEB-INF/classes/bigbluebutton.properties
fi

if [ ! -z "$DEFAULT_MAX_USERS" ]; then
    echo "Maximum users per class: $DEFAULT_MAX_USERS"
    sed -i "s/defaultMaxUsers=.*/defaultMaxUsers=$DEFAULT_MAX_USERS/g" /usr/share/bbb-web/WEB-INF/classes/bigbluebutton.properties
fi

if [ ! -z "$LOCK_PRIVATE_CHAT" ]; then
    echo "Disable private chat:$LOCK_PRIVATE_CHAT "
    sed -i "s/lockSettingsDisablePrivateChat=.*/lockSettingsDisablePrivateChat=$LOCK_PRIVATE_CHAT/g" /usr/share/bbb-web/WEB-INF/classes/bigbluebutton.properties
fi

if [ ! -z "$LOCK_PUBLIC_CHAT" ]; then
    echo "Disable public chat: $LOCK_PUBLIC_CHAT"
    sed -i "s/lockSettingsDisablePublicChat=.*/lockSettingsDisablePublicChat=$LOCK_PUBLIC_CHAT/g" /usr/share/bbb-web/WEB-INF/classes/bigbluebutton.properties
fi

if [ ! -z "$LOCK_SHARED_NOTES" ]; then
    echo "Disable shared note: $LOCK_SHARED_NOTES"
    sed -i "s/lockSettingsDisableNote=.*/lockSettingsDisableNote=$LOCK_SHARED_NOTES/g" /usr/share/bbb-web/WEB-INF/classes/bigbluebutton.properties
fi

if [ ! -z "$LOCK_MICROPHONE" ]; then
    echo "Enable mic: $LOCK_MICROPHONE";
    sed -i "s/lockSettingsDisableMic=.*/lockSettingsDisableMic=$LOCK_MICROPHONE/g" /usr/share/bbb-web/WEB-INF/classes/bigbluebutton.properties
fi

if [ ! -z "$HIDE_USER_LIST" ]; then
    echo "See other users in the Users list: $HIDE_USER_LIST"
    sed -i "s/lockSettingsHideUserList=.*/lockSettingsHideUserList=$HIDE_USER_LIST/g" /usr/share/bbb-web/WEB-INF/classes/bigbluebutton.properties
fi

if [ ! -z "$LOCK_WEBCAM" ]; then
    echo "Prevent viewers from sharing webcams: $LOCK_WEBCAM"
    sed -i "s/lockSettingsDisableCam=.*/lockSettingsDisableCam=$LOCK_WEBCAM/g" /usr/share/bbb-web/WEB-INF/classes/bigbluebutton.properties
fi 

if [ ! -z "$ALLOW_DUPLICATE_USER_ID" ]; then
    echo "Prevent users from joining classes from multiple devices: $ALLOW_DUPLICATE_USER_ID"
    sed -i "s/allowDuplicateExtUserid=.*/allowDuplicateExtUserid=$ALLOW_DUPLICATE_USER_ID/g" /usr/share/bbb-web/WEB-INF/classes/bigbluebutton.properties
fi

if [ ! -z "$END_WHEN_NO_MODERATOR" ]; then
    echo "End the meeting when there are no moderators after a certain period of time: $END_WHEN_NO_MODERATOR"
    sed -i "s/endWhenNoModerator=.*/endWhenNoModerator=$END_WHEN_NO_MODERATOR/g" /usr/share/bbb-web/WEB-INF/classes/bigbluebutton.properties
fi

if [ ! -z $END_WHEN_NO_MODERATOR_DELAY ]; then
    echo "End meeting duration when there are no moderators after a certain period of time: $END_WHEN_NO_MODERATOR_DELAY"
    sed -i "s/endWhenNoModeratorDelayInMinutes=.*/endWhenNoModeratorDelayInMinutes=$END_WHEN_NO_MODERATOR_DELAY/g" /usr/share/bbb-web/WEB-INF/classes/bigbluebutton.properties
fi

if [ ! -z $LOG_LEVEL ]; then
    echo "Set log level to $LOG_LEVEL"
    sed -i "s/appLogLevel=.*/appLogLevel=$LOG_LEVEL/g" /usr/share/bbb-web/WEB-INF/classes/bigbluebutton.properties
fi

if [ ! -z "$DISABLE_RECORDING"  ]; then
    echo "Disable recording: $DISABLE_RECORDING"
    sed -i "s/disableRecordingDefault=.*/disableRecordingDefault=$DISABLE_RECORDING/g" /usr/share/bbb-web/WEB-INF/classes/bigbluebutton.properties
fi

if [ ! -z $MEETING_DURATION ]; then
    echo "Set maximum meeting duration: $MEETING_DURATION"
    sed -i "s/defaultMeetingDuration=.*/defaultMeetingDuration=$MEETING_DURATION/g"  /usr/share/bbb-web/WEB-INF/classes/bigbluebutton.properties
fi

if [ ! -z $LEARNING_DASHBOARD_CLEANUP_DELAY ]; then
    echo "Keep Learning Dashboard data: $LEARNING_DASHBOARD_CLEANUP_DELAY"
    sed -i "s/learningDashboardCleanupDelayInMinutes=.*/learningDashboardCleanupDelayInMinutes=$LEARNING_DASHBOARD_CLEANUP_DELAY/g" /usr/share/bbb-web/WEB-INF/classes/bigbluebutton.properties
fi

if [ ! -z "$ENABLE_LISTEN_ONLY_MODE" ]; then
    echo "Enable listen only mode: $ENABLE_LISTEN_ONLY_MODE"
    sed -i "s/listenOnlyMode:.*/listenOnlyMode: $ENABLE_LISTEN_ONLY_MODE/g" /usr/share/meteor/bundle/programs/server/assets/app/config/settings.yml
fi

if [ ! -z "$SKIP_AUDIO_CHECK" ]; then
    echo "Enable audio check: $SKIP_AUDIO_CHECK"
    sed -i "s/skipCheck:.*/skipCheck: $SKIP_AUDIO_CHECK/g" /usr/share/meteor/bundle/programs/server/assets/app/config/settings.yml
fi

if [ ! -z "$ENABLE_DICTATION" ]; then
    echo "Enable dictation: $ENABLE_DICTATION"
    sed -i "s/enableDictation:.*/enableDictation: $ENABLE_DICTATION/g" /usr/share/meteor/bundle/programs/server/assets/app/config/settings.yml
fi

if [ ! -z "$CHAT_START_CLOSED" ]; then
    echo "Close chat on start: $CHAT_START_CLOSED"
    sed -i "s/startClosed:.*/startClosed: $CHAT_START_CLOSED/g" /usr/share/meteor/bundle/programs/server/assets/app/config/settings.yml
fi

if [ ! -z "$CLIENT_TITLE" ]; then
    echo "Set Client Title: $CLIENT_TITLE"
    sed -i "s/clientTitle:.*/clientTitle: $CLIENT_TITLE/g" /usr/share/meteor/bundle/programs/server/assets/app/config/settings.yml
fi 

if [ ! -z "$APP_NAME" ]; then
    echo "Set App Title: $APP_NAME"
    sed -i "s/appName:.*/appName: $APP_NAME/g" /usr/share/meteor/bundle/programs/server/assets/app/config/settings.yml
fi

if [ ! -z "$COPY_RIGHT" ]; then
    echo "Set Copyright: $COPY_RIGHT"
    sed -i "s/copyright:.*/copyright: $COPY_RIGHT/g" /usr/share/meteor/bundle/programs/server/assets/app/config/settings.yml
fi

if [ ! -z "$HELP_LINK" ]; then
    echo "Set Helplink: $HELP_LINK"
    sed -i "s/helpLink:.*/helpLink: $HELP_LINK/g" /usr/share/meteor/bundle/programs/server/assets/app/config/settings.yml
fi


if [ "$FIX_AUDIO_ERROR" = true ]; then
    if [ ! -z $PUBLIC_IP ]; then
        echo "Fix for 1007 and 1020 - https://github.com/manishkatyan/bbb-optimize#fix-1007-and-1020-errors"
        xmlstarlet edit --inplace --update '//profile/settings/param[@name="ext-rtp-ip"]/@value' --value "\$\${external_rtp_ip}" /opt/freeswitch/etc/freeswitch/sip_profiles/external.xml
        xmlstarlet edit --inplace --update '//profile/settings/param[@name="ext-sip-ip"]/@value' --value "\$\${external_sip_ip}" /opt/freeswitch/etc/freeswitch/sip_profiles/external.xml
        xmlstarlet edit --inplace --update '//X-PRE-PROCESS[@cmd="set" and starts-with(@data, "external_rtp_ip=")]/@data' --value "external_rtp_ip=$PUBLIC_IP" /opt/freeswitch/etc/freeswitch/vars.xml
        xmlstarlet edit --inplace --update '//X-PRE-PROCESS[@cmd="set" and starts-with(@data, "external_sip_ip=")]/@data' --value "external_sip_ip=$PUBLIC_IP" /opt/freeswitch/etc/freeswitch/vars.xml
    else
        echo "Invalid PUBLIC_IP"
    fi
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
    echo "copying default presenttaion"
    cp -r $DEFAULT_PRESENTATION /var/www/bigbluebutton-default/
fi


if [ ! -z "$ENABLE_SHARED_NOTES" ]; then
    echo "Enable shared notes: $ENABLE_SHARED_NOTES"
    yq w -i /usr/share/meteor/bundle/programs/server/assets/app/config/settings.yml public.note.enabled $ENABLE_SHARED_NOTES
fi

if [ "$OPTIMIZE_RECORDING_FOR_IOS" = true ]; then
    echo " Use MP4 format for playback of recordings: $OPTIMIZE_RECORDING_FOR_IOS"
    sed -i "s/- webm/# - webm/g" /usr/local/bigbluebutton/core/scripts/presentation.yml
    sed -i "s/# - mp4/- mp4/g" /usr/local/bigbluebutton/core/scripts/presentation.yml
fi
if [ "$OPTIMIZE_RECORDING_FOR_IOS" = false ]; then
    echo " Use MP4 format for playback of recordings: $OPTIMIZE_RECORDING_FOR_IOS"
    sed -i "s/# - webm/- webm/g" /usr/local/bigbluebutton/core/scripts/presentation.yml
    sed -i "s/- mp4/# - mp4/g" /usr/local/bigbluebutton/core/scripts/presentation.yml
fi

if [ "$ENABLE_MEDIASOUP" = true ]; then
    echo "Enable mediasoup: $ENABLE_MEDIASOUP"
    yq w -i /usr/share/meteor/bundle/programs/server/assets/app/config/settings.yml public.kurento.signalCandidates false
    sed -i "s/#mediaServer: Kurento/mediaServer: mediasoup/g" /usr/share/meteor/bundle/programs/server/assets/app/config/settings.yml
    sed -i "s/#videoMediaServer: Kurento/videoMediaServer: mediasoup/g" /usr/share/meteor/bundle/programs/server/assets/app/config/settings.yml
    sed -i "s/#listenOnlyMediaServer: Kurento/listenOnlyMediaServer: mediasoup/g" /usr/share/meteor/bundle/programs/server/assets/app/config/settings.yml
fi

if [ "$ENABLE_MEDIASOUP" = false ]; then
    echo "Enable mediasoup: $ENABLE_MEDIASOUP"
    yq w -i /usr/share/meteor/bundle/programs/server/assets/app/config/settings.yml public.kurento.signalCandidates false
    sed -i "s/mediaServer: mediasoup/#mediaServer: Kurento/g" /usr/share/meteor/bundle/programs/server/assets/app/config/settings.yml
    sed -i "s/videoMediaServer: mediasoup/#videoMediaServer: Kurento/g" /usr/share/meteor/bundle/programs/server/assets/app/config/settings.yml
    sed -i "s/listenOnlyMediaServer: mediasoup/#listenOnlyMediaServer: Kurento/g" /usr/share/meteor/bundle/programs/server/assets/app/config/settings.yml
fi

if [ ! -z "$WEBCAM_RESOLUTION"  ]; then
    echo "Set default webcam profile as : $WEBCAM_RESOLUTION"
    #Set everything false
    yq w -i /usr/share/meteor/bundle/programs/server/assets/app/config/settings.yml 'public.kurento.cameraProfiles.(id==low).default' false
    yq w -i /usr/share/meteor/bundle/programs/server/assets/app/config/settings.yml 'public.kurento.cameraProfiles.(id==medium).default' false
    yq w -i /usr/share/meteor/bundle/programs/server/assets/app/config/settings.yml 'public.kurento.cameraProfiles.(id==high).default' false
    yq w -i /usr/share/meteor/bundle/programs/server/assets/app/config/settings.yml 'public.kurento.cameraProfiles.(id==hd).default' false

    #set webcam resolution
    yq w -i /usr/share/meteor/bundle/programs/server/assets/app/config/settings.yml "public.kurento.cameraProfiles.(id==$WEBCAM_RESOLUTION).default" true
fi
echo ""
echo "====== Please restart the BigBlueButton  ======"
