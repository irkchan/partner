//
//  ComentViewCellViewController.swift
//  Instagram
//
//  Created by 吉田なつみ on 2021/10/25.
//

import UIKit
import Firebase
import SVProgressHUD


class ComentViewCellViewController: UIViewController {
    @IBOutlet weak var comentField: UITextField!
    var postData:PostData?
    //コメントするボタンを押された時
    @IBAction func comentButton(_ sender: Any) {
        // ログイン済みかどうか。ポストデータがひきわたされているか
        if let myid = Auth.auth().currentUser?.uid,let data = self.postData {
            // 更新データを作成する
            var updateValue: FieldValue
            // 今回新たにいいねを押した場合は、myidを追加する更新データを作成
            updateValue = FieldValue.arrayUnion([myid])
            // likesに更新データを書き込む
            let postRef = Firestore.firestore().collection(Const.PostPath).document(data.id)
            postRef.updateData(["likes": updateValue])
        }
        // 投稿処理が完了したので先頭画面に戻る
        UIApplication.shared.windows.first{ $0.isKeyWindow }?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    //キャンセルボタン
    @IBAction func cancelButton(_ sender: Any) {
        // 加工画面に戻る
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
}





/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 */
