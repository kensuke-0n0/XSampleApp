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
    func updateView()
}

class EditViewController: UIViewController {
    
    // MARK: - Properties
    
    private let placeholderText = "いまどうしてる？"
    private var dataModel = TweetDataModel()
    weak var delegate: EditViewControllerDelegate?
    private var id: String?
    private var savedUserName: String = ""
    private var savedTweetText: String = ""
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var userNameTextField: UITextField!
    @IBOutlet private weak var tweetTextView: UITextView!
    
    // MARK: - View Life-Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextField()
        configureTextView()
    }
    
    // MARK: - IBActions
    
    @IBAction private func didTapCancelButton(_ sender: Any) {
        // 前の画面に戻る
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction private func didTapPostButton(_ sender: Any) {
        if savedUserName.isEmpty {
            saveData()
        } else {
            updateData()
        }
    }
    
    // MARK: - Other Methods
    
    func setData(tweetData: TweetDataModel) {
        id = tweetData.id
        savedUserName = tweetData.userName
        savedTweetText = tweetData.tweetText
    }
    
    private func configureTextField() {
        if !savedUserName.isEmpty {
            userNameTextField.text = savedUserName
        }
    }
    
    private func configureTextView() {
        if savedTweetText.isEmpty {
            // プレースホルダーテキストを設定
            tweetTextView.text = placeholderText
            tweetTextView.textColor = UIColor.lightGray
        } else {
            tweetTextView.text = savedTweetText
        }
        // デリゲートを設定
        tweetTextView.delegate = self
    }
    
    /// データを保存
    private func saveData() {
        guard let userName = userNameTextField.text,
              let tweetText = tweetTextView.text else { return }
        do {
            let realm = try Realm()
            try realm.write {
                dataModel.userName = userName
                dataModel.tweetText = tweetText
                realm.add(dataModel)
            }
            // 戻る際にデリゲートを発動し、元画面を更新する
            delegate?.updateView()
            // 前の画面に戻る
            dismiss(animated: true, completion: nil)
        } catch {
            print("データの追加エラー: \(error)")
            showAlert()
        }
    }
    
    /// データを更新
    private func updateData() {
        guard let id = id,
              let userName = userNameTextField.text,
              let tweetText = tweetTextView.text else { return }
        do {
            let realm = try Realm()
            let results = realm.objects(TweetDataModel.self).filter("id == %@", id)
            // 取得した結果をループして更新
            try! realm.write {
                for tweetData in results {
                    tweetData.userName = userName
                    tweetData.tweetText = tweetText
                }
            }
            // 戻る際にデリゲートを発動し、元画面を更新する
            delegate?.updateView()
            // 前の画面に戻る
            dismiss(animated: true, completion: nil)
            
        } catch {
            // 更新失敗時の処理
            print("データの取得エラー: \(error)")
            showAlert()
        }
    }
    
    /// アラートを表示
    private func showAlert() {
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
