//
//  MemoFromVC.swift
//  PersonalMemo
//
//  Created by Jo JANGHUI on 2018. 9. 3..
//  Copyright © 2018년 JhDAT. All rights reserved.
//

import UIKit

class MemoFromVC: UIViewController {
    
    var subject: String!
    
    //MARK: - IBOutlet
    @IBOutlet weak var contents: UITextView!
    @IBOutlet weak var preview: UIImageView!
    
    //MARK: - viewDidLoad
    @IBAction func save(_ sender: Any) {
        guard self.contents.text?.isEmpty == false else {
            let alert = UIAlertController(title: nil, message: "내용을 입력해주세요", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
        }
        
        let data = MemoData()
        
        data.title = self.subject
        data.contents = self.contents.text
        data.image = self.preview.image
        data.regdate = Date()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.memolist.append(data)
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func pick(_ sender: Any) {
        let picker = UIImagePickerController()
        
        picker.delegate = self
        // 선택한 사진 및 이미지를 수정
        picker.allowsEditing = true
        
        // 이미지 피커 화면 표시
        self.present(picker, animated:  false)
    }
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        contents.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: - UIImagePickerControllerDelegate
extension MemoFromVC : UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // 선택된 이미지를 미리보기에 표시
        self.preview.image = info[UIImagePickerControllerEditedImage] as? UIImage
        picker.dismiss(animated: true)
    }
}

extension MemoFromVC: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let contents = textView.text as NSString
        let length = ((contents.length > 15) ? 15 : contents.length)
        self.subject = contents.substring(with: NSRange(location: 0, length: length))
        
        self.navigationItem.title = subject
    }
}

// MARK: - UINavigationControllerDelegate
extension MemoFromVC : UINavigationControllerDelegate {
    
}
