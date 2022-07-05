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
        queue.maxConcurrentOperationCount = 2
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
        let task1 = BlockOperation {
            print("❌ start task 1")
            ActivityService.shared.getActivities(activity: .init()) { [weak self] res in
                sleep(1)
                OperationQueue.main.addOperation { [weak self] in
                    self?.taskView[0].backgroundColor = self?.mainBlueColor
                }
                print("✅ task 1 complete!")
            }
        }
        let task2 = BlockOperation {
            print("❌ start task 2")
            ActivityService.shared.getActivities(activity: .init()) { [weak self] res in
                sleep(1)
                OperationQueue.main.addOperation { [weak self] in
                    self?.taskView[1].backgroundColor = self?.mainBlueColor
                }
                print("✅ task 2 complete!")
            }
        }
        let task3 = BlockOperation {
            print("❌ start task 3")
            ActivityService.shared.getActivities(activity: .init()) { [weak self] res in
                sleep(1)
                OperationQueue.main.addOperation { [weak self] in
                    self?.taskView[2].backgroundColor = self?.mainBlueColor
                }
                print("✅ task 3 complete!")
            }
        }
        let task4 = BlockOperation {
            print("❌ start task 4")
            ActivityService.shared.getActivities(activity: .init()) { [weak self] res in
                sleep(1)
                OperationQueue.main.addOperation { [weak self] in
                    self?.taskView[3].backgroundColor = self?.mainBlueColor
                }
                print("✅ task 4 complete!")
            }
        }

        task3.addDependency(task1)
        task3.addDependency(task2)
        task3.addDependency(task4)

        let tasks = [task3, task1, task4, task2]
        queue.addOperations(tasks, waitUntilFinished: false)
    }

}
