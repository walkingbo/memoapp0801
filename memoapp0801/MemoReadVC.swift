//
//  MemoReadVC.swift
//  memoapp0801
//
//  Created by 503_18 on 01/08/2019.
//  Copyright © 2019 503_18. All rights reserved.
//

import UIKit

class MemoReadVC: UIViewController {
    
    @IBOutlet weak var subject: UILabel!
    @IBOutlet weak var contents: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    var memoVO : MemoVO?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //제목과 내용, 이미지를 출력
        self.subject.text = memoVO?.title
        self.contents.text = memoVO?.content
        self.img.image = memoVO?.image
        //날짜 포맷 변환
        let formatter = DateFormatter()
        formatter.dateFormat = "dd일 HH:mm분에 작성됨"
        let dateString = formatter.string(from: (memoVO?.regdate)!)
        // 내비게이션 타이틀에 날짜를 표시
        self.navigationItem.title = dateString
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
