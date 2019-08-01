//
//  MemoFormVc.swift
//  memoapp0801
//
//  Created by 503_18 on 01/08/2019.
//  Copyright © 2019 503_18. All rights reserved.
//

import UIKit

class MemoFormVC: UIViewController {
    //제목을 저장할 변수
    var subject : String!

    @IBAction func pick(_ sender: Any) {
        //카메라, 저장앨범, 사진 라이브러리 중의 하나를 선택하는 대화상자 출력
        let select = UIAlertController(title: "이미지 가져올 곳을 선택하세요", message: nil, preferredStyle: .actionSheet)
        select.addAction(UIAlertAction(title: "카메라", style: .default, handler: {(alert)->Void in self.presentPicker(.camera)}))
        select.addAction(UIAlertAction(title: "저장앨범", style: .default, handler: {(alert)->Void in self.presentPicker(.savedPhotosAlbum)}))
        select.addAction(UIAlertAction(title: "사진 라이브러리", style: .default, handler: {(alert)->Void in self.presentPicker(.photoLibrary)}))
        self.present(select,animated: true)
    }
    
    @IBAction func save(_ sender: Any) {
        //대화 상자 커스터 마이징
        let customAlertView = UIViewController()
        customAlertView.view = UIImageView(image: UIImage(named: "warning-icon-60"))
        customAlertView.preferredContentSize = UIImage(named: "warning-icon-60")?.size ?? CGSize.zero
        //입력한 내용이 없으면 리턴
        guard self.contents.text.isEmpty == false else{
            let alert = UIAlertController(title: "내용은 필수 입력입니다.", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .cancel))
            alert.setValue(customAlertView, forKey: "contentViewController")
            self.present(alert,animated: true)
            return
        }
        
        //데이터를 저장할 VO 인스턴스를 생성
        let data = MemoVO()
        data.title = subject
        data.content = contents.text
        data.image = preview.image
        data.regdate = Date()
        
        //공유 객체에 데이터 추가
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.memoList.append(data)
        
        //이전 뷰 컨트롤러로 돌아가기
        self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBOutlet weak var contents: UITextView!
    
    @IBOutlet weak var preview: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contents.delegate = self
        
        //배경이미지 설정
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "memo-background.png")!)
        //텍스트 뷰의 속성을 수정
        self.contents.layer.borderWidth = 0
        self.contents.layer.borderColor = UIColor.clear.cgColor
        self.contents.layer.backgroundColor = UIColor.clear.cgColor
        //줄간격 조정
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 0
        self.contents.attributedText = NSAttributedString(string: "", attributes: [NSAttributedString.Key.paragraphStyle:style])
        self.contents.text=""
    }
    
    //이미지 피커를 출력해줄 사용자 정의 메소드
    func presentPicker(_ source: UIImagePickerController.SourceType){
        //조건에 맞지 않을 때 더 이상 수행하지 않도록 하고자 할 때 guard 입니다.
        guard UIImagePickerController.isSourceTypeAvailable(source) == true else {
            let alert = UIAlertController(title: "사용할 수 없는 타입입니다.", message: nil, preferredStyle: .alert)
            let ok = UIAlertAction(title: "확인", style: .default)
            alert.addAction(ok)
            self.present(alert,animated: true)
            return
        }
        
        //이미지 피커 만들어서 출력하기
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        picker.sourceType = source
        
        self.present(picker,animated: true)

        
    }
    
    
    //화면을 터치하고 난 후 호출되는 메소드
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let bar = self.navigationController?.navigationBar
        let ts = TimeInterval(1.0)
        UIView.animate(withDuration: ts){
            bar?.alpha = (bar?.alpha == 0 ? 1 : 0)
        }
    }

}

extension MemoFormVC :  UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    //이미지를 선택했을 때 호출되는 메소드
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //선택된 이미지를 이미지 뷰에 출력
        self.preview.image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        //이미지 피커 닫기
        picker.dismiss(animated: true)
    }
}

extension MemoFormVC : UITextViewDelegate{
    //텍스트 뷰의 내용이 변경될 때 호출되는 메소드
    func textViewDidChange(_ textView: UITextView) {
        //내용을 읽어오기
        //String은 NSString으로 종종 변경해서 사용하는데
        // 그 이유는 NSSting에는 문자열 관련 메소드가 많고 사용하기 쉬운편인데
        //swift의 String은 메소드 사용법이 까다롭기 때문입니다.
        let contents = textView.text as NSString
        let length = ((contents.length > 15) ? 15 : contents.length)
        self.subject = contents.substring(with: NSRange(location: 0, length: length))
        //잘라진 문자열을 네비게이션 바에 출력
        self.navigationItem.title = subject
    }
    
}
