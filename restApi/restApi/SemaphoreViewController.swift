//
//  SemaphoreViewController.swift
//  restApi
//
//  Created by Ксения Чепурных on 24.06.2022.
//

import UIKit

class SemaphoreViewController: UIViewController {

    @IBOutlet weak var doneLabel: UILabel!
    @IBOutlet var taskView: [UIView]!
    @IBOutlet weak var startButton: UIButton!

    private let mainBlueColor = UIColor(
        red: 38 / 255,
        green: 87 / 255,
        blue: 228 / 255,
        alpha: 1
    )
    private let queue = DispatchQueue(label: "queue", attributes: .concurrent)
    private let semaphore = DispatchSemaphore(value: 2)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    @IBAction func start(_ sender: Any) {
        for index in 0..<taskView.count {
            task(index: index)
        }
    }

}

// MARK: - Private Methods

private extension SemaphoreViewController {

    func configure() {
        startButton.layer.cornerRadius = 10
        doneLabel.isHidden = true
        taskView.forEach {
            $0.layer.cornerRadius = 10
        }
    }

    func task(index: Int) {
        print("❌ start task \(index + 1)")

        queue.async { [weak self] in
            self?.semaphore.wait()
            ActivityService.shared.getActivities(activity: .init()) { [weak self] res in
                sleep(1)
                print("✅ task \(index + 1) complete!")

                DispatchQueue.main.async {
                    self?.taskView[index].backgroundColor = self?.mainBlueColor
                }

                self?.semaphore.signal()
            }
        }
    }

}

