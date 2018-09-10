//
//  SignInViewController.swift
//  PersonalMemo
//
//  Created by Jo JANGHUI on 2018. 9. 8..
//  Copyright © 2018년 JhDAT. All rights reserved.
//

import UIKit
import Firebase

class SignInVC: UIViewController {
    
    //MARK: - IBOutlet
    @IBOutlet weak var email: SignTestField!
    @IBOutlet weak var password: SignTestField!
    
    //MARK: - IBAction
    @IBAction func singInButton(_ sender: UIButton) {
        guard let email = email.text else { return }
        guard let password = password.text else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] (user, error) in
            guard let strongSelf = self else { return }
            guard error == nil else { return
                strongSelf.alert(text: error!.localizedDescription, false)
            }
            strongSelf.alert(text: "로그인에 성공했습니다.", true)
        }
    }
    
    func alert(text: String,_ isSuccess: Bool) {
        let controller = UIAlertController(title: nil,
                                           message: text,
                                           preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default) { [weak self] (action) in
            guard let strongSelf = self else { return }
            switch isSuccess {
            case true:
                let vc = strongSelf.storyboard?.instantiateViewController(withIdentifier: "MemoListTVC") as! MemoListTVC
                strongSelf.navigationController?.pushViewController(vc, animated: true)
            case false:
                strongSelf.email.text = nil
                strongSelf.password.text = nil
            }
        }
        controller.addAction(ok)
        present(controller, animated: true, completion: nil)
    }
}
