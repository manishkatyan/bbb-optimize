# BigBlueButton-Optimize</h1>

You can easily optimize your BigBlueButton server to meet your specific requirements for branding and feature customizations.

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
- **Lock settings**
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

#Restart the bbb
bbb-conf --restart
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

# If the message contains characters not in ISO-8859-1 character sets
# they must be properly escaped to unicode characters. An easy way to
# do this is running the native2ascii command setting UTF8 encoding and
# passing this file's path as input and output parameters, e.g.:
#
# native2ascii -encoding UTF8 bigbluebutton.properties bigbluebutton.properties
DEFAULT_WELCOME_MESSAGE=Hello Welcome to My Conference

DEFAULT_WELCOME_MESSAGE_FOOTER=Message footer

# Change default bigbluebutton logo; default /var/www/bigbluebutton-default/logo.png
DEFAULT_LOGO=/var/www/bigbluebutton-default/logo.png

# Change default bigbluebutton favicon; default /var/www/bigbluebutton-default/favicon.ico
DEFAULT_FAVICON=/var/www/bigbluebutton-default/favicon.ico

# Change default bigbluebutton presentation; default /var/www/bigbluebutton-default/default.pdf
DEFAULT_PRESENTATION= /var/www/bigbluebutton-default/default.pdf

#Set title and it will be set as your bigbluebutton meeting tab name
CLIENT_TITLE=Class ++
APP_NAME=Class ++

#Set copyright
COPY_RIGHT=©2022 example.com

#Change default help link for your bigbluebutton session
HELP_LINK=https:\/\/www.example.com\/help
```

### Session settings

```bash
#Enable this to allow moderators to unmute viwers
ALLOW_MODS_TO_UNMUTE_USERS=false

# Allow webcams streaming reception only to and from moderators
WEBCAM_ONLY_FOR_MODERATOR=false

#Mute the session on start
MUTE_ON_START=false

#Keep the meeting events
DEFAULT_KEEP_EVENTS=false

#Set the max users that can join a single BigBlueButton session
#If set to 0, There will not be any limit
DEFAULT_MAX_USERS=0

#Allow users to join the same session using multiple devices
ALLOW_DUPLICATE_USER_ID=false

# Param to end the meeting when there are no moderators after a certain period of time.
# Needed for classes where teacher gets disconnected and can't get back in. Prevents
# students from running amok
END_WHEN_NO_MODERATOR=false

# Number of minutes to wait for moderator rejoin before end meeting (if `END_WHEN_NO_MODERATOR=true` )
END_WHEN_NO_MODERATOR_DELAY=2

#Disable the recording even if record=true passed in create call
DISABLE_RECORDING=false

#Enable the shared notes 
ENABLE_SHARED_NOTES=false

# Number of minutes that Learning Dashboard will be available after the end of the meeting
# if 0, the Learning Dashboard will keep available permanently; 
LEARNING_DASHBOARD_CLEANUP_DELAY=2

# Default duration of the meeting in minutes. If set to 0 the meeting does'nt end.
MEETING_DURATION=0

#Enable listen only mode
ENABLE_LISTEN_ONLY_MODE=true

#Set this to true to skip audio check after joining the session
SKIP_AUDIO_CHECK=false

#Set this true to enable dictation
ENABLE_DICTATION=false
```

### Lock settings

```bash
#Default lock settings

#Lock the private chat
LOCK_PRIVATE_CHAT=false

#Lock the public chat
LOCK_PUBLIC_CHAT=false

#Lock the shared notes 
LOCK_SHARED_NOTES=false

#Lock the mic 
LOCK_MICROPHONE=false

#Lock the webcam 
LOCK_WEBCAM=false

#If enabled, viewers will not able to see other viewers
HIDE_USER_LIST=false
```

### Audio and Video optimization

```bash
#Enable mediasoup for webcam and screensharing instread of kurento
ENABLE_MEDIASOUP=false

#Enable multiple kurento for better performance
ENABLE_MULTIPLE_KURENTO=false

#Set the default webcam resolution, Allowd values are low, medium, high, hd
WEBCAM_RESOLUTION=medium

#Enable recording optimization for ios devices
OPTIMIZE_RECORDING_FOR_IOS=true


#Enable this to fix audio issues such as 1007, 1020. 
#Reference: https://github.com/manishkatyan/bbb-optimize/tree/v1#fix-1007-and-1020-errors
FIX_AUDIO_ERROR=true

#If FIX_AUDIO_ERROR is set to true, then set your bbb server's  PUBLIC_IP
PUBLIC_IP=

```

### Miscellaneous settings

```bash
#Minimize the chat section on start
CHAT_START_CLOSED=false
#Set the log level for bbb; possible values are: INFO, DEBUG, WARN, ERROR,; default DBUG
LOG_LEVEL=DEBUG
```

<h2>Additional optimization</h2>

### Stream better quality audio
Edit `/usr/local/bigbluebutton/bbb-webrtc-sfu/config/default.yml` and make the following changes
```sh
maxaveragebitrate: "256000"
maxplaybackrate: "48000"
```

Edit `/opt/freeswitch/etc/freeswitch/autoload_configs/conference.conf.xml` and make the follwoing changes
```sh
<param name="interval" value="20"/>
<param name="channels" value="2"/>
<param name="energy-level" value="100"/>
```

Edit `/opt/freeswitch/etc/freeswitch/dialplan/default/bbb_conference.xml` and copy-and-paste the code below, removing the existig code
```xml
<?xml version="1.0" encoding="UTF-8"?>
<include>
   <extension name="bbb_conferences_ws">
      <condition field="${bbb_authorized}" expression="true" break="on-false" />
      <condition field="${sip_via_protocol}" expression="^wss?$" />
      <condition field="destination_number" expression="^(\d{5,11})$">
         <action application="set" data="jitterbuffer_msec=60:120:20" />
         <action application="set" data="rtp_jitter_buffer_plc=true" />
         <action application="set" data="rtp_jitter_buffer_during_bridge=true" />
         <action application="set" data="suppress_cng=true" />
         <action application="answer" />
         <action application="conference" data="$1@cdquality" />
      </condition>
   </extension>
   <extension name="bbb_conferences">
      <condition field="${bbb_authorized}" expression="true" break="on-false" />
      <condition field="destination_number" expression="^(\d{5,11})$">
         <action application="set" data="jitterbuffer_msec=60:120:20" />
         <action application="set" data="rtp_jitter_buffer_plc=true" />
         <action application="set" data="rtp_jitter_buffer_during_bridge=true" />
         <action application="set" data="suppress_cng=true" />
         <action application="answer" />
         <action application="conference" data="$1@cdquality" />
      </condition>
   </extension>
</include>
```

Edit `/opt/freeswitch/etc/freeswitch/autoload_configs/opus.conf.xml` and copy-and-paste the code below, removing the existig code

```xml
<?xml version="1.0" encoding="UTF-8"?>
<configuration name="opus.conf">
   <settings>
      <param name="use-vbr" value="1" />
      <param name="use-dtx" value="0" />
      <param name="complexity" value="10" />
      <param name="packet-loss-percent" value="15" />
      <param name="keep-fec-enabled" value="1" />
      <param name="use-jb-lookahead" value="1" />
      <param name="advertise-useinbandfec" value="1" />
      <param name="adjust-bitrate" value="1" />
      <param name="maxaveragebitrate" value="256000" />
      <param name="maxplaybackrate" value="48000" />
      <param name="sprop-maxcapturerate" value="48000" />
      <param name="sprop-stereo" value="1" />
      <param name="negotiate-bitrate" value="1" />
   </settings>
</configuration>
```

[Reference](https://groups.google.com/g/bigbluebutton-setup/c/3Y7VBllwpX0/m/41X9j8bvCAAJ)


### Secure recordings

With default BBB installation, anyone can share playback recording of your classes on Facebook or WhatsApp for everyone to view.

To secure your recordings, you can make it accessible only from a certain domain. For example, allow recordings to be accessed from theh domain of your Moodle site.


For BBB version greater that 2.3 or 2.4:

```bash
#edit /etc/bigbluebutton/nginx/playback.nginx 

location /playback/presentation/2.3 {
  root /var/bigbluebutton;
  try_files $uri /playback/presentation/2.3/index.html;

    # Restrict access
    valid_referers server_names
      bbb.youdomain.com;
    if ($invalid_referer) {
      return 404;
    }
  # End - Restrict access

}

```

For BBB 2.2:

```bash
# edit /etc/bigbluebutton/nginx/presentation.nginx

  location /playback/presentation {
    root   /var/bigbluebutton;
    index index.html index.htm;

  # Restrict access
    valid_referers server_names
      bbb.youdomain.com;
    if ($invalid_referer) {
      return 404;
    }
  # End - Restrict access
  }

```


### No logs

#### 1. BigBlueButton logging
```
# BigBlueButton logs location: /var/log/bigbluebutton/bbb-web.log. To limit this log, set
# (1) change appLogLevel from DEBUG to ERROR
vi /usr/share/bbb-web/WEB-INF/classes/bigbluebutton.properties
# (2) change each logger level to ERROR (default INFO and DEBUG)
vi /usr/share/bbb-web/WEB-INF/classes/logback.xml

# To avoid logging ip-addresses in bbb-webrtc-sfu change log > level to error (default verbose)
vi /usr/local/bigbluebutton/bbb-webrtc-sfu/config/default.yml

# To change logs level for chat usage and chat messages, change loglevel to ERROR
vi /etc/bbb-transcode-akka/application.conf (default INFO)
vi /etc/bbb-transcode-akka/logback.xml (default INFO, DEBUG, WARN]
vi /etc/bbb-apps-akka/application.conf (default DEBUG)
vi /etc/bbb-apps-akka/logback.xml (default INFO DEBUG)
```

#### 2. Nginx
```
# Nginx logs - change access log 
vi /etc/nginx/nginx.conf
access_log /dev/null; (default /var/log/nginx/access.log)

# Nginx logs - change access log
vi /etc/nginx/sites-available/bigbluebutton
access_log /dev/null; (default /var/log/nginx/bigbluebutton.access.log)
```

#### 3. Freeswitch
```
# Freeswitch logs - change loglevel and stdout-loglevel to ERROR (default DEBUG)
vi /etc/bbb-fsesl-akka/application.conf

# Freeswitch logs - change logger to ERROR (default INFO, DEBUG, WARN)
vi /etc/bbb-fsesl-akka/logback.xml
```

#### 4. Red5
```
# red5 - change root > level to ERROR and each logger to ERROR (default INFO)
vi /etc/red5/logback.xml
```
#### 5. Kurento
```
# export GST_DEBUG="1 ..." (Default is 3; Set it to 1, that is for Error)
vi /etc/default/kurento-media-server
```

#### 6. Greenlight

```
vi .env

# Comment the following live to send logs to log/production.log 
# RAILS_LOG_TO_STDOUT=true

# Create symlink, replacing $GREENLIGHTDIR with the absolute path where Greenlight is installed. 
ln -s /dev/null $GREENLIGHTDIR/log/production.log
```

#### 7. Scalelite
The Scalelite API container is logging user activities. For example: Who joined which meeting.
This logfile will never be deleted automatically and it will get quite large, if scalelite is serving many users.
Hence, delete logs via cronjobs.

```
# Login as root
crontab -e

# add to delete all Docker-Container-Logfiles. At 03:00 every sunday and thursday.
0 3 * * 0,4 truncate -s 0 /var/lib/docker/containers/*/*-json.log
```

#### 8. Coturn 
```
ln -s /dev/null /var/log/coturn.log
```

#### 9. Rotate Logs
If you want to keep logs, you can set days for which logs should be kept on the BBB server.
```
# Change log_history to 7 days (or as appropriate)
vi /etc/cron.daily/bigluebutton

# Change rotate to 7 (days) or as appropriate (this rotates log for /var/log/bigbluebutton/(bbb-rap-worker.log|sanity.log)
vi /etc/logrotate.d/bbb-record-core.logrotate

# Change rotate to 7 (days) or as appropriate (this rotates log for /var/log/bbb-webrtc-sfu/)
vi bbb-webrtc-sfu.logrotate

# Change MaxHistory to 7 (days) or as appropriate (this rotates log for /var/log/bigbluebutton/bbb-web.log)
vi /usr/share/bbb-web/WEB-INF/classes/logback.xml
```

### No Syslog entries
```ssh
# Edit /usr/lib/systemd/system/bbb-htlm5.service
StandardOutput=null
# Restart
systemctl daemon-reload
```


### Set server Timezone

```bash
# Current timezone
timedatectl

# List of available timezone
timedatectl list-timezones

# Set new timezone by replacing Asia/Kolkata with your timezone
timedatectl set-timezone Asia/Kolkata
```

### Restart BBB everyday

```bash
crontab -e

#restart bbb at 2 AM  everyday
00 2 * * * /usr/bin/bbb-conf --restart
```
## Artificial Intelligence powered Online Classes on BigBlueButton
Use live transcription, speech-to-speech translation and class notes with topics, summaries and sentiment analysis to guarantee the success of your online classes

### Transcription [DEMO](https://higheredlab.com/)
Help your students understand better by providing automated class notes
1. MP4 class recordings with subtitles
2. Full transcription of the class with topics, summary and sentiments

### Translation [DEMO](https://higheredlab.com/)
Speech-to-speech translate your classes in real-time into 100+ languages
1. Hear real-time translation of the class in any of 100+ language such as French, Spanish and German
2. View the captions in translated languages

## BigBlueButton-as-a-Service

Everything you need for online classes at scale on BigBlueButton, starting at $12 / month:
1. HD video
2. View attendance
3. Stream on YouTube
4. Integrate with Moodle
5. Upgrade/cancel anytime

[Click here to get started](https://higheredlab.com/pricing/)


## More on BigBlueButton

Check-out the following apps to further extend features of BBB.

### [bbb-jamboard](https://github.com/manishkatyan/bbb-jamboard)

The default whiteboard of BigBlueButton has limited features including no eraser. Many teachers wish to have a more features-rich whiteboard that would help them better in conducting online classes.

With BBB-Jamboard, you can easily integrate Google Jamboard into your BigBlueButton server.

Jamboard is a digital interactive whiteboard developed by Google and can be used in stead of the default BugBlueButton whiteboard. Google Jamboard has the eraser feature that has often been requested by BigBlueButton users.

### [bbb-twilio](https://github.com/manishkatyan/bbb-twilio)

Integrate Twilio into BigBlueButton so that users can join a meeting with a dial-in number. You can get local numbers for almost all the countries.

### [bbb-mp4](https://github.com/manishkatyan/bbb-mp4)

With this app, you can convert a BigBlueButton recording into MP4 video and upload to S3. You can covert multiple MP4 videos in parallel or automate the conversion process.

### [bbb-streaming](https://github.com/manishkatyan/bbb-streaming)

Livestream your BigBlueButton classes on Youtube or Facebook to thousands of your users.

### [100 Most Googled Questions on BigBlueButton](https://higheredlab.com/bigbluebutton-guide/)

Everything you need to know about BigBlueButton including pricing, comparison with Zoom, Moodle integrations, scaling, and dozens of troubleshooting.



<br/><br/>

## 📝 License

[MIT License](LICENSE.md)

Copyright (c) [HigherEdLab.com](https://higheredlab.com/)
