//
//  XViewController.swift
//  XSampleApp
//
//  Created by にしいけんすけ on 2024/04/18.
//

import UIKit

class EditViewController: UIViewController {
    
    @IBOutlet weak var tweetTextView: UITextView!
    
    @IBOutlet weak var userNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextView()
    }
    
    func configureTextView() {
    }
    
    // 閉じるボタンをタップ
    @IBAction func didTapCancelButton(_ sender: Any) {
        // 前の画面に戻る
        dismiss(animated: true, completion: nil)
    }
}


