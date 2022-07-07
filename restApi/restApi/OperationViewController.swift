//
//  OperationViewController.swift
//  restApi
//
//  Created by Ксения Чепурных on 24.06.2022.
//

import UIKit

class OperationViewController: UIViewController {

    @IBOutlet weak var doneLabel: UILabel!
    @IBOutlet var taskView: [UIView]!
    @IBOutlet weak var startButton: UIButton!

    private let queue = OperationQueue()
    private let mainBlueColor = UIColor(
        red: 38 / 255,
        green: 87 / 255,
        blue: 228 / 255,
        alpha: 1
    )

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        queue.maxConcurrentOperationCount = 1
    }

    @IBAction func start(_ sender: Any) {
        task()
    }

}

// MARK: - Private Methods

private extension OperationViewController {

    func configure() {
        startButton.layer.cornerRadius = 10
        doneLabel.isHidden = true
        taskView.forEach {
            $0.layer.cornerRadius = 10
        }
    }

    func task() {
        let task1 = ActivityOperation(taskName: "task1")
        let task2 = ActivityOperation(taskName: "task2")
        let task3 = ActivityOperation(taskName: "task3")
        let task4 = ActivityOperation(taskName: "task4")

        task1.completionBlock = {
            OperationQueue.main.addOperation { [weak self] in
                self?.taskView[0].backgroundColor = self?.mainBlueColor
            }
        }
        task2.completionBlock = {
            OperationQueue.main.addOperation { [weak self] in
                self?.taskView[1].backgroundColor = self?.mainBlueColor
            }
        }
        task3.completionBlock = {
            OperationQueue.main.addOperation { [weak self] in
                self?.taskView[2].backgroundColor = self?.mainBlueColor
            }
        }
        task4.completionBlock = {
            OperationQueue.main.addOperation { [weak self] in
                self?.taskView[3].backgroundColor = self?.mainBlueColor
            }
        }

        task1.addDependency(task2)
        task2.addDependency(task3)
        task3.addDependency(task4)

        queue.addOperations([task3, task1, task4, task2], waitUntilFinished: false)
    }

}
