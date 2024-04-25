//
//  TweetDataModel.swift
//  XSampleApp
//
//  Created by にしいけんすけ on 2024/04/25.
//

import RealmSwift

class TweetDataModel: Object {
    @Persisted var id: String = UUID().uuidString //データを一意に識別するための識別子
    @Persisted var あああ: String = ""
    @Persisted var いいい: Int = 0
}
