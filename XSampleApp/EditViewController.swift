//
//  EditViewController.swift
//  XSampleApp
//
//  Created by にしいけんすけ on 2024/04/22.
//

import UIKit
import RealmSwift

    // MARK: - Protocols

protocol EditViewControllerDelegate: AnyObject {
    /// ビューを更新する
    func upDateView()
}

class EditViewController: UIViewController {
    
    // MARK: - Properties
    
    let placeholderText = "いまどうしてる？"
    var dataModel = TweetDataModel()
    var delegate: EditViewControllerDelegate?
    
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
        saveData()
    }
    
    // MARK: - Other Methods
    
    func configureTextView() {
        // プレースホルダーテキストを設定
        tweetTextView.text = placeholderText
        tweetTextView.textColor = UIColor.lightGray
        // デリゲートを設定
        tweetTextView.delegate = self
    }
    
    /// データを保存
    func saveData() {
        guard let userName = userNameTextField.text,
              let tweetText = tweetTextView.text else { return }
        do {
            let realm = try Realm()
            try realm.write {
                dataModel.userName = userName
                dataModel.tweetText = tweetText
                realm.add(dataModel)
            }
            // 戻る際にデリゲートを発動し、元画面のnameを更新する
            delegate?.upDateView()
            // 前の画面に戻る
            dismiss(animated: true, completion: nil)
        } catch {
            print("データの追加エラー: \(error)")
            showAlert()
        }
    }
    
    /// アラートを表示
    func showAlert() {
        let alert = UIAlertController(title: "エラーが発生しました",
                                      message: "",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - UITextViewDelegate

extension EditViewController: UITextViewDelegate {
    
    /// テキストが編集されたときに呼ばれる
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == placeholderText && textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    /// テキストフィールドがフォーカスを失ったときに呼ばれる
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = placeholderText
            textView.textColor = UIColor.lightGray
        }
    }
}
