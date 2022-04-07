# BigBlueButton-Optimize</h1>

You can easily optimize your BigBlueButton server.

<a href="https://www.npmjs.com/package/bigbluebutton-optimize">
<img alt="GitHub package.json version" src="https://img.shields.io/github/package-json/v/manishkatyan/bbb-optimize?label=npm&logo=npm">
</a>
<a href="https://www.npmjs.org/package/bigbluebutton-optimize">
<img src="https://img.shields.io/npm/dm/bigbluebutton-optimize.svg" alt="Monthly download on NPM" />
</a>

<br/><br/>

## ✨ Features

- **Branding**
- **Session settings**
- **Lock Settings**
- **Audio and Video optimization**

<br/><br/>

## 🖐 Requirements

To install this package, you would need a BigBlueButton 2.4.x server.

<br/><br/>

## ⏳ Installation

```bash
# Install bbb-opimize CLI globally
npm i -g bigbluebutton-optimize

#Run optimization. Replace ENV_FILE with your env file
bbb-optimize --env-file=ENV_FILE

```

## Example env file

```bash
#Set welcome message
DEFAULT_WELCOME_MESSAGE=Welcome to my awesome session

# Change default bigbluebutton logo; default=/var/www/bigbluebutton-default/logo.png
DEFAULT_LOGO=/root/branding/logo.png

# Change default bigbluebutton favicon; default=/var/www/bigbluebutton-default/favicon.ico
DEFAULT_FAVICON=/root/branding/favicon.ico

#Mute the session on start; default false
MUTE_ON_START=true

#lock settings
LOCK_PRIVATE_CHAT=true

#Enable mediasoup for webcam and screensharing instread of kurento
ENABLE_MEDIASOUP=true

```

## Available optimization options

### Branding

```bash
#Set welcome message
DEFAULT_WELCOME_MESSAGE=

#set welcome message footer
DEFAULT_WELCOME_MESSAGE_FOOTER=

# Change default bigbluebutton logo; default /var/www/bigbluebutton-default/logo.png
DEFAULT_LOGO=

# Change default bigbluebutton favicon; default /var/www/bigbluebutton-default/favicon.ico
DEFAULT_FAVICON=

# Change default bigbluebutton presentation; default /var/www/bigbluebutton-default/default.pdf
DEFAULT_PRESENTATION=

#Set title and it will be set as your bigbluebutton meeting tab name
CLIENT_TITLE=
APP_NAME=

#Set copyright
COPY_RIGHT=

#Change default help link for your bigbluebutton session
HELP_LINK=
```

### Sessions

```bash
#Enable this to allow moderators to unmute viwers; default false
ALLOW_MODS_TO_UNMUTE_USERS=

#If set true, only moderator can see all users webcam, viewer can see only his and moderator webcam; default false
WEBCAM_ONLY_FOR_MODERATOR=
#Mute the session on start; default false
MUTE_ON_START=
#Keep the meeting events; default false
DEFAULT_KEEP_EVENTS=
#Set the max users that can join a single BigBlueButton session; default 0
#If set to 0, There will not be any limit
DEFAULT_MAX_USERS=

#Allow users to join the same session using multiple devices; default false
ALLOW_DUPLICATE_USER_ID=

# Param to end the meeting when there are no moderators after a certain period of time.
# Needed for classes where teacher gets disconnected and can't get back in. Prevents
# students from running amok; default false
END_WHEN_NO_MODERATOR=

# Number of minutes to wait for moderator rejoin before end meeting (if `END_WHEN_NO_MODERATOR=true` ); default 2
END_WHEN_NO_MODERATOR_DELAY=

#Disable the recording even if record=true passed in create call; default false
DISABLE_RECORDING=

#Enable the shared notes; default false
ENABLE_SHARED_NOTES=

# Number of minutes that Learning Dashboard will be available after the end of the meeting
# if 0, the Learning Dashboard will keep available permanently; default 2
LEARNING_DASHBOARD_CLEANUP_DELAY=

# Default duration of the meeting in minutes. If set to 0 the meeting does'nt end.
#default 0
MEETING_DURATION=

#Enable listen only mode; default true
ENABLE_LISTEN_ONLY_MODE=

#Set this to true to skip audio check after joining the session; default false
SKIP_AUDIO_CHECK=

#Set this true to enable dictation; default false
ENABLE_DICTATION=
```

### Lock

```bash
#Default lock settings
#Lock the private chat; default false
LOCK_PRIVATE_CHAT=
#Lock the public chat; default false
LOCK_PUBLIC_CHAT=
#Lock the shared notes ; default false
LOCK_SHARED_NOTES=
#Lock the mic ; default false
LOCK_MICROPHONE=
#Lock the webcam ; default false
LOCK_WEBCAM=
#If enabled, viewers will not able to see other viewers; default false
HIDE_USER_LIST=
```

### Audio and Video

```bash
#Enable mediasoup for webcam and screensharing instread of kurento; default false
ENABLE_MEDIASOUP=

#Enable multiple kurento for better performance; default false
ENABLE_MULTIPLE_KURENTO=

#Set the default webcam resolution as low; default false
LOWER_WEBCAM_RESOLUTION=

#Enable recording optimization for ios devices
OPTIMIZE_RECORDING_FOR_IOS=
FIX_1007_AND_1020=

#If FIX_1007_AND_1020 is set to true, the add Your bbb server PUBLIC_IP
PUBLIC_IP=

```

### Miscellaneous settings

```bash
#Minimize the chat section on start; default value is false
CHAT_START_CLOSED=
#Set the log level for bbb; possible values are: INFO, DEBUG, WARN, ERROR,; default DBUG
LOG_LEVEL=
```

<br/><br/>

## 📝 License

[MIT License](LICENSE.md)

Copyright (c) [HigherEdLab.com](https://higheredlab.com/)

```

```
