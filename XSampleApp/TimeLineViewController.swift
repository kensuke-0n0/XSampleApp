//
//  TimeLineViewController.swift
//  XSampleApp
//
//  Created by にしいけんすけ on 2024/04/09.
//

import UIKit

class TimeLineViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    func configureTableView() {
        tableView.dataSource = self
        let nib = UINib(nibName: "XTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "cell")
    }
}

extension TimeLineViewController: UITableViewDataSource {
    /// セルの数を返すメソッド
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    /// 各セルの内容を返すメソッド
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)as! XTableViewCell
        cell.setup(userName: "太郎", detail: "ああああああ")
        return cell
    }
}

extension TimeLineViewController: UITableViewDelegate {
    /// セルの高さを設定する。
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        /// セルの高さを自動調整する。
        return UITableView.automaticDimension
    }
}
