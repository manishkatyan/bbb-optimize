# BigBlueButton-Optimize</h1>

You can easily preform optimization to your BigBlueButton server.

<a href="https://www.npmjs.com/package/bigbluebutton-optimize">
<img alt="GitHub package.json version" src="https://img.shields.io/github/package-json/v/manishkatyan/bbb-optimize?label=npm&logo=npm">
</a>
<a href="https://www.npmjs.org/package/bigbluebutton-optimize">
<img src="https://img.shields.io/npm/dm/bigbluebutton-optimize.svg" alt="Monthly download on NPM" />
</a>

<br/><br/>

## ✨ Features

- **Branding**: Detailed insights into attendance, audio/video/chat usage and activity scores of attendees
- **Session optimization**: Unlike the default BigBlueButton install, analytics is available even after the classes end
- **Lock Settings**: View the recordings of all your BigBlueButton online classes as well
- **layout Settings**: Simply install BBB-Analytics npm package on your BigBlueButton sever
- **Fix 1007 and 1020 audio errors**: Easily sort and search through records with paginations

<br/><br/>

## 🖐 Requirements

To view analytics, you would need a BigBlueButton 2.4.4 server.

<br/><br/>

## ⏳ Installation

```bash
# Install bbb-analytics CLI globally
npm i -g bigbluebutton-optimize

#Install dependecies
bbb-optimize --env-file=<env file path>

```

## Available optimization options

```bash
#Branding options
#Set welcome message
DEFAULT_WELCOME_MESSAGE=

#set welcome message footer
DEFAULT_WELCOME_MESSAGE_FOOTER=


# logo that will appier in bigbluebutton; default=/var/www/bigbluebutton-default/logo.png
DEFAULT_LOGO=

# Favicon that will appier in bigbluebutton; default=/var/www/bigbluebutton-default/favicon.ico
DEFAULT_FAVICON=

# default.pdf that will appier in bigbluebutton; default=/var/www/bigbluebutton-default/default.pdf
DEFAULT_PRESENTATION=

#Set title and it will be set as BigBlueButton meeting tab name
CLIENT_TITLE=
APP_NAME=

#Set copyright
COPY_RIGHT=

#Help link, That will appier in BigBlueButton help button
HELP_LINK=

#default false
ALLOW_MODS_TO_UNMUTE_USERS=

#If set true only moderator can see all users webcam, viewer can see only his and moderator webcam; default false
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
LEARNING_DASGBOARD_CLEANUP_DELAY=

# Default duration of the meeting in minutes. If set to 0 the meeting does'nt end.
#default 0
MEETING_DURATION=

#default value is true
ENABLE_LISTEN_ONLY_MODE=

#default value is false
SKIP_AUDIO_CHECK=

#default value is false
ENABLE_DICTATION=

#Minimize the chat section on start; default value is false
CHAT_START_CLOSED=

#Default lock settings
LOCK_PRIVATE_CHAT=
LOCK_PUBLIC_CHAT=
LOCK_SHARED_NOTES=
LOCK_MICROPHONE=
LOCK_WEBCAM=
HIDE_USER_LIST=

#Set the log level for bbb; possible values are: INFO, DEBUG, WARN, ERROR,; default DBUG
LOG_LEVEL=

#Enable mediasoup for webcam and screensharing instread of kurento
ENABLE_MEDIASOUP=

#Enable multiple kurento for better  performance
ENABLE_MULTIPLE_KURENTO=

#Set the default webcam resolution as low
LOWER_WEBCAM_RESOLUTION=

#Enable recording optimization for ios devices
OPTIMIZE_RECORDING_FOR_IOS=
FIX_1007_AND_1020=

#If FIX_1007_AND_1020 is set to true, the add Your bbb server PUBLIC_IP
PUBLIC_IP=

```

<br/><br/>

## 📝 License

[MIT License](LICENSE.md)

Copyright (c) [HigherEdLab.com](https://higheredlab.com/)
