import SwiftUI

@main
struct Task_CalendarApp: App {
    @StateObject private var taskStore = TaskStore()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(taskStore)
        }
    }
}
