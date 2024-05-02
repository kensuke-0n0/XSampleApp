//
//  TimeLineViewController.swift
//  XSampleApp
//
//  Created by にしいけんすけ on 2024/04/09.
//

import UIKit
import RealmSwift

/// タイムライン画面
class TimeLineViewController: UIViewController {
    
    // MARK: - Properties
    
    private var tweetDataList: [TweetDataModel] = []
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - View Life-Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        fetchData()
    }
    
    // MARK: - IBActions
    
    /// ツイートボタンをタップ
    @IBAction private func didTapTweetButton(_ sender: Any) {
        let editVC = EditViewController()
        editVC.delegate = self
        editVC.modalPresentationStyle = .fullScreen
        present(editVC, animated: true)
    }
    
    // MARK: - Other Methods
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        let nib = UINib(nibName: "XTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "cell")
    }
    
    /// データ取得
    private func fetchData() {
        do {
            let realm = try Realm()
            let result = realm.objects(TweetDataModel.self)
            tweetDataList = Array(result)
            tableView.reloadData()
        } catch {
            // 取得失敗時の処理
            print("データの取得エラー:\(error)")
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

// MARK: - UITableViewDataSource

extension TimeLineViewController: UITableViewDataSource {
    /// セルの数を返すメソッド
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweetDataList.count
    }
    
    /// 各セルの内容を返すメソッド
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)as! XTableViewCell
        cell.setup(userName: tweetDataList[indexPath.row].userName,
                   detail: tweetDataList[indexPath.row].tweetText)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension TimeLineViewController: UITableViewDelegate {
    /// セルの高さを設定する。
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // セルの高さを自動調整する。
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let editVC = EditViewController()
        editVC.setData(tweetData: tweetDataList[indexPath.row])
        editVC.delegate = self
        editVC.modalPresentationStyle = .fullScreen
        present(editVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let targetTweet = tweetDataList[indexPath.row]
        do {
            let realm = try Realm()
            try realm.write {
                realm.delete(targetTweet)
            }
            // 削除成功時の処理
            tweetDataList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        } catch {
            // 削除失敗時の処理
            print("データの削除エラー: \(error)")
            showAlert()
        }
    }
}

// MARK: - EditViewControllerDelegate

extension TimeLineViewController: EditViewControllerDelegate {
    /// 「決定」ボタンをタップ時
    func updateView() {
        fetchData()
    }
}

