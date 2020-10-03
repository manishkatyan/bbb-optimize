# bbb-optimize
Here are techniques to optimize and smoothly run your BigBlueButton server, including increasing recording processing speed, dynamic video profile, pagination, fixing 1007/1020 errors and using apply-config.sh. 

## Manage customizations

Keep all customizations of BigBlueButton server in apply-config.sh so that (1) all your BBB servers have same customizations without any errors, and (2) you don't lose them while upgrading.

```sh
git clone https://github.com/manishkatyan/bbb-optimize.git
cd bbb-optimize
cp apply-config-sample.sh apply-config.sh
cp apply-config.sh /etc/bigbluebutton/bbb-conf/apply-config.sh
```
Edit `apply-config.sh` as appropriate.

## Change recording processing speed
```sh
vi /usr/local/bigbluebutton/core/lib/recordandplayback/generators/video.rb
```
Make the following changes on line 58 and line 124 to speed up recording processing time by 5-6 times:
`-quality realtime -speed 5 -tile-columns 2 -threads 4`

[Reference](https://github.com/bigbluebutton/bigbluebutton/issues/8770)

Please keep in mind that it uses a more CPU which can affect the performance of live on-going classes on BigBlueButton.

Hence, its better to change the schedule of processing internal for recordings along with this change. 

## Change processing interval for recordings

Normally, the BigBlueButton server begins processing the data recorded in a session soon after the session finishes. However, you can change the timing for processing by creating an override for the default bbb-record-core.timer.

For example, you can configure your BBB server to process recording job after most of classes are done in the day during off-peak hours (6 PM to 6 AM). 

```sh
sudo systemctl edit bbb-record-core.timer
```

Copy and paste the following contents and save the file:
```sh
[Timer]
# Disable the default timer
OnUnitInactiveSec=

# Run every minute from 18:00 to 05:59
OnCalendar=18,19,20,21,22,23,00,01,02,03,04,05:*
```

This will create an override at `/etc/systemd/system/bbb-record-core.timer.d/override.conf`.

[Reference](https://docs.bigbluebutton.org/install#change-processing-interval-for-recordings)

## Use MP4 format for playback of recordings
The presentation playback format encodes the video shared during the session (webcam and screen share) as .webm (VP8) files.

You can change the format to MP4 for two reasons: (1) increase recording processing speed, and (2) enable playback of recordings on iOS devices.

Edit `/usr/local/bigbluebutton/core/scripts/presentation.yml` and uncomment the entry for mp4.
video_formats:
```sh 
#- webm
- mp4
```

## Dynamic Video Profile

aka automatic bitrate/frame rate throttling.   To control camera framerate and bitrate that scales according to the number of cameras in a meeting.
To decrease server AND client CPU/bandwidth usage for meetings with many cameras. Leads to significant difference in responsiveness, CPU usage and bandwidth usage (for the better) with this PR.

Edit `/usr/share/meteor/bundle/programs/server/assets/app/config/settings.yml` and set
```sh
cameraQualityThresholds:
      enabled: true
```

## Video Pagination

You can control the number of webcams visible to meeting participants at a single time. 

Edit `/usr/share/meteor/bundle/programs/server/assets/app/config/settings.yml` and set
```sh
pagination:
  enabled: true
```

## Stream better quality audio
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


## Fix 1007 and 1020 errors

Follow the steps below to resolve 1007/1020 errors that your users may resport in case they are behind a firewall.

#### 1. Update `external.xml` and `vars.xml`
Edit `/opt/freeswitch/conf/sip_profiles/external.xml` and change
```xml
<param name="ext-rtp-ip" value="$${local_ip_v4}"/>
<param name="ext-sip-ip" value="$${local_ip_v4}"/>
```
To 
```xml
<param name="ext-rtp-ip" value="$${external_rtp_ip}"/>
<param name="ext-sip-ip" value="$${external_sip_ip}"/>
```

Edit `/opt/freeswitch/conf/vars.xml`, and change
```xml
<X-PRE-PROCESS cmd="set" data="external_rtp_ip=stun:stun.freeswitch.org"/>
<X-PRE-PROCESS cmd="set" data="external_sip_ip=stun:stun.freeswitch.org"/>
```
To 
```xml
<X-PRE-PROCESS cmd="set" data="external_rtp_ip=EXTERNAL_IP_ADDRESS"/>
<X-PRE-PROCESS cmd="set" data="external_sip_ip=EXTERNAL_IP_ADDRESS"/>
```

#### 2. Verify Turn server is accessible 
Verify Turn server is accessible from your BBB serve. If you receive code 0x0001c means STUN is not working. Log into your BBB server and execute the following command: 

```sh
sudo apt install stun-client
stun turn.higheredlab.com
```
Here is another way to test whether a Stun server, we are using Google’s public Stun server, is accessible from your BBB server. Localport could be any available UDP port on your BBB server.

```sh
sudo apt-get install -y stuntman-client $ stunclient --mode full --localport 30000 turn.higheredlab.com 3478
```
Your output should be something like the following:

```sh
Binding test: success
Local address: 95.216.242.244:30000
Mapped address: 95.216.242.244:30000
Behavior test: success
Nat behavior: Direct Mapping
Filtering test: success
Nat filtering: Endpoint Independent Filtering
```

Configure BigBlueButton to use the coturn server by following the instruction [here](https://docs.bigbluebutton.org/2.2/setup-turn-server.html#configure-bigbluebutton-to-use-the-coturn-server)

#### 3. Change in `/etc/turnserver.conf` on the Turn server:
```sh
realm=bbbturn15.derspaneli.com
listening-port=3478 #gets error when you setup port 80
tls-listening-port=443
realm=FQDN of Turn server
listening-ip=Public-IP-of-Turn server
external-ip=Public-IP-of-Turn-server
```

#### 4. Set external IP in WebRtcEndpoint.conf.ini 
Edit `/etc/kurento/modules/kurento/WebRtcEndpoint.conf.ini`

Mention external or public IP address of the media server by uncommenting the line below. Doing so has the advantage of not needing to configure STUN/TURN for the media server.
```sh
externalAddress=Public-IP-of-BBB-Server
```

STUN/TURN are needed only when the media server sits behind a NAT and needs to find out its own external IP address. However, if you set a static external IP address as mentioned above, then there is no need for the STUN/TURN auto-discovery. Hence, comment the following: using turn.higheredlab.com (IP address)
```sh
#stunServerAddress=95.217.128.91
#stunServerPort=3478
```

#### 5. Verify your media negotiation timeouts. 
Recommend setting is to set `baseTimeout` to `30000` in `/usr/share/meteor/bundle/programs/server/assets/app/config/settings.yml`


#### 6. Verify Turn is working
Visit `https://webrtc.github.io/samples/src/content/peerconnection/trickle-ice/` to check whether your Turn sevrer is working and enter the details below. Change Turn server URL to your Turn server URL.  
```sh
STUN or TURN URI: turn:turn.higheredlab.com:443?transport=tcp
TURN username:
TURN password: xxxx
```

Execute the code below to generate username and password. Replace `f2355fea3841c9b91e9a64abe9850c61` with the `static-auth-secret` from `/etc/turnserver.conf` file on the turn server.

```sh
secret=f2355fea3841c9b91e9a64abe9850c61 && \
time=$(date +%s) && \
expiry=8400 && \
username=$(( $time + $expiry )) &&\
echo username:$username && \
echo password : $(echo -n $username | openssl dgst -binary -sha1 -hmac $secret | openssl base64)
```
Then click `Add Server` and then `Gather candidates` button. If you have done everything correctly, you should see `Done` as the final result. If you do not get any response or if you see any error messages, please double check if you have diligently followed above steps.

## More on BigBlueButton

Check-out the following projects to further extend features of BBB.

### [bbb-twilio](https://github.com/manishkatyan/bbb-twilio)

Integrate Twilio into BigBlueButton so that users can join a meeting with a dial-in number. You can get local numbers for almost all the countries.

### [bbb-mp4](https://github.com/manishkatyan/bbb-mp4)

With this app, you can convert a BigBlueButton recording into MP4 video and upload to S3. You can covert multiple MP4 videos in parallel or automate the conversion process.

### [100 Most Googled Questions on BigBlueButton](https://higheredlab.com/bigbluebutton-guide/)

Everything you need to know about BigBlueButton including pricing, comparison with Zoom, Moodle integrations, scaling, and dozens of troubleshooting.


