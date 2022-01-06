import SwiftUI

@main
struct PortalAudioDemoApp: App {
  @Environment(\.scenePhase) private var scenePhase

  @ObservedObject private var audio = Audio()
  @State private var showVideo = false

  var body: some Scene {
    WindowGroup {
      VStack{

        // hiding the video player causes MPNowPlayingInfoCenter to work as expected
        if showVideo {
          VideoPlayerLayerView()
          // or try, for same behaviour
          // VideoControllerView()
        } else {
          Spacer()
        }

        HStack {
          Button(action: {
            audio.isPlaying ? audio.pause() : audio.play()
          }) {
            if audio.isPlaying {
              Label("Pause Audio", systemImage: "pause")
            } else {
              Label("Play Audio", systemImage: "play")
            }
          }
          .buttonStyle(.bordered)

          Button(action: {
            showVideo.toggle()
          }) {
            if showVideo {
              Label("Remove Video", systemImage: "minus")
            } else {
              Label("Add Video", systemImage: "plus")
            }
          }
          .buttonStyle(.bordered)
        }
        .padding()

      }
    }
    .onChange(of: scenePhase) { newScenePhase in
      if newScenePhase == .active {
        audio.start()
      }
    }
  }
}
