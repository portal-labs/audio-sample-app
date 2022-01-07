This example App was built to test interactions with AVAudioEngine / AVPlayer and MPNowPlayingInfoCenter.

Testing steps:

1. Run the App on an iOS device.
2. Tap "Play Audio", audio starts playing.
3. Swipe into the control center and note that the play state is correct.
4. Switch back to the App, tap "Pause Audio", then back to CC and note play state has changed correctly.
5. Tap "Add Video", wait for video playback to start.
6. Swipe into the control center and note that the play state is now showing as playing, even though Audio is still muted.
7. Tap the "Pause" icon in CC, note nothing happens as audio is already paused.
8. Tap the "Play" icon in CC, The audio now starts playing.
9. Switch back to the App, tap "Pause Audio", then back to CC and note play state still shows as playing.
10. Tap "Remove Video"
11. Swipe into the control center and note that the play state is now correctly showing as paused again.
