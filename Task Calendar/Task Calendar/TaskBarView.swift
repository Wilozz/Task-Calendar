import SwiftUI

struct TaskBarView: View {
    @Binding var showAddTask: Bool
    
    var body: some View {
        HStack {
            Text("My Tasks")
                .font(.headline)
            Spacer()
            Button(action: {
                showAddTask = true
            }) {
                Image(systemName: "plus")
                    .padding(6)
            }
            .buttonStyle(.bordered)
        }
        .padding()
        .background(Color.gray.opacity(0.1))
    }
}
