//
//  SideBarVC.swift
//  memoapp0801
//
//  Created by 503_18 on 02/08/2019.
//  Copyright © 2019 503_18. All rights reserved.
//

import UIKit

class SideBarVC: UITableViewController {

    let titles = ["새글 작성 하기", "계정 관리"]
    let icons = [UIImage(named: "icon01.png"), UIImage(named: "icon02.png")]
    
    let nameLabel = UILabel()
    let emailLabel = UILabel()
    let profileImage = UIImageView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // HeaderView 로 사용할 View 생성
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 70))
        headerView.backgroundColor = UIColor.black
        self.tableView.tableHeaderView = headerView
        
        // 이름 Label 만들기
        nameLabel.frame = CGRect(x: 70, y: 15, width: 100, height: 30)
        nameLabel.text = "Ci"
        nameLabel.textColor = UIColor.white
        nameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        nameLabel.backgroundColor = UIColor.clear
        headerView.addSubview(nameLabel)
        
        // Eamil Label 만들기
        emailLabel.frame = CGRect(x: 70, y: 35, width: 100, height: 30)
        emailLabel.text = "cs.khris.1010@apple.com"
        emailLabel.textColor = UIColor.white
        emailLabel.font = UIFont.boldSystemFont(ofSize: 10)
        emailLabel.backgroundColor = UIColor.clear
        headerView.addSubview(emailLabel)
        
        // Profile Image 만들기
        profileImage.image = UIImage(named: "account.jpg")
        profileImage.frame = CGRect(x: 10, y: 10, width: 50, height: 50)
        
        profileImage.layer.cornerRadius = (profileImage.frame.width/2) // Image Round 처리
        profileImage.layer.borderWidth = 3
        profileImage.layer.borderColor = UIColor.blue.cgColor
        profileImage.layer.masksToBounds = true
        
        headerView.addSubview(self.profileImage)

    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            // 목적지 View Controller 생성
            let destination = self.storyboard?.instantiateViewController(withIdentifier: "MemoFormVC") as! MemoFormVC
            
            // Navigation Controller 가져오기
            let target = self.revealViewController()?.frontViewController as! UINavigationController
            
            // 화면 이동
            target.pushViewController(destination, animated: true)
            
            // Menu 를 숨기기
            self.revealViewController()?.revealToggle(self)
        }
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath)
        
        cell.textLabel?.text = titles[indexPath.row]
        cell.imageView?.image = icons[indexPath.row]
        
        return cell

    }
    

   
}
