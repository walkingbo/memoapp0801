
import UIKit

class MemoListVC: UITableViewController {
    //AppDelegate 에 대한 참조
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    //오른쪽의 + 버튼을 눌렀을 때 호출될 메ㅗ소드
    @objc func add(_ sender: Any){
        //인터페이스 빌더에서 디자인 한 뷰 컨트롤러 인스턴스 만들기
        let memoFormVC = self.storyboard?.instantiateViewController(withIdentifier: "MemoFormVC")
        as! MemoFormVC
        //네비게이션을 이용해서 푸시
        self.navigationController?.pushViewController(memoFormVC, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //네비게이션 바의 오른쪽에 + 버튼을 추가해서 메소드 설정
        self.title = "메모 목록"
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.add(_:)))
        self.navigationItem.rightBarButtonItem = barButtonItem
        
        
        //샘플 데이터 생성
        let memo1 = MemoVO()
        memo1.title = "국토 대장정"
        memo1.content = "배낭에 여행 물품을 미리 저장하기"
        memo1.regdate = Date()
        appDelegate.memoList.append(memo1)
        
        let memo2 = MemoVO()
        memo2.title = "대표이사 미팅"
        memo2.content = "8월 14일에 광화문 본사에서 미팅"
        memo2.regdate = Date(timeIntervalSinceNow:6000)
        appDelegate.memoList.append(memo2)
        
        // SWRevealViewController 라이브러리의 revealViewController 객체를 읽어온다.
        if let revealVC = self.revealViewController() {
            // 바 버튼 아이템 객체를 정의한다.
            let btn = UIBarButtonItem()
            btn.image = UIImage(named: "sidemenu.png") // 이미지는 sidemenu.png로
            btn.target = revealVC // 버튼 클릭 시 호출할 메소드가 정의된 객체를 지정
            btn.action = #selector(revealVC.revealToggle(_:)) // 버튼 클릭 시 revealToggle(_:) 호출
            // 정의된 바 버튼을 내비게이션 바의 왼쪽 아이템으로 등록한다.
            self.navigationItem.leftBarButtonItem = btn
            // 제스처 객체를 뷰에 추가한다.
            self.view.addGestureRecognizer(revealVC.panGestureRecognizer())
        }
    }
    
    //화면에 다시 출력될 때 호출되는 메소드
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }

    // MARK: - Table view data source
       // Group 의 개수를 설정하는 Method
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    // 행의 개수를 설정하는 Method
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appDelegate.memoList.count
    }

    //셀 설정하는 메소드
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     //행번호에 해당하는 데이터를 가져오기
        let row = self.appDelegate.memoList[indexPath.row]
        //이미지가 있으면 셀 id는 memoCellWithImage
        //이미지가 없은면 셀 id는 memoCell
        let cellId = row.image == nil ? "memoCell" : "memoCellWithImage"
        //셀을 생성
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! MemoCell
        //내용을 출력
        cell.subject?.text = row.title
        cell.contents?.text = row.content
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        cell.regdate?.text = format.string(from: row.regdate!)
        cell.img?.image = row.image
        
        
        return cell
    }
    
    //셀의 높이를 설정하는 메소드
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //하위 뷰 컨트롤러 생성
        let memoReadVC = self.storyboard?.instantiateViewController(withIdentifier: "MemoReadVC") as! MemoReadVC
        memoReadVC.memoVO = appDelegate.memoList[indexPath.row]
        self.navigationController?.pushViewController(memoReadVC, animated: true)
    }
 

}
