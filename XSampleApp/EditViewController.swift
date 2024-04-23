//
//  EditViewController.swift
//  XSampleApp
//
//  Created by にしいけんすけ on 2024/04/22.
//

import UIKit

class EditViewController: UIViewController {
    
    // MARK: - Properties
    
    let placeholderText = "いまどうしてる？"
    let placeholderTextField = "ユーザー名を入力してください"
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var tweetTextView: UITextView!
    
    // MARK: - View Life-Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTextView()
    }
    
    // MARK: - IBActions
    
    @IBAction func didTapCancelButton(_ sender: Any) {
        // 前の画面に戻る
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTapPostButton(_ sender: Any) {
    }
    
    // MARK - Other Methods
    
    func configureTextView() {
        // プレースホルダーテキストを設定
        tweetTextView.text = placeholderText
        tweetTextView.textColor = UIColor.lightGray
        
        userNameTextField.text = placeholderTextField
        userNameTextField.textColor = UIColor.lightGray
    }
}
