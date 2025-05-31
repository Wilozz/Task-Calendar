import Foundation

class TaskStore: ObservableObject {
    @Published var tasks: [Task] = [] {
        didSet {
            saveTasks()
        }
    }
    
    private let fileName = "tasks.json"
    
    init() {
        loadTasks()
    }
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    private var fileURL: URL {
        getDocumentsDirectory().appendingPathComponent(fileName)
    }
    
    private func saveTasks() {
        do {
            let data = try JSONEncoder().encode(tasks)
            try data.write(to: fileURL)
        } catch {
            print("Failed to save tasks")
        }
    }
    
    private func loadTasks() {
        do {
            let data = try Data(contentsOf: fileURL)
            tasks = try JSONDecoder().decode([Task].self, from: data)
        } catch {
            print("Failed to load tasks")
            tasks = []
        }
    }
}
