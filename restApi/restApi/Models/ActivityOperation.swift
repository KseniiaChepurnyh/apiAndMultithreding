//
//  ActivityOperation.swift
//  restApi
//
//  Created by Ксения Чепурных on 06.07.2022.
//

import UIKit

class ActivityOperation: Operation {

    public enum State: String {
        case ready
        case executing
        case finished
    
        var keyPath: String {
            return rawValue
        }
    }

    public var state = State.ready {
        willSet {
            willChangeValue(forKey: newValue.keyPath)
            willChangeValue(forKey: state.keyPath)
        }
        didSet {
            didChangeValue(forKey: oldValue.keyPath)
            didChangeValue(forKey: state.keyPath)
        }
    }

    override var isAsynchronous: Bool {
        return true
    }

    override var isReady: Bool {
        return super.isReady && state == .ready
    }

    override var isExecuting: Bool {
        return state == .executing
    }

    override var isFinished: Bool {
        return state == .finished
    }

    private let taskName: String

    init(taskName: String) {
        self.taskName = taskName
    }

    override func start() {
        main()
        state = .executing
    }

    override func main() {
        print("❌ start \(taskName)")
        ActivityService.shared.getActivities(activity: .init()) { [weak self] _ in
            self?.state = .finished
            print("✅ \(self?.taskName ?? "") complete!")
        }
    }
}
