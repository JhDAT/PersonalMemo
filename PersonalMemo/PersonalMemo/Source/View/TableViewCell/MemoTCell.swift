//
//  MemoTCell.swift
//  PersonalMemo
//
//  Created by Jo JANGHUI on 2018. 9. 3..
//  Copyright © 2018년 JhDAT. All rights reserved.
//

import UIKit

class MemoTCell: UITableViewCell {

    //MARK: - IBOutlet
    @IBOutlet weak var subject: UILabel!        // 제목
    @IBOutlet weak var contents: UILabel!       // 내용
    @IBOutlet weak var regdate: UILabel!        // 등록일
    @IBOutlet weak var img: UIImageView!        // 이미지
}
