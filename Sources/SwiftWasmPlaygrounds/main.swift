import TokamakShim

struct TokamakApp: App {
    var body: some Scene {
        WindowGroup("SwiftWasmPlaygrounds App") {
            ContentView()
        }
    }
}

// @main attribute is not supported in SwiftPM apps.
// See https://bugs.swift.org/browse/SR-12683 for more details.
TokamakApp.main()
