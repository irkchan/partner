//
//  PostData.swift
//  Instagram
//
//  Created by 吉田なつみ on 2021/10/22.
//

import Foundation
import UIKit
import Firebase

class PostData: NSObject {
    var id: String
    var name: String?
    var caption: String?
    var date: Date?
    //likeしてくれた人の名前
    var likes: [String] = []
    //likeしたかどうか
    var isLiked: Bool = false
    //コメント内容
    var coment:[String] = []
    //コメントした人の名前
    var comentUser:[String] = []

    init(document: QueryDocumentSnapshot) {
        self.id = document.documentID

        let postDic = document.data()

        self.name = postDic["name"] as? String

        self.caption = postDic["caption"] as? String

        let timestamp = postDic["date"] as? Timestamp
        self.date = timestamp?.dateValue()

        if let likes = postDic["likes"] as? [String] {
            self.likes = likes
        }
        if let myid = Auth.auth().currentUser?.uid {
            // likesの配列の中にmyidが含まれているかチェックすることで、自分がいいねを押しているかを判断
            if self.likes.firstIndex(of: myid) != nil {
                // myidがあれば、いいねを押していると認識する。
                self.isLiked = true
            }
        }
        
        if let coment = postDic["coment"] as? [String] {
            self.coment = coment
        }
        if let comentUser = postDic["comentUser"] as? [String] {
            self.comentUser = comentUser
        }
    }
}
