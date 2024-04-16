//
//  TimeLineViewController.swift
//  XSampleApp
//
//  Created by にしいけんすけ on 2024/04/09.
//

import UIKit

/// タイムライン画面
class TimeLineViewController: UIViewController {
    
    // MARK: - Properties
    
    /// 詳細
    let details =  [
        "ああああああああああああああああああああああああああ",
        "あああああああああああああああああああああああああああああああああ",
        "ああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああ"
        ]
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - View Life-Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    // MARK: - IBActions
    
    /// ツイートボタンをタップ
    @IBAction func didTapTweetButton(_ sender: Any) {
    }
    
    // MARK: - Other Methods
    
    func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        let nib = UINib(nibName: "XTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "cell")
    }
}

// MARK: - UITableViewDataSource

extension TimeLineViewController: UITableViewDataSource {
    /// セルの数を返すメソッド
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return details.count
    }
    
    /// 各セルの内容を返すメソッド
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)as! XTableViewCell
        cell.setup(userName: "太郎", detail: details[indexPath.row])
        return cell
    }
}

extension TimeLineViewController: UITableViewDelegate {
    /// セルの高さを設定する。
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // セルの高さを自動調整する。
        return UITableView.automaticDimension
    }
}
