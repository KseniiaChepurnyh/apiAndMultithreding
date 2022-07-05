//
//  ActivityViewController.swift
//  restApi
//
//  Created by Ксения Чепурных on 24.06.2022.
//

import UIKit

class ActivityViewController: UIViewController {

    @IBOutlet weak var activityLabel: UILabel!

    private var activity: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let activity = activity else {
            activityLabel.text = "No activity found with the specified parameters :("
            return
        }
        activityLabel.text = activity
    }

    public func configure(with activity: String?) {
        self.activity = activity
    }

}
