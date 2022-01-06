import Foundation
import SwiftUI
import AVKit
import MediaPlayer


struct VideoPlayerLayerView: UIViewRepresentable {
  func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<VideoPlayerLayerView>) {
  }

  func makeUIView(context: Context) -> UIView {
    return PlayerLayerView(frame: .zero)
  }
}

class PlayerLayerView: UIView {
  private let playerLayer = AVPlayerLayer()

  override init(frame: CGRect) {
    super.init(frame: frame)

    let url = URL(string: "https://bitdash-a.akamaihd.net/content/sintel/hls/playlist.m3u8")!
    let player = AVPlayer(url: url)
    player.play()
    player.isMuted = true

    playerLayer.player = player
    layer.addSublayer(playerLayer)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    playerLayer.frame = bounds
  }
}

struct VideoControllerView: UIViewControllerRepresentable {
  private var player: AVPlayer {
    let url = URL(string: "https://bitdash-a.akamaihd.net/content/sintel/hls/playlist.m3u8")!
    return AVPlayer(url: url)
  }

  func updateUIViewController(_ playerController: AVPlayerViewController, context: Context) {
    playerController.player = player
    playerController.player?.isMuted = true
    playerController.player?.play()
  }

  func makeUIViewController(context: Context) -> AVPlayerViewController {
    let controller = AVPlayerViewController()
    controller.updatesNowPlayingInfoCenter = false
    controller.showsPlaybackControls = false
    return controller
  }
}
