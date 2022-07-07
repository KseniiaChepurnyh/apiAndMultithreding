//
//  DispatchGroupViewController.swift
//  restApi
//
//  Created by Ксения Чепурных on 24.06.2022.
//

import UIKit

class DispatchGroupViewController: UIViewController {

    @IBOutlet weak var doneLabel: UILabel!
    @IBOutlet var taskView: [UIView]!
    @IBOutlet weak var startButton: UIButton!

    private let group = DispatchGroup()
    private let mainBlueColor = UIColor(
        red: 38 / 255,
        green: 87 / 255,
        blue: 228 / 255,
        alpha: 1
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    @IBAction func start(_ sender: Any) {
        for index in 0..<taskView.count {
            task(index: index, group: group)
        }

        group.notify(queue: .main) { [weak self] in
            self?.doneLabel.isHidden = false
        }
    }

}

// MARK: - Private Methods

private extension DispatchGroupViewController {

    func configure() {
        startButton.layer.cornerRadius = 10
        doneLabel.isHidden = true
        taskView.forEach {
            $0.layer.cornerRadius = 10
        }
    }

    func task(index: Int, group: DispatchGroup) {
        print("❌ start task \(index + 1)")

        group.enter()
        ActivityService.shared.getActivities(activity: .init()) { [weak self] res in
            print("✅ task \(index + 1) complete!")

            DispatchQueue.main.async {
                self?.taskView[index].backgroundColor = self?.mainBlueColor
            }

            self?.group.leave()
        }
    }
}
