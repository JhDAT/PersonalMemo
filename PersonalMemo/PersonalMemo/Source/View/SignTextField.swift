//
//  signTextField.swift
//  PersonalMemo
//
//  Created by Jo JANGHUI on 2018. 9. 8..
//  Copyright © 2018년 JhDAT. All rights reserved.
//

import UIKit

@IBDesignable
final class SignTestField: UITextField {
    
    @IBInspectable var leftImage: UIImage? {
        get { return (leftImage as? UIImageView)?.image}
        set {
            // 지정된 랜더링 모드로 새 이미지 객체를 만들어서 반환
            let image = newValue?.withRenderingMode(.alwaysTemplate)
            
            let leftImage = UIImageView(image: image)
            leftImage.tintColor = UIColor.black
            
            // 오버레이 보기 배치
            leftView = leftImage
            
            // 오버레기 보기 표시 시기
            leftViewMode = .always
            
        }
    }
    
}
