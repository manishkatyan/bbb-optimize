# bbb-customize
Here are some tips to customize and optimize BigBlueButton server. 

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


