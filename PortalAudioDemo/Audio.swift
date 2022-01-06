import Foundation
import AVFoundation
import MediaPlayer

class Audio: ObservableObject {
  var isSetup = false

  let engine = AVAudioEngine()
  let playerNode = AVAudioPlayerNode()

  var source: AVAudioFile {
    try! AVAudioFile.init(forReading: Bundle.main.url(forResource: "bluebells", withExtension: "m4a")!)
  }

  @Published var isPlaying = false

  init() {
    try! AVAudioSession.sharedInstance().setCategory(.playback,
                                                     mode: .default,
                                                     policy: .longFormAudio)
    prepareCommandCenter()
  }

  func start() {
    guard isSetup == false else { return }

    engine.attach(playerNode)
    engine.connect(playerNode, to: engine.outputNode, format: source.processingFormat)
    playerNode.scheduleFile(source, at: nil, completionHandler: nil)
    isSetup = true
  }

  func stop() {
    engine.stop()
  }

  func play() {
    try! engine.start()
    if playerNode.isPlaying == false { playerNode.play() }
    isPlaying = true
    updateNowPlayingInfo()
  }

  func pause() {
    engine.pause()
    isPlaying = false
    updateNowPlayingInfo()
  }

  private func prepareCommandCenter () {
    let commandCenter = MPRemoteCommandCenter.shared()

    commandCenter.playCommand.isEnabled = true
    commandCenter.playCommand.addTarget { [unowned self] event in
      play()
      return .success
    }

    commandCenter.pauseCommand.isEnabled = true
    commandCenter.pauseCommand.addTarget { [unowned self] event in
      pause()
      return .success
    }

    MPNowPlayingInfoCenter.default().nowPlayingInfo = nil
  }

  private func updateNowPlayingInfo() {
    let nowPlayingInfoCenter = MPNowPlayingInfoCenter.default()
    var nowPlayingInfo = nowPlayingInfoCenter.nowPlayingInfo ?? [String: Any]()
    let playbackRate = NSNumber(value: isPlaying ? 1.0 : 0.0)
    nowPlayingInfo[MPNowPlayingInfoPropertyMediaType] = NSNumber(value: MPNowPlayingInfoMediaType.audio.rawValue)
    nowPlayingInfo[MPMediaItemPropertyArtist] = "Portal Test"
    nowPlayingInfo[MPMediaItemPropertyTitle] = "Bluebells"
    nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = playbackRate
    MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
  }
}
