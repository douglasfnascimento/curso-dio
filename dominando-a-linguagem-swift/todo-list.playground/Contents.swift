import Foundation

enum Priority: String {
    case low = "Baixa"
    case medium = "Média"
    case high = "Alta"
}

enum TaskType {
    case all
    case quick
    case normal
}


var tasks: [Task] = []
var quickTasks: [QuickTask] = []
var normalTasks: [NormalTask] = []
var openedTasks: [Task] = []
var finishedTasks: [Task] = []


protocol Task {
    var title: String { get }
    var isDone: Bool { get }
    
    func markAsDone()
    func showDetails()
}

class QuickTask: Task {
    var title: String
    var isDone = false
    
    init(title: String) {
        self.title = title
    }
    
    func markAsDone() {
        isDone = true
        
        var indexesToRemove: [Int] = []

        for (index, task) in openedTasks.enumerated() {
            if task.isDone {
                indexesToRemove.append(index)
                finishedTasks.append(task)
            }
        }

        for index in indexesToRemove.reversed() {
            openedTasks.remove(at: index)
        }
    }
    
    func showDetails() {
        print("Tarefa rápida: \(title)")
        if isDone {
            print("Status: Concluída")
        } else {
            print("Status: Não concluída")
        }
    }
}

class NormalTask: Task {
    var title: String
    var description: String?
    var isDone = false
    var priority: Priority?
    
    init(title: String, description: String, priority: Priority) {
        self.title = title
        self.description = description
        self.priority = priority
    }
    
    
    func markAsDone() {
        isDone = true
        
        var indexesToRemove: [Int] = []

        for (index, task) in openedTasks.enumerated() {
            if task.isDone {
                indexesToRemove.append(index)
                finishedTasks.append(task)
            }
        }

        for index in indexesToRemove.reversed() {
            openedTasks.remove(at: index)
        }
    }
    
    func showDetails() {
        print("\(title): \(description ?? "Sem descrição")\nPrioridade: \(priority?.rawValue ?? "Sem prioridade definida")")
        if isDone {
            print("Status: Concluída")
        } else {
            print("Status: Não concluída")
        }
    }
}


func addTask(type: TaskType, title: String, description: String?, priority: Priority?) {
    switch type {
    case .quick:
        var newTask = QuickTask(title: title)
        tasks.append(newTask)
        quickTasks.append(newTask)
        openedTasks.append(newTask)
        
    case .normal:
        var newTask = NormalTask(title: title, description: description ?? "", priority: priority ?? .medium)
        tasks.append(newTask)
        normalTasks.append(newTask)
        openedTasks.append(newTask)
    default:
        print("Erro: Você deve escolher entre .quick e .normal")
    }
}

func listTasks(type: TaskType) {
    switch type {
        case .all:
        print("Aqui está a lista de todas as tarefas")
            for task in tasks {
                print(task.title)
        }
        case .quick:
        print("Aqui está a sua lista de tarefas rápidas")
            for task in quickTasks {
                print(task.title)
        }
        case .normal:
        print("Aqui está a sua lista de tarefas")
            for task in normalTasks {
                print(task.title)
        }
    }
}

func detailTask(name: String) {
    for task in tasks {
        if name == task.title {
            task.showDetails()
        }
    }
}
